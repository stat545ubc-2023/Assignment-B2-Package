test_that("Output matches direct call to dplyr", {
  small_tbl <- tibble::tribble(~group, ~var1, ~var2,
                       "A", 1, NA,
                       "A", 2, "x",
                       "B", NA, "y",
                       "C", 3, "z") #make tibble for test

  expect_equal( small_tbl |> dplyr::group_by(group) |>
                  dplyr::summarize(dplyr::across(dplyr::everything(), ~sum(is.na(.x))),
                            .groups = "drop"),
                count_all_missing_by_group(small_tbl, group)
  ) #expect that the output of the function is equal to direct call to dplyr and groups are dropped by default

  expect_equal( small_tbl |> dplyr::group_by(group) |>
                  dplyr::summarize(dplyr::across(dplyr::everything(), ~sum(is.na(.x))),
                            .groups = NULL),
                count_all_missing_by_group(small_tbl, group, NULL)
  ) #expect that the output of the function is equal to direct call to dplyr
})

test_that("Checking error handling for .groups input", {
  small_tbl2 <- tibble::tribble(~group, ~var1, ~var2,
                              "A", 1, "w",
                              "A", 2, "x",
                              "B", 2, "y",
                              "C", 3, "z") #make tibble for test
  expect_error(
    count_all_missing_by_group(small_tbl2, group, "kep")
  ) #expect error when the given .groups argument is not an acceptable input
  expect_no_error(
    count_all_missing_by_group(small_tbl2, group, NULL)
  ) #expect no error when .groups argument is specified as NULL
})
