#' @export
get_tagged_packages <- function(package_tags){
  packagerecs::packages %>%
    dplyr::filter(purrr::map_lgl(tags, ~ all(package_tags %in% .x)))
}