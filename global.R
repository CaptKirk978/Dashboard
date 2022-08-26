library(shiny)
library(bs4Dash)
library(waiter)
library(leaflet)
library(vroom)
library(tidygeocoder)


incidentFiles <- list.files(path = "./IMPD/incidents/", pattern = "*.csv", full.names = T)

incidents <- vroom(incidentFiles)

incidents <- geocode(incidents, "blocksizedAddress", method = "arcgis")

write.csv(incidents, file = "/IMPD/incidents/incidents_geocoded.csv")

leaflet() %>% 
  addTiles() %>% 
  addMarkers(
    lng = incidents$lng,
    lat = incidents$lat
  )

library(usethis)

use_git_config(
  user.name = "Bailey Kirk",
  user.email = "0_recheck.sugar@icloud.com"
)



























