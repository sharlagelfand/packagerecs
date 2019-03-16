#' @import shiny
#' @import dplyr
#' @import purrr
app_server <- function(input, output, session) {
  callModule(mod_package_cards_server, "recommended", package_recommended = TRUE)
  
  callModule(mod_package_cards_server, "not_recommended", package_recommended = FALSE)
}