# library(productorapp)
# NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')
#

#' @export parse_response
parse_response <- function(response) {
  response %>%
    content(type = 'text') %>%
    fromJSON %>%
    .$data %>%
    fromJSON
}



