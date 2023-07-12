#' Read table data from zip ovalide file
#'
#' @param zip_filepath the zip file path
#' @param champ the PMSI champ
#' @param statut private or public status
#'
#' @return NULL
#' @export
#'
#' @examples
#' read_zip_table_file("file.zip", "had", "oqn")
#'
#' # can be called with `progressr::with_progress`
#' with_progressr(read_zip_table_file("file.zip", "had", "oqn"))
#'
#' # can also be called with `progressr::withProgressShiny`
read_zip_table_file <- function(zip_filepath,
                                champ = c("mco", "had", "ssr", "psy"),
                                statut = c("dgf", "oqn")) {

  fs::dir_create(unzip_location())
  withr::defer(fs::dir_delete("./tmp"))

  prepare_csv_files(zip_filepath)

  dfs <- read_all_csv_files()

  save_all_tibbles_to_rds(dfs, champ, statut)
}

columns_to_discard <- c("champ",
                        "statut",
                        "date du resultat",
                        "ipe",
                        "per_comp",
                        "date_comp",
                        "temp_comp")

unzip_location <- function() glue::glue(".{tempdir()}/")

prepare_csv_files <- function(zip_filepath) {
  silent_unzip(zip_filepath)
  remove_readme_file()
  rename_csv_files()
}

silent_unzip <- function(zip_filepath) {
  silent <- TRUE
  shell_command <- glue::glue("unzip {zip_filepath} -d {unzip_location()}")
  system(shell_command, intern = silent)
  invisible()
}

remove_readme_file <- function() {
  fs::file_delete(glue::glue("{unzip_location()}/LisezMoi.txt"))
}

rename_csv_files <- function() {
  old_names <- fs::dir_ls(unzip_location())
  dir_name <- dirname(old_names[1])
  ((
    old_names
    %>% basename()
    %>% stringr::str_sub(start = 14L, end = -5L)
    %>% stringr::str_remove("[:digit:]+\\.")
    %>% stringr::str_to_upper()
    %>% stringr::str_c(dir_name, "/", .)
  ) -> new_names)
  fs::file_move(old_names, new_names)
}

read_all_csv_files <- function() {

  future::plan(future::multisession)
  filepaths <- fs::dir_ls(unzip_location())
  filenames <- basename(filepaths)

  p <- progressr::progressor(along = filepaths)
  N <- length(filepaths)

  silent_read_csv <- function(csv_filepath) {
    p(basename(csv_filepath))
    read_csv2 <- purrr::quietly(readr::read_csv2)
    quiet_output <- read_csv2(csv_filepath,
                              locale = readr::locale(encoding = "WINDOWS-1252"))
    dplyr::select(quiet_output$result,
                  - dplyr::any_of(columns_to_discard))
  }
  (
    filepaths
    %>% furrr::future_map(silent_read_csv)
  ) -> dfs
  names(dfs) <- filenames
  dfs
}

save_all_tibbles_to_rds <- function(dfs, champ, statut) {
  data_save_dir <- glue::glue("./data/{champ}_{statut}")
  fs::dir_create(data_save_dir)

  data_save_path <- glue::glue("{data_save_dir}/ovalide.rds")
  readr::write_rds(dfs, data_save_path)

  invisible()
}
