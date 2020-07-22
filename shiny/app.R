library(productorapp)
# plan(multiprocess)

options(shiny.sanitize.errors = FALSE)

ui <- dashboardPage(
  dashboardHeader(title = "PRODUCTOR"),
  dashboardSidebar(
    sidebarMenu(
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
    )
  ),
  dashboardBody(
    ### BEGIN TAB ITEMS
    tabItems(
      ### DASHBOARD
      tabItem(
        tabName = 'dashboard',
        fluidRow(
          spinnerbox(plotOutput("tidyverseDownloads"), 12)
        )
      ),
      ### LINKS
      tabItem(
        tabName = "links",
        fluidPage(
          airflow_image_box(),
          repo_image_box()
        )
      )
    )
  )
)

server <- function(input, output) {
  output$tidyverseDownloads <- renderPlot({
    plot_tidyverse_downloads()
  })

}

shinyApp(ui, server)