library(shiny)
library(dplyr)
library(purrr)
library(shinydashboard)
library(glue)
library(emo)

packages <- readRDS("packages.rds")

ui <- dashboardPage(
  dashboardHeader(
    title = "Package Explorer"
  ),
  
  dashboardSidebar(
    selectizeInput(
      inputId = "tags",
      label = "Tags",
      choices = unique(unlist(packages[["tags"]])),
      selected = NULL,
      multiple = TRUE
    )
  ),
  
  dashboardBody(
    fluidRow(
      column(
        width = 6,
        title = "Recommended packages",
        uiOutput("recommended_packages")
      ),
      
      column(
        width = 6,
        title = "Not Recommended",
        uiOutput("not_recommended_packages")
      )
    )
  )
)

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

enurl <- function(url, text){
  tags$a(href = url, text, target = "_blank")
}

server <- function(input, output) {
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

# Run the application 
shinyApp(ui = ui, server = server)