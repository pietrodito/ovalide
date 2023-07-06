read_score_file <- purrr::quietly(read_score_file)

test_that("lit fichier score champ mco", {
  quiet_output <- read_score_file(test_path("data/mco_dgf.csv"), "mco", "dgf")
  expect_equal(ncol(quiet_output$result), 21)
})

test_that("lit fichier score champ psy", {
  quiet_output <- read_score_file(test_path("data/psy_oqn.csv"), "psy", "oqn")
  expect_equal(ncol(quiet_output$result), 27)
})
