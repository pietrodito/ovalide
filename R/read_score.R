#' Read saved score
#'
#' @param champ
#' @param statut
#'
#' @return
#' @export
#'
#' @examples
read_score <- function(champ = "mco", statut = "dgf") {

  score_filepath <- glue::glue("data/{champ}_{statut}/score.csv")
  internal_var <- glue::glue("{champ}_{statut}_scores")

   the[[internal_var]] <- readr::read_csv(score_filepath)
}
