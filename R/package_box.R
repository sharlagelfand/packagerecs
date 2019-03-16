#' @export
package_box <- function(package, recommended, cran_link, github_link, notes, description, tidyverse, ...){
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