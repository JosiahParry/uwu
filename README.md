
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `uwu` (ꈍᴗꈍ)♡

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the development version of uwu like so:

This requires Rust to be installed.

``` r
if (requireNamespace("pak")) install.packages("pak")
pak::pak("josiahparry/uwu")
```

## Example

Generate v4 UUIDs ~20x faster than `uuid`

``` r
library(uwu)
new_v4(10)
#>  [1] "74768c6a-2da8-49a3-8c29-19b348059b56"
#>  [2] "0713a316-5f2c-4ead-8797-6b216d50ad32"
#>  [3] "f35a09c1-709a-45fa-a4f7-e645f6c0e188"
#>  [4] "2258caf9-9964-40c5-ab9d-70c86c86b5c8"
#>  [5] "298bbade-53f1-4dc3-a6da-8ef726172da9"
#>  [6] "39b59557-53c3-4129-a54c-0af71dc73bab"
#>  [7] "52ef0f31-0615-48c4-9855-42b1d3ecf8ba"
#>  [8] "c0af3385-f6a7-4cf2-aaa4-85f0e6b5a8d0"
#>  [9] "d8d86391-34e8-4e39-97b6-872129f7863f"
#> [10] "4f26aa29-bcca-4259-b5a5-5b1b3af10eaf"
```

Or you can generate v7 UUIDs ~2.5x slower than `uuid`

``` r
new_v7(10)
#>  [1] "018ef32c-5c74-73a8-8f63-50e47f5a3898"
#>  [2] "018ef32c-5c74-728b-b902-4ddfc1ec0fc8"
#>  [3] "018ef32c-5c74-7c4c-85e1-5fc43c8d7498"
#>  [4] "018ef32c-5c74-7e4d-82b6-c008e70ed9d8"
#>  [5] "018ef32c-5c74-737d-8c5e-dbc311517997"
#>  [6] "018ef32c-5c74-7eae-9ff5-87d6b33febb6"
#>  [7] "018ef32c-5c74-7c3d-bf38-9f18fc46dad8"
#>  [8] "018ef32c-5c74-745e-a1c2-ad5c7b60cbf6"
#>  [9] "018ef32c-5c74-78e9-b2c0-6024f0467cb1"
#> [10] "018ef32c-5c74-7522-acbc-9b9ab233291e"
```

The neat part, though, is that we can impute a UUID into a character
vector by reference. This means that once the operation has occured, you
cannot take it back!!

``` r
x <- c("a", NA, "c")

# x has been imputed 
impute_uuid(x)

x
#> [1] "a"                                   
#> [2] "73442f1b-dc60-44c8-aac4-c5233344f1af"
#> [3] "c"
```

It can also have a prefix added to it:

``` r
x <- c("a", NA, "c")

# x has been imputed 
impute_uuid(x, prefix = "NA_")
x
#> [1] "a"                                      
#> [2] "NA_63cc0c5f-332d-4016-ab41-d04acc9e5e7c"
#> [3] "c"
```

Here’s an example to address the problem that prompted this.

``` r
# define a data.frame with missing values 
to_impute <- data.frame(
  col_a = c("one", "two", NA),
  col_b = c("a", NA, "c"),
  col_c = c(NA, "and", "me")
)

df_names <- colnames(to_impute)

for (j in seq_along(to_impute)) {
    impute_uuid(to_impute[[j]], paste0("NA_", df_names[j], "_"))
}

to_impute
#>                                           col_a
#> 1                                           one
#> 2                                           two
#> 3 NA_col_a_c7c2b2fe-0a8b-42df-a29b-e1bb33f4c23a
#>                                           col_b
#> 1                                             a
#> 2 NA_col_b_19040ca5-7c56-45b6-892e-5643764c73b9
#> 3                                             c
#>                                           col_c
#> 1 NA_col_c_667ee20f-d5ae-45ed-96cd-fc0f8ef9179c
#> 2                                           and
#> 3                                            me
```
