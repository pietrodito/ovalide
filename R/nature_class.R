#' @export
nature <- function(champ, statut) {
  structure(
    list(champ = champ,
         statut = statut),
    class = "ovalide_nature"
  )
}

#' @export
suffixe <- function(x) {UseMethod("suffixe")}
#' @export
suffixe.ovalide_nature <- function(nature) {
  stringr::str_c(nature$champ, "_", nature$statut)
}

#' @export
score_filepath <- function(x) {UseMethod("score_filepath")}
#' @export
score_filepath.ovalide_nature <- function(nature) {
  glue::glue("data/{nature$champ}_{nature$statut}/score.csv")
}

#' @export
score <- function(x) {UseMethod("score")}
#' @export
score.ovalide_nature <- function(nature) {
  glue::glue("{nature$champ}_{nature$statut}_scores")
}

#' @export
rds_filepath <- function(x) {UseMethod("rds_filepath")}
#' @export
rds_filepath.ovalide_nature <- function(nature) {
  glue::glue("./data/{nature$champ}_{nature$statut}/ovalide.rds")
}

#' @export
no_ovalide_data <- function(x) {UseMethod("no_ovalide_data")}
#' @export
no_ovalide_data.ovalide_nature <- function(nature) {
  glue::glue(
    "There is no ovalide data for {nature$champ} {nature$statut}")
}

#' @export
ovalide_tables <- function(x) {UseMethod("ovalide_tables")}
#' @export
ovalide_tables.ovalide_nature <- function(nature) {
  glue::glue("{nature$champ}_{nature$statut}_ovalide")
}

#' @export
report_proper_column_names <- function(x) {
  UseMethod("report_proper_column_names")}
#' @export
report_proper_column_names.ovalide_nature <- function(nature) {
    get(glue::glue("proper_{nature$champ}_colonnes"))
}

#' @export
report_columns_to_select <- function(x) { UseMethod("report_columns_to_select")}
#' @export
report_columns_to_select.ovalide_nature <- function(nature) {
    get(glue::glue("colonnes_{nature$champ}_select"))
}

#' @export
quality_table_name <- function(x) { UseMethod("quality_table_name")}
#' @export
quality_table_name.ovalide_nature <- function(nature) {
  glue::glue("quality_{nature$champ}_table_name")
}
