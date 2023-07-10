#' Format volume table
#'
#' @param champ
#' @param statut
#'
#' @return
#' @export
#'
#' @examples
format_volume_table <- function(champ = "mco", statut = "dgf", finess) {

  ovalide_tables <- the[[glue::glue("{champ}_{statut}_ovalide")]]

  if(is.null(ovalide_tables)) {
    warning(glue::glue("There is no ovalide data for {champ} {statut}"))
    return(invisible())
  }

   mapping_nom_colonnes <- tibble::tribble(
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
    "nbabott"    ,  "Nb de RSA avec diag d explantation du DM Abbott"
    )


  colonnes_mco_select <- c("_NAME_",
                           "COL1", "COL2", "COL3",
                           "COL4", "COL5", "COL6")

  colonnes_had_select <- c("libel",
                           "COUNT",
                           "count1",
                           "evol")

  proper_had_colonnes <- c(
    "short_name",
    "Année n",
    "Année n-1",
    "Évolution %")

  proper_mco_colonnes <- c(
    "short_name",
    "Année n",
    "Année n-1",
    "Évolution %",
    "Année n (Mars)",
    "Année n-1 (Mars)",
    "Évolution % (Mars)")

  proper_nom_colonnes <- get(glue::glue("proper_{champ}_colonnes"))
  colonnes_pour_select <- get(glue::glue("colonnes_{champ}_select"))

  rename_proper <- function(df) {
    names(df) <- proper_nom_colonnes
    df
  }

  proper_variable <- function(df) {
    (
      df
      %>% dplyr::left_join(mapping_nom_colonnes)
      %>% dplyr::mutate(Variable = ifelse(is.na(Variable), short_name, Variable))
      %>% dplyr::select(ncol(.), 2:(ncol(.) - 1))
    )
  }

  (
    ovalide_tables[["T1D2RTP_1"]]
    %>% dplyr::filter(stringr::str_detect(finess_comp, finess))
      %>% dplyr::filter(dplyr::row_number() != 1)
      %>% dplyr::select(all_of(colonnes_pour_select))
      %>% rename_proper()
      %>% proper_variable()
      %>% dplyr::mutate(dplyr::across(
        dplyr::starts_with("Évolution"),
        ~ scales::percent(as.numeric(.) / 100)
      ))
  )
}
