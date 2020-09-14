library(productorapp)
# plan(multiprocess)



options(shiny.sanitize.errors = FALSE)
SERVER = Sys.getenv('SERVER')

ui <- dashboardPage(
  dashboardHeader(title = paste0('PRODUCTOR ', SERVER)),
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
          box(actionButton("goButton", "Go!", width = '100%'), width = 12),
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
    input$goButton
    plot_tidyverse_downloads()
  })

}

shinyApp(ui, server)