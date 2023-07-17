#' Read saved score
#'
#' @param nature
#'
#' @return
#' @export
#'
#' @examples
read_score <- function(nature) {
   the[[score(nature)]] <- readr::read_csv(score_filepath(nature))
}
