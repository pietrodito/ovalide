library(ovalide)


check_all_score_variables_are_treated <- function() {
  ############### MCO DGF #################
  read_score_csv_file(testthat::test_path("./test_data/mco_dgf.csv"),
                      "mco",
                      "dgf")
  read_ovalide_tables("mco", "dgf")

  ### Y A-T-IL AUTRES NOMS DE VARIABLES
  ### récupérer tous les finess dans le fichier score

  read_score("mco", "dgf")

  (
    the$mco_dgf_scores$Finess
    %>% purrr::map( ~ format_volume_table("mco", "dgf", .x))
    %>% purrr::map( ~ dplyr::filter(.x, is.na(Variable)))
    %>% purrr::keep( ~ nrow(.x) > 0)
  ) -> result

  assertthat::assert_that(length(result) == 0)

  ### Il n'existe pas de noms courts de variable non mapped to label

  ############### MCO OQN #################
  read_score_csv_file(testthat::test_path("./test_data/mco_oqn.csv"),
                      "mco",
                      "oqn")
  read_ovalide_tables("mco", "oqn")

  ### Y A-T-IL AUTRES NOMS DE VARIABLES
  ### récupérer tous les finess dans le fichier score

  read_score("mco", "oqn")

  (
    the$mco_oqn_scores$Finess
    %>% purrr::map( ~ format_volume_table("mco", "oqn", .x))
    %>% purrr::map( ~ dplyr::filter(.x, is.na(Variable)))
    %>% purrr::keep( ~ nrow(.x) > 0)
  ) -> result

  assertthat::assert_that(length(result) == 0)

  ### Il n'existe pas de noms courts de variable non mapped to label

}

## Use it to test format_volume but lasts 30s.
purrr::quietly(check_all_score_variables_are_treated)()

read_ovalide_tables("mco", "dgf")

############### HAD DGF #################

ch_guise <- "020000022"

read_ovalide_tables("had", "dgf")
## error
format_volume_table("had", "dgf", finess = ch_guise)
## ✖ Column `_NAME_` doesn't exist.


dplyr::filter(the$had_dgf_ovalide[["T1D2RTP_1"]],
              stringr::str_detect(ipe, "020000022"),
              mois == 4)

names(the$had_dgf_ovalide)


read_ovalide_tables("had", "oqn")
format_RSA_table("had", "oqn")

read_ovalide_tables("psy", "dgf")
format_RSA_table("psy", "dgf")
read_ovalide_tables("psy", "oqn")
format_RSA_table("psy", "oqn")
read_ovalide_tables("ssr", "dgf")
format_RSA_table("ssr", "dgf")
read_ovalide_tables("ssr", "oqn")
format_RSA_table("ssr", "oqn")
