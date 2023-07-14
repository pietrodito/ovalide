test_that("unzip and save had dgf ", {
 (
   testthat::test_path("test_data/had.dgf.2023.4.ovalide-tables-as-csv.zip")
   %>% read_zip_table_file(nature("had", "dgf"))
 )


  rds_result_path <- "data/had_dgf/ovalide.rds"
  expected_file_size <- 1144977L
  actual_size <- fs::file_size(rds_result_path) %>% as.integer()
  expect_equal(actual_size, expected_file_size)
})


test_that("unzip and save psy oqn ", {
 (
   testthat::test_path("test_data/psy.oqn.2023.4.ovalide-tables-as-csv.zip")
   %>% read_zip_table_file(nature("psy", "oqn"))
 )


  rds_result_path <- "data/psy_oqn/ovalide.rds"
  expected_file_size <- 1663424L
  actual_size <- fs::file_size(rds_result_path) %>% as.integer()
  expect_equal(actual_size, expected_file_size)
})

