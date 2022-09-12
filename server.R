
server = function(input, output) {
  
  output$mapWithPoints <- renderLeaflet({
    map <- incidents %>% 
      filter(`date` >= input$mapRange[1], `date` <= input$mapRange[2])
    
    leaflet(data = map) %>% 
      addTiles() %>% 
      addCircleMarkers(
        lng = as.numeric(map$Long),
        lat = as.numeric(map$Lat),
        radius = 5,
        popup = paste(map$Agency,
                      "<br>",
                      map$parentIncidentType,
                      "<br>",
                      map$Address
                      ),
        clusterOptions = markerClusterOptions()
      )
    
  })
  
  
}
