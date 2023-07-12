test_that("unzip and save had dgf ", {
 (
   testthat::test_path("test_data/had.dgf.2023.4.ovalide-tables-as-csv.zip")
   %>% read_zip_table_file(champ = "had", statut = "dgf")
 )

  #withr::defer(fs::dir_delete("data"))

  rds_result_path <- "data/had_dgf/ovalide.rds"
  expected_file_size <- 1147464L
  actual_size <- fs::file_size(rds_result_path) %>% as.integer()
  expect_equal(actual_size, expected_file_size)
})


test_that("unzip and save psy oqn ", {
 (
   testthat::test_path("test_data/psy.oqn.2023.4.ovalide-tables-as-csv.zip")
   %>% read_zip_table_file(champ = "psy", statut = "oqn")
 )

  #withr::defer(fs::dir_delete("data"))

  rds_result_path <- "data/psy_oqn/ovalide.rds"
  expected_file_size <- 1675507L
  actual_size <- fs::file_size(rds_result_path) %>% as.integer()
  expect_equal(actual_size, expected_file_size)
})

