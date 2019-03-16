#' @import shiny
#' @import dplyr
#' @import purrr
app_server <- function(input, output, session) {
  
  output$recommended_packages <- renderUI({
    res <- 
      packages %>%
      filter(map_lgl(tags, ~ all(input$tags %in% .x)),
             recommended)
    
    if(nrow(res) > 0 & length(input$tags) > 0){
      tagList(
        res %>%
          pmap(box_output)
      )
    }
  })
  
  output$not_recommended_packages <- renderUI({
    res <- 
      packages %>%
      filter(map_lgl(tags, ~ all(input$tags %in% .x)),
             !recommended)
    
    if(nrow(res) > 0 & length(input$tags) > 0){
      tagList(
        res %>%
          pmap(box_output)
      )
    }
  })
}

box_output <- function(package, recommended, cran_link, github_link, notes, description, tidyverse, ...){
  box(
    title = package,
    status = ifelse(recommended, "success", "danger"),
    width = NULL,
    if(recommended){
      tagList(
        if(tidyverse){
          tagList(
            paste0(emo::ji("star"), "Tidyverse friendly", emo::ji("star")),
            HTML("<br><br>")
          )
        },
        description,
        HTML("<br><br>"),
        
        if(!is.na(cran_link)){
          enurl(cran_link, cran_link)
        },
        HTML("<br>"),
        enurl(github_link, github_link)
      )
    },
    if(!recommended){
      renderText({
        glue("{notes}")
      })
    }
  )
}