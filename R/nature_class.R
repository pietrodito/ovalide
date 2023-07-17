#' Title
#'
#' @param champ
#' @param statut
#'
#' @return
#' @export
#'
#' @examples
nature <- function(champ, statut) {
  structure(
    list(champ = champ,
         statut = statut),
    class = "ovalide_nature"
  )
}

produce_UseMethod <- function(generic_name) {
  assign(x = generic_name,
         value = function(x) {
           UseMethod(generic_name)
           },
         envir = parent.env(environment()))
}

generics <- c(
  "suffixe",
  "score_filepath",
  "score",
  "ovalide_tables",
  "rds_filepath",
  "no_ovalide_data",
  "report_proper_column_names",
  "report_columns_to_select",
  "quality_table_name"
); purrr::walk(generics, produce_UseMethod)

suffixe.ovalide_nature <- function(nature) {
  stringr::str_c(nature$champ, "_", nature$statut)
}

score_filepath.ovalide_nature <- function(nature) {
  glue::glue("data/{nature$champ}_{nature$statut}/score.csv")
}

score.ovalide_nature <- function(nature) {
  glue::glue("{nature$champ}_{nature$statut}_scores")
}

rds_filepath.ovalide_nature <- function(nature) {
  glue::glue("./data/{nature$champ}_{nature$statut}/ovalide.rds")
}

ovalide_tables.ovalide_nature <- function(nature) {
  glue::glue("{nature$champ}_{nature$statut}_ovalide")
}

no_ovalide_data.ovalide_nature <- function(nature) {
  glue::glue(
    "There is no ovalide data for {nature$champ} {nature$statut}")
}

report_proper_column_names.ovalide_nature <- function(nature) {
    get(glue::glue("proper_{nature$champ}_colonnes"))
}

report_columns_to_select.ovalide_nature <- function(nature) {
    get(glue::glue("colonnes_{nature$champ}_select"))
}

quality_table_name.ovalide_nature <- function(nature) {
  glue::glue("quality_{nature$champ}_table_name")
}
