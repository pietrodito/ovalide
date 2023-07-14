#' Read ovalide table stored data
#'
#' @param champ
#' @param statut
#'
#' @return list of ovalide table dataframes
#' @export
#'
#' @examples
read_ovalide_tables <- function(nature) {

  tables_varlist <- ovalide_tables(nature)
  rds_filepath <- rds_filepath(nature)

  the[[tables_varlist]] <- readr::read_rds(rds_filepath)
  invisible()
}

