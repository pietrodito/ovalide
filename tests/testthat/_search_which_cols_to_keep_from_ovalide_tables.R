library(ovalide)

tibble_not_empty <- function(df) ncol(df) > 0

read_ovalide_tables("mco", "oqn")

(
  the$mco_oqn_ovalide
  %>% purrr::keep(tibble_not_empty)
  %>% purrr::map(colnames)
  %>% purrr::reduce(intersect)
) -> y


mapping_nom_colonnes_RSA_transmis_sur_la_période <- tibble::tribble(
 ~ short_name,   ~ Variable,
 "nbrsa"      ,  "Nb de RSA transmis"                             ,
 "cmd90"      ,  "Nb de RSA en CMD"                               ,
 "hper"       ,  "Dt Nb de RSA hors période"                      ,
 "hpern1"     ,  "Dt Nb de RSA hors période année n-1"            ,
 "hperhn1"    ,  "Dt Nb de RSA hors période année n-1"            ,
 "typsejb"    ,  "Nb de RSA prestation inter-établissement"       ,
 "ghs9999"    ,  "Nb de RSA en GHS"                               ,
 "nbrsaseance",  "Nb de RSA séances"                              ,
 "nbseances"  ,  "Nb de séances"                                  ,
 "nbrsa0"     ,  "Nb de RSA DS=0"                                 ,
 "nbjJT0"     ,  "dont Nb de J ou T0"                             ,
 "nbrsah0"    ,  "Nb de RSA hors séjour sans nuitée"              ,
 "nbjh0"      ,  "Nb de journées hors séjour sans nuitée"         ,
 "nbuhcd"     ,  "Nb de RSA en UHCD réaffecté"                    ,
 "nbabott"    ,  "Nb de RSA avec diag d explantation du DM Abbott")

proper_nom_colonnes <- c("short_name",
                         "Année n", "Année n-1", "Évolution %",
                         "Année n (Mars)", "Année n-1 (Mars)",
                         "Évolution % (Mars)")

rename_proper <- function(df) {
  names(df) <- proper_nom_colonnes
  df
}

proper_variable <- function(df) {
  (
    df
    %>% dplyr::left_join(mapping_nom_colonnes_RSA_transmis_sur_la_période)
    %>% dplyr::select(8, 2:7)
  )
}

(
  the$mco_oqn_ovalide[["T1D2RTP_1"]]
  %>% dplyr::filter(stringr::str_detect(finess_comp, "020000360"))
  %>% dplyr::filter(dplyr::row_number() != 1)
  %>% dplyr::select(`_NAME_`, dplyr::starts_with("COL"))
  %>% rename_proper()
  %>% proper_variable()
  %>% dplyr::mutate(dplyr::across(dplyr::starts_with("Évolution"),
                                  ~ scales::percent(as.numeric(.)/100)))
)

