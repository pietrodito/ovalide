read_score_file <- function(csv_filepath,
                            champ = c("mco", "had", "ssr", "psy"),
                            statut = c("dgf", "oqn")) {
  readr::read_csv2(csv_filepath)
}

