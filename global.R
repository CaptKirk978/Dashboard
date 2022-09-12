library(shiny)
library(bs4Dash)
library(waiter)
library(leaflet)
library(vroom)
library(dplyr)
library(lubridate)

######### Indy Incident map data ###########
filesIncident <- list.files(path = "./indy/incidents/", pattern = "*.csv", full.names = T)

rawIncidents <- vroom(filesIncident) %>% 
  distinct(`id`, .keep_all = T) %>% 
  rename("Lat" = "location.type",
         "Long" = "location.coordinates",
         "Address" = "incidentType")
rawIncidents$Lat <- gsub(")", "", rawIncidents$Lat, fixed = T)
rawIncidents$Long <- gsub("c(", "", rawIncidents$Long, fixed = T)

agencies <- tibble("agencyId" = 109542,
                   "Agency" = "IMPD")

incidents <- agencies %>% 
  left_join(rawIncidents, by = "agencyId") 


##### Salary Data ###########


salary <- read.csv("Data salary/ds_salaries.csv")




##### UCR Data ##############













