# Module UI
  
#' @title   mod_package_card_ui and mod_package_card_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_package_card
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_package_card_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_package_card
#' @export
#' @keywords internal
    
mod_package_card_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_package_card_ui("package_card_ui_1")
    
## To be copied in the server
# callModule(mod_package_card_server, "package_card_ui_1")
 
