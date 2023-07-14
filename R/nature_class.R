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

ovalide_tables.ovalide_nature <- function(nature) {
  glue::glue("{nature$champ}_{nature$statut}_ovalide")
}

rds_filepath.ovalide_nature <- function(nature) {
  glue::glue("./data/{nature$champ}_{nature$statut}/ovalide.rds")
}

no_ovalide_data.ovalide_nature <- function(nature) {
  glue::glue(
    "There is no ovalide data for {nature$champ} {nature$statut}")
}

quality_table_name.ovalide_nature <- function(nature) {
  glue::glue("quality_{champ}_table_name")
}
