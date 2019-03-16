#' @import shiny
#' @import shinydashboard
app_ui <- function() {
  tagList(
    golem::js(),
    golem::favicon(),
    # List the first level UI elements here 
    dashboardPage(
      dashboardHeader(
        title = "Package Explorer"
      ),
      
      dashboardSidebar(
        selectizeInput(
          inputId = "tag",
          label = "Tags",
          choices = unique(unlist(packages[["tags"]])),
          selected = "twitter",
          multiple = TRUE
        ),
        actionButton(
          inputId = "get_tagged",
          label = "Go!"
        )
      ),
      
      dashboardBody(
        fluidRow(
          column(
            width = 6,
            mod_package_cards_ui("recommended")
          ),
          
          column(
            width = 6,
            mod_package_cards_ui("not_recommended")
          )
        )
      )
    )
  )
}