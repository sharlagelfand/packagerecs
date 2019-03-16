#' @export
packages_output <- function(tagged_packages, package_recommended, input){
  renderUI({
    res <- tagged_packages %>%
      dplyr::filter(recommended == package_recommended)
    
    if(nrow(res) > 0 & length(input$tags) > 0){
      tagList(
        res %>%
          purrr::pmap(packagerecs::package_box)
      )
    }
  })
}