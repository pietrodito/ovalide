#' Load ovalide table stored data in `the` internal state
#'
#' @param nature
#'
#' @return list of ovalide table dataframes
#' @export
#'
#' @examples
load_ovalide_tables <- function(nature) {

  tables_varlist <- ovalide_tables(nature)
  rds_filepath <- rds_filepath(nature)

  the[[tables_varlist]] <- readr::read_rds(rds_filepath)
  invisible()
}

