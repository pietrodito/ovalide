library(ovalide)


test_read_ovalide_zip <- function(champ = "mco", statut = "dgf") {
  zip_filepath <- testthat::test_path(glue::glue(
    "test_data/{champ}.{statut}.2023.4.ovalide-tables-as-csv.zip"
  ))

  progressr::with_progress(read_zip_table_file(zip_filepath, champ, statut))
}

test_read_ovalide_zip("mco", "dgf")
test_read_ovalide_zip("mco", "oqn")
test_read_ovalide_zip("had", "dgf")
test_read_ovalide_zip("had", "oqn")
test_read_ovalide_zip("psy", "dgf")
test_read_ovalide_zip("psy", "oqn")
test_read_ovalide_zip("ssr", "dgf")
test_read_ovalide_zip("ssr", "oqn")
