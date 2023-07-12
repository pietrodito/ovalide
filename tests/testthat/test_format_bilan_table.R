library(ovalide)

read_ovalide_tables("mco", "dgf")
ch_guise   <- "020000022"
roseraie   <- "020000386"
st_quentin <- "020000063"
had_chauny <- "020010898"
lespoir    <- "590797387"

format_bilan_table <- purrr::quietly(format_bilan_table)


test_that("MCO bilan works", {
  quiet_output <- format_bilan_table("mco", "dgf", finess = ch_guise)
  bilan <- quiet_output$result

  expect_equal(ncol(bilan), 7)
  expect_equal(nrow(bilan), 13)
})

check_all_bilan_variables_are_treated <- function() {
  (
    the$mco_dgf_scores$Finess
    %>% purrr::map(~ format_bilan_table("mco", "dgf", .x))
    %>% purrr::map(~ dplyr::filter(.x, is.na(Variable)))
    %>% purrr::keep(~ nrow(.x) > 0)
  ) -> result

  expect_equal(length(result), 0)


  read_ovalide_tables("mco", "oqn")
  (
    the$mco_oqn_scores$Finess
    %>% purrr::map(~ format_bilan_table("mco", "oqn", .x))
    %>% purrr::map(~ dplyr::filter(.x, is.na(Variable)))
    %>% purrr::keep(~ nrow(.x) > 0)
  ) -> result

  expect_equal(length(result), 0)
  ### Il n'existe pas de noms courts de variable non mapped to label
}

test_that("MCO bilan variable works", {
  silence <- purrr::quietly(check_all_bilan_variables_are_treated)()
})


test_that("HAD bilan works", {
  read_ovalide_tables("had", "dgf")

  quiet_output <-
    format_bilan_table("had", "dgf", finess = ch_guise)
  bilan <- quiet_output$result

  expect_equal(ncol(bilan), 5)
  expect_equal(nrow(bilan), 8)
})


test_that("SSR bilan works", {
  read_ovalide_tables("ssr", "dgf")

  quiet_output <-
    format_bilan_table("ssr", "dgf", finess = ch_guise)
  bilan <- quiet_output$result

  expect_equal(ncol(bilan), 5)
  expect_equal(nrow(bilan), 5)
})

test_that("PSY bilan works", {
  read_ovalide_tables("psy", "dgf")

  quiet_output <-
    format_bilan_table("psy", "dgf", finess = st_quentin)
  bilan <- quiet_output$result

  expect_equal(ncol(bilan), 10)
  expect_equal(nrow(bilan), 5)
})
