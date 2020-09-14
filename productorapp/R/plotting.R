# library(productorapp)
# NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')
#' @importFrom httr content
#' @importFrom jsonlite fromJson
#' @export parse_response
parse_response <- function(response) {
  fromJSON(fromJSON(content(response, type = 'text'))$data)
}

