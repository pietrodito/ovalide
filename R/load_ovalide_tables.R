#' Load ovalide table stored data in `the` internal state
#'
#' @param nature
#' @param force
#'
#' @return list of ovalide table dataframes
#' @export
#'
#' @examples
load_ovalide_tables <- function(nature, force = FALSE) {

  tables_varlist <- ovalide_tables(nature)

  if (is.null(the[[tables_varlist]]) || force) {
    rds_filepath <- rds_filepath(nature)
    the[[tables_varlist]] <- readr::read_rds(rds_filepath)
  }
  invisible()
}
