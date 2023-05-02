
###########################
#                         #
# Created by Bailey Kirk  #
# on 8/10/2022            #
#                         #
###########################



#dashboard content
ui = dashboardPage(
  title = "Bailey Kirk's Dashboard",
  fullscreen = T,
  header = dashboardHeader(
    title = dashboardBrand(
      title = "My dashboard",
      color = "primary",
      #href = "https://baileykirk.something", # update to my url 
      image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png"
    )
  ),
  sidebar = dashboardSidebar(
    collapsed = F,
    sidebarMenu(
      id = "sidebarmenu",
      sidebarHeader("Crime Map"),
      menuItem("Crime Filters",
               checkboxGroupInput("crime_filter", label = h3("Options:"),
                                  choices = list("Proactive Policing" = "Proactive Policing",
                                                 "Quality of Life" = "Quality of Life",
                                                 "Property Crime" = "Property Crime",
                                                 "Breaking & Entering" = "Breaking & Entering",
                                                 "Fire" = "Fire",
                                                 "Robbery" = "Robbery",
                                                 "Assault" = "Assault",
                                                 "Theft" = "Theft",
                                                 "Theft of Vehicle" = "Theft of Vehicle",
                                                 "Theft from Vehicle" = "Theft from Vehicle",
                                                 "Emergency" = "Emergency",
                                                 "Sexual Offense" = "Sexual Offense",
                                                 "Homicide" = "Homicide",
                                                 "Community Policing" = "Community Policing"),
                                  selected = unique(incidents$parentIncidentTypeId)
                                  )
              )
            )
  ),
  body = dashboardBody(
        leafletOutput("map_with_points", height = 700),
        absolutePanel(top = 30, 
                      right = 10,
                      dateRangeInput("mapRange",
                                     "Date Range: ",
                                     start = max(incidents$date),
                                     end = max(incidents$date),
                                     min = min(incidents$date),
                                     max = max(incidents$date)
                      )
          )
  )
)























