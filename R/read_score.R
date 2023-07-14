#' Read saved score
#'
#' @param champ
#' @param statut
#'
#' @return
#' @export
#'
#' @examples
read_score <- function(nature) {
   the[[score(nature)]] <- readr::read_csv(score_filepath(nature))
}
