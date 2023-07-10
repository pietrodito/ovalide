fs::dir_create("data/mco_dgf/")
fs::dir_create("data/psy_oqn/")
# withr::defer(fs::dir_delete("data"))

read_score_csv_file <- purrr::quietly(read_score_csv_file)
read_score          <- purrr::quietly(read_score)

test_that("lit fichier score champ mco", {
  read_score_csv_file(testthat::test_path(
    "test_data/mco_dgf.csv"), "mco", "dgf")
  read_score("mco", "dgf")
  expect_equal(ncol(the$mco_dgf_scores), 21)
})

test_that("lit fichier score champ psy", {
  read_score_csv_file(testthat::test_path(
    "test_data/psy_oqn.csv"), "psy", "oqn")
  read_score("psy", "oqn")
  expect_equal(ncol(the$psy_oqn_scores), 27)
})
