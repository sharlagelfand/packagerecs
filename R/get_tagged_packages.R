#' Keep tagged packages
#' 
#' @param input_tags
#' @param recommended
#' @import dplyr
#' @export
get_tagged_packages <- function(package_tags, package_recommended){
  packages %>%
    dplyr::filter(
      purrr::map_lgl(
        tags, 
        ~ all(package_tags %in% .x)
      ),
      recommended == package_recommended)
}
