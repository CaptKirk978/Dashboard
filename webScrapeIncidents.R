library(tidyr)
library(httr)
library(jsonlite)
library(dplyr)
library(stringr)
library(vroom)

######## http://cityprotect.com #########
#                                       #
#       City Protect Web Scraper        #
#        to retrieve incidents          #
#            in and around              #
#            Indianapolis               #
#                                       #
#        Created by Bailey Kirk         #
#             On 9/2/2022               #
#                                       #
#########################################

## Part 1 ##

# select date range and change as needed, can not go back further than 1 year from today
fromDate <- '"2023-03-01T00:00:00.000Z"'
toDate <- '"2023-05-01T23:59:59.999Z"'

# api URL
url <- "https://ce-portal-service.commandcentral.com/api/v1.0/public/incidents"

#Indy payload
payload <- paste0(
  '{"limit":2000,"offset":0,"geoJson":{"type":"Polygon","coordinates":[[[-85.954885,39.640356],[-86.327408,39.634263],[-86.327393,39.922914],[-85.958472,39.925696],[-85.954885,39.640356]]]},"projection":false,"propertyMap":{"toDate":', toDate, ',"fromDate":', fromDate, ',"pageSize":"2000","parentIncidentTypeIds":"149,150,148,8,97,104,165,98,100,179,178,180,101,99,103,163,168,166,12,161,14,16,15","zoomLevel":"15","latitude":"39.768710408143214","longitude":"-86.15357897257186","days":"1,2,3,4,5,6,7","startHour":"0","endHour":"24","timezone":"+00:00","relativeDate":"custom","agencyIds":"indy.gov,sheridanpd.org,ciceroin.org,carmel.in.gov,mcohiosheriff.org,westfield.in.gov,illinois.edu,cityoflawrence.org,speedwayin.gov,butlersheriff.org,hamiltoncounty.in.gov,noblesville.in.us,fishers.in.us,arcadiaindiana.org,perryschools.org"}}'
)


# generate response from server
response <- POST(url, add_headers("Content-Type" = "application/json"), body = payload)

# check response for errors
http_error(response)

# convert the response to JSON text
rawJson <- content(response, as = "text")

# convert JSON text to JSON readable format in R
json <- fromJSON(rawJson)

# retrieve first incidents as master data frame 
totalIncidents <- json[["result"]][["list"]][["incidents"]]

# number of incidents in data frame
incidentCount <- nrow(json[["result"]][["list"]][["incidents"]])

# total number of incidents for while loop
totalIncidentCount <- incidentCount

# counting number of requests 
requestCount <- 2

while (incidentCount > 0) {
  
  print(paste0("Loading Request: #", requestCount, " at ", format(Sys.time(), "%H:%M:%S")))
  
  # adding to the request count
  requestCount <- requestCount + 1
  
  # generating next page payload from first response and retrieving new response
  nextPayload <- json[["navigation"]][["nextPagePath"]][["requestData"]]
  payload <- toJSON(nextPayload, auto_unbox = T)
  response <- POST(url, add_headers("Content-Type" = "application/json"), body = payload)
  print(paste("http error:", http_error(response)))
  
  # converting new JSON to data frame and adding it to the existing master data frame
  rawJson <- content(response, as = "text")
  json <- fromJSON(rawJson)
  
  # counting number of incidents 
  incidentCount <- nrow(json[["result"]][["list"]][["incidents"]])
  totalIncidentCount <- totalIncidentCount + incidentCount
  print(paste("Total incidents collected:", totalIncidentCount))
  
  # collecting incidents
  incidents <- json[["result"]][["list"]][["incidents"]]
  totalIncidents <- totalIncidents %>% 
    bind_rows(incidents)
  Sys.sleep(1)
}

# removing any duplicates
output <- totalIncidents %>% 
  distinct(`id`, .keep_all = T)

# cleaning up coordinates 
output$location$coordinates <- gsub("\\(", "", output$location$coordinates)
output$location$coordinates <- gsub("\\)", "", output$location$coordinates)
output$location$coordinates <- gsub("c", "", output$location$coordinates)

# separate coordinates into respective columns
output[c('Long', 'Lat')] <- str_split_fixed(output$location$coordinates, ',', 2)

# info
print(paste("Finished with", nrow(output), "incidents logged"))

# saving output
write.csv(output, paste0("./Incidents/Raw Incidents/indyIncidents_", fromDate, "-", toDate, ".csv"), row.names = F)


## Part 2 ## Create master data set

# List all scraped data
raw_data <- list.files(path = "./Incidents/Raw Incidents/", full.names = TRUE, pattern = ".csv")

# combine all data sets
master <- vroom(raw_data)

# cleaning up coordinates if needed
master$location.coordinates <- gsub("\\(", "", master$location.coordinates)
master$location.type <- gsub("\\)", "", master$location.type)
master$location.coordinates <- gsub("c", "", master$location.coordinates)

master <- master %>% 
  rename("Long" = "location.coordinates",
         "Lat" = "location.type")

# write master data set for dashboard
write.csv(., "./Incidents/master_incidents.csv", row.names = F)



