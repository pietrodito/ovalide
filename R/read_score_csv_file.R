#' Read a csv score file and affect to the_environment
#'
#' @param csv_filepath the path of the csv file
#' @param champ name of the PMSI champ
#' @param statut private or public status
#'
#' @return
#' @export
#'
#' @examples
#' read_score_file("score.csv", "psy", "dgf")
read_score_csv_file <- function(csv_filepath,
                            champ = c("mco", "had", "ssr", "psy"),
                            statut = c("dgf", "oqn")) {

  nettoie_nom_colonnes <- if (champ == "psy") {
    nettoie_nom_colonnes_psy
  } else {
    nettoie_nom_colonnes_sauf_psy
  }

  (
    csv_filepath
    %>% readr::read_csv2()
    %>% pick_and_order_proper_columns()
    %>% nettoie_nom_colonnes()
    %>% readr::write_csv(glue::glue("data/{champ}_{statut}/score.csv"))
  )
}

pick_and_order_proper_columns <- function(df) {
  (
    df
    %>% remove_1st_and_last_column()
    %>% invert_first_and_second_column()
  )
}

invert_first_and_second_column <- function(df) {
  cols_numbers <- seq_len(ncol(df))
  cols_numbers[1:2] <- 2:1
  dplyr::select(df, cols_numbers)
}

remove_1st_and_last_column <- function(df) dplyr::select(df, -c(1, ncol(df)))

nettoie_nom_colonnes_sauf_psy <- function(df) {
  noms_colonnes <- names(df)

  replace_1.Q_by_synthese <- function(noms_colonnes) {
    ifelse(stringr::str_detect(noms_colonnes, "1\\.Q\\)"),
      "Synthèse",
      noms_colonnes
    )
  }

  remove_regex <- function(noms_colonnes, reg_exps) {
    result <- noms_colonnes

    trim_inside <- function(character_vector) {
      (
        character_vector
        %>% stringr::str_trim()
          %>% stringr::str_replace_all("[ ]+", " ")
      )
    }

    remove_one_regex <- function(regex) {
      (
        result
        %>% stringr::str_remove_all(regex)
          %>% trim_inside()
      ) ->> result
    }

    purrr::walk(reg_exps, remove_one_regex)

    result
  }

  reg_exps <- c(
    "SSRHA",
    "RHA",
    "[S|s]core",
    "Séjour",
    "sej",
    "seq",
    "Qualité",
    "partie",
    "'",
    "[(|)|:]",
    "1\\.Q.*",
    "\\\"",
    "Valorisation",
    "^\\d",
    "\\d\\..",
    " \\d$",
    "\\d_D"
  )
  (
    noms_colonnes
    %>% replace_1.Q_by_synthese()
      %>% remove_regex(reg_exps)
      %>% stringr::str_replace("dentrée", "d'entrée")
  ) -> nouveau_noms_colonnes

  names(df) <- nouveau_noms_colonnes
  df
}

nettoie_nom_colonnes_psy <- function(df) {
  noms_colonnes <- names(df)

  (
    tibble::tibble(noms_colonnes = noms_colonnes)
    %>% dplyr::mutate(
        parentheses = stringr::str_extract(noms_colonnes, "\\(.*\\)"),
        result = ifelse(is.na(parentheses), noms_colonnes, parentheses))
    %>% dplyr::pull(result)
    %>% stringr::str_remove_all("[(|)]")
  ) -> nouveau_noms_colonnes

  names(df) <- nouveau_noms_colonnes
  df
}
