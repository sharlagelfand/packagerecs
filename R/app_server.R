#' @import shiny
#' @import dplyr
#' @import purrr
app_server <- function(input, output, session) {
  
  res <- reactive(
    get_tagged_packages(input$tags)
  )
  
  output$recommended_packages <- renderUI({
    res <- res() %>%
      filter(recommended)
    
    if(nrow(res) > 0 & length(input$tags) > 0){
      tagList(
        res %>%
          pmap(package_box)
      )
    }
  })
  
  output$not_recommended_packages <- renderUI({
    res <- res() %>%
      filter(!recommended)
    
    if(nrow(res) > 0 & length(input$tags) > 0){
      tagList(
        res %>%
          pmap(package_box)
      )
    }
  })
}