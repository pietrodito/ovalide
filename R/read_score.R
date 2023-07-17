#' Read saved score
#'
#' @param nature
#'
#' @return
#' @export
#'
#' @examples
read_score <- function(nature) {
   set_score(nature, readr::read_csv(score_filepath(nature)))
}
