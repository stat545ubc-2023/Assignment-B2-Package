
<!-- README.md is generated from README.Rmd. Please edit that file -->

# B2Prebake

<!-- badges: start -->
<!-- badges: end -->

The goal of B2Prebake is to provide a function to simplify counting
missing values for all columns of a data frame by group.

## Installation

You can install the development version of B2Prebake like so:

``` r
devtools::install_github("https://github.com/stat545ubc-2023/B2Prebake/tree/main", ref = "0.1.0")
```

## Example

``` r
library(B2Prebake)
library(dplyr) #load relevant packages
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

‘count_all_missing_by_group’ can compute the number of missing values in
the ‘small_tbl’ tibble grouped by the `group` variable.

``` r
small_tbl <- tibble::tribble(~group,~var1,~var2,"A",1,NA,"A",2,"x","B",NA,"y","C",3,"z") # make example tibble
count_all_missing_by_group(small_tbl, group) # count_all_missing_by_group use example
#> # A tibble: 3 × 3
#>   group  var1  var2
#>   <chr> <int> <int>
#> 1 A         0     1
#> 2 B         1     0
#> 3 C         0     0
```

Using the optional ‘.groups’ argument, we can keep the output tibble
grouped by the grouping column. The output tibble below remains grouped,
in contrast to the output tibble above.

``` r
small_tbl <- tibble::tribble(~group,~var1,~var2,"A",1,NA,"A",2,"x","B",NA,"y","C",3,"z") # make example tibble
count_all_missing_by_group(small_tbl, group, .groups = "keep") # count_all_missing_by_group with groups retained
#> # A tibble: 3 × 3
#> # Groups:   group [3]
#>   group  var1  var2
#>   <chr> <int> <int>
#> 1 A         0     1
#> 2 B         1     0
#> 3 C         0     0
```
