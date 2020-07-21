library(shiny)
library(shinydashboard)
library(httr)
library(jsonlite)
library(magrittr)
library(shinycssloaders)

options(shiny.sanitize.errors = FALSE)

ui <- dashboardPage(
  dashboardHeader(title = "PRODUCTOR"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("chart-bar"))
    )
  ),
  dashboardBody(
    fluidRow(
      box(withSpinner(dataTableOutput("progressBox")), width = 12)
    )
  )
)

server <- function(input, output) {
  output$progressBox <- renderDataTable({
    package_downloads <- 
      GET(url = 'http://192.168.0.33/api/package_downloads') %>% 
      content(type = 'text') %>% 
      fromJSON %>% 
      .$data %>% 
      fromJSON
    
    package_downloads
  })
  
}

shinyApp(ui, server)