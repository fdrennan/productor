library(productorapp)

options(shiny.sanitize.errors = FALSE)

AIRFLOW_HOST <- Sys.getenv('AIRFLOW_HOST')
NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')

ui <- dashboardPage(
  dashboardHeader(title = "PRODUCTOR"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Dashboard",
      tabName = "dashboard",
      icon = icon("chart-bar")
    ),
    menuItem(
      "Production Links",
      tabName = "links",
      icon = icon("dashboard")
    )
  )),
  dashboardBody(tabItems(
    tabItem(tabName = 'dashboard',
            fluidRow(box(
              withSpinner(dataTableOutput("progressBox")), width = 12
            ))),
    tabItem(tabName = "links",
            fluidPage(
              box(tags$a(
                href = glue("http://{AIRFLOW_HOST}:8080"),
                tags$image(src = "https://ndexr-images.s3.us-east-2.amazonaws.com/airflow.png",
                           title = "Airflow",
                           width = "100%")
              ),
              width = 3),
              box(
                tags$a(
                  href = "https://github.com/fdrennan/productor",
                  tags$image(src = "https://ndexr-images.s3.us-east-2.amazonaws.com/github.png",
                             title = "Get the Repo",
                             width = "100%")
                ),
                width = 3
              )
            ))
  ))
)

server <- function(input, output) {
  output$progressBox <- renderDataTable({
    package_downloads <-
      GET(url = glue('http://{NGINX_HOST_NAME}/api/package_downloads')) %>%
      content(type = 'text') %>%
      fromJSON %>%
      .$data %>%
      fromJSON
    
    package_downloads
  })
  
}

shinyApp(ui, server)