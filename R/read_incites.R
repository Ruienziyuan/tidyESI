#' @title read incites files
#'
#' @param ... file name (named by organization name), now only support `csv` file format
#'
#' @return data.frame including five columns (univ, discipline, year, n_paper, n_cited)
#' @export
#'
#' @examples
#' df <- read_incites("filename.csv")
#' or
#' here::here("data") %>%
#'   fs::dir_ls(regexp = "\\.csv$") %>%
#'   read_incites()
#'
#'
read_incites <- function(...) {

  library(dplyr)

  arguments <- unlist(list(...))
  k <- length(arguments)
  D <- list()

  for (i in 1:k) {
    D[[i]] <-
      readr::read_csv(arguments[i]) %>%
      dplyr::select(
        discipline = "名称",
        year_range = "出版年",
        n_paper = "Web of Science 论文数",
        n_cited = "被引频次"
      ) %>%
      dplyr::filter(!is.na(year_range)) %>%
      dplyr::mutate(year_range = as.character(year_range)) %>%
      dplyr::mutate(discipline = stringr::str_to_title(discipline)) %>%
      dplyr::mutate(
        univ = stringr::str_split(arguments[i], "/") %>%
          unlist() %>%
          dplyr::last() %>%
          stringr::str_extract(., ".*?(?=\\.)") %>%
          stringr::str_to_title()
      ) %>%
      dplyr::relocate(univ, discipline, year_range)
  }

  purrr::map_dfr(D, bind_rows) %>%
    as_tbl_esi()

}
