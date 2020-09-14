#' @importFrom dplyr mutate
#' @importFrom ggplot2 ggplot aes geom_line xlab ylab ggtitle theme scale_x_date
#' @importFrom drenplot dren_theme
#' @export parse_response
plot_tidyverse_downloads <- function() {
  NGINX_HOST_NAME <- Sys.getenv('LOCALHOST_IP')
  message('Grabbing package downloads')
  response_tibble <-
    parse_response(GET(url = glue('http://{NGINX_HOST_NAME}/api/package_downloads'))) %>%
    mutate(start_date = ymd(start_date),
           downloads = as.numeric(downloads))
  message('Gathered package downloads')
  message('Plotting package downloads')

  ggplot(response_tibble) +
    aes(x = start_date, y = log(downloads)) +
    geom_line() +
    xlab('Start Date') +
    ylab('log(Downloads)') +
    ggtitle('Number of Downloads for the Tidyverse Package') +
    scale_x_date(labels = date_format("%Y-%m-%d"), breaks = "3 month") +
    theme(axis.text.x = element_text(angle = 0, vjust = NULL, hjust=NULL)) +
    dren_theme()
}
