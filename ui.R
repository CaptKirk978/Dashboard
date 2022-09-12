
###########################
#                         #
# Created by Bailey Kirk  #
# on 8/10/2022            #
#                         #
###########################



#dashboard content
ui = dashboardPage(
  title = "Bailey Kirk's Dashboard",
  scrollToTop = T,
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
      sidebarHeader("Dashboards"),
      menuItem(
        "Data Analyst Salaries",
        tabName = "salary",
        icon = icon("money-bill-trend-up")
      ),
      menuItem(
        "Crime Map",
        icon = icon("map"),
        menuSubItem(
          text = "Crime Points",
          tabName = "crimePoints",
          icon = icon("map-location-dot")
        ),
        menuSubItem(
          text = "Crime Areas",
          tabName = "crimeMap2",
          icon = icon("layer-group")
        )
      )
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem(
        tabName = "salary",
        h1("hello")
      ),
      tabItem(
        tabName = "crimePoints",
        leafletOutput("mapWithPoints", height = 700),
        absolutePanel(top = 30, 
                      right = 10,
                      dateRangeInput("mapRange",
                                     "Date Range: ",
                                     start = max(rawIncidents$date),
                                     end = max(rawIncidents$date),
                                     min = min(rawIncidents$date),
                                     max = max(rawIncidents$date)
                      )
          )
      ),
      tabItem(
        tabName = "crimeMap2",
        h1("hello3")
      )
    )
  ),
  controlbar = dashboardControlbar(
    
  ),
  footer = dashboardFooter(
    
  )
)























