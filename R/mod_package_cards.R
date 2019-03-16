#' @title mod_package_cards_ui and mod_package_cards_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_package_cards
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_package_cards_ui <- function(id){
  ns <- NS(id)
  tagList(
    #uiOutput(ns("package_cards"))
    textOutput(ns("package_cards"))
  )
}

# Module Server

#' @rdname mod_package_cards
#' @export
#' @keywords internal
#' 
#' @import dplyr
#' @import purrr

mod_package_cards_server <- function(input, output, session, package_recommended){
  ns <- session$ns
  
  observeEvent(
    input$get_tagged, {
      output$package_cards <- renderText(input$tag)
      # output$package_cards <- renderUI({
      #   get_tagged_packages(package_tags = input$tag, 
      #                       package_recommended = package_recommended) %>%
      #     pmap(box_output)
      # })
    }
  )
}

box_output <- function(package, recommended, cran_link, github_link, notes, description, tidyverse, ...){
  tagList(
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
  )
}