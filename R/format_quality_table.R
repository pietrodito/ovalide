#' Title
#'
#' @param champ
#' @param statut
#' @param finess
#'
#' @return
#' @export
#'
#' @examples
format_quality_table <-  function(nature, finess) {

  ## TODO refactor compartiment = champ + statut
    ovalide_tables <- the[[ovalide_tables(nature)]]

    if (is.null(ovalide_tables)) {
      warning(no_ovalide_data(nature))
      return(invisible())
    }

    quality_mco_table_name <- "T1Q0QSYNTH_1"
    quality_table_name <- get(quality_table(nature))

    (
      ovalide_tables[[quality_table_name]]
    )
}
