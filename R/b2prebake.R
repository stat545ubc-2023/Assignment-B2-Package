#' @title Count missing values for all columns by group
#'
#' @description Given a data frame `data` and a
#' column `group`, `count_all_missing_by_group()` creates
#' a new data frame with one row per level of `group`.
#' The first column of the output data frame
#' contains the levels of `group`, and the rest of
#' the columns contain the number of missing values for
#' all columns in `data` except `group`.
#'
#' @details This function is
#' a wrapper around the `group_by()` and
#' `summarize()` functions in the `dplyr` package.
#'
#' @param data Data in data.frame or tibble format
#' @param group_col Column in `data` to group by
#' @param .groups (OPTIONAL) Controls whether the
#' output data frame is grouped. By default,
#' drops all levels of grouping (`"drop"`). Specify
#' `"keep"` to keep the output data frame grouped by
#' `group`. See `summarize()` documentation in
#' `dplyr` for a full list of options.
#'
#' @return A data frame or tibble with the
#' levels of `group`, and the  number of NAs within
#' each level of `group` for all columns in
#' `data` except `group`.
#'
#' @examples
#' # Computes the number of missing values in 'small_tbl' grouped by `group`.
#' library(dplyr)
#' small_tbl <- tribble(~group,~var1,~var2,"A",1,NA,"A",2,"x","B",NA,"y","C",3,"z")
#' count_all_missing_by_group(small_tbl, group)
#' # Alternative way to invoke the function using piping, output same as above
#' small_tbl |> count_all_missing_by_group(group)
#' # Optional `.groups` argument allows us to keep the output grouped by the
#' # grouping column. Below, the output tibble is grouped, rather than ungrouped,
#' # as was the case above.
#' count_all_missing_by_group(small_tbl, group, .groups = "keep")
#'
#' @export
count_all_missing_by_group <- function(data, group_col, .groups = "drop") {

  if(!is.null(.groups)) {
    if(!(.groups %in% c("drop_last", "drop",
                        "keep", "rowwise"))) {
      stop(".groups needs to be one of NULL,
         \"drop_last\", \"drop\", \"keep\",
         and \"rowwise\".") #if the .groups argument is not an acceptable input, return error with message
    }
  }

  data |> dplyr::group_by({{ group_col }}) |> #group by group_col argument
    dplyr::summarize(dplyr::across(dplyr::everything(), ~sum(is.na(.x))),
              .groups = .groups) #count number of missing values in all columns and return new summarised data frame
}
