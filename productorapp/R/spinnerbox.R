#' @importFrom shinydashboard box
#' @importFrom shinycssloaders withSpinner
#' @export spinnerbox
spinnerbox <- function(output, width = 12) {
  box(withSpinner(output), width = width)
}
