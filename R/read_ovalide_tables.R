#' Read ovalide table stored data
#'
#' @param champ
#' @param statut
#'
#' @return list of ovalide table dataframes
#' @export
#'
#' @examples
read_ovalide_tables <- function(champ = "mco", statut = "dgf") {

  tables_varlist <- glue::glue("{champ}_{statut}_ovalide")
  rds_filepath <- glue::glue("./data/{champ}_{statut}/ovalide.rds")

  the[[tables_varlist]] <- readr::read_rds(rds_filepath)
  invisible()
}

