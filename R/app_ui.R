#' @import shiny
#' @import shinydashboard
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    # from inst/app/www
    golem_add_external_resources(),
    golem::js(),
    golem::favicon(),
    # List the first level UI elements here 
    dashboardPage(
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
  )
}

golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'rpackagerecs')
  )
 
  tagList(
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
