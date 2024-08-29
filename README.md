
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
#>  [1] "6aa099f4-f537-49e7-b2b6-b8c252dc2fe2"
#>  [2] "c8827214-5623-40e5-971e-197983b859b9"
#>  [3] "bcd6e914-beb7-41c0-b70d-9495e0187e90"
#>  [4] "a30456c5-d622-4d34-8c80-e52c5afeed4b"
#>  [5] "98bea9cc-d82a-4f79-96a7-553dd5cc3c3e"
#>  [6] "f21bb2fd-3f15-407e-a78e-723a094b6686"
#>  [7] "af76e80a-45e7-460e-a024-b9c3e2165cd3"
#>  [8] "63e6354a-caf9-4947-82bf-cf6164274530"
#>  [9] "e08c90be-90c0-42e5-88ac-02b3f833ac67"
#> [10] "8a5da940-9f89-4679-9f20-0f01961cec4d"
```

Or you can generate v7 UUIDs ~2.5x slower than `uuid`

``` r
new_v7(10)
#>  [1] "01917f2b-2f88-7642-82fe-e8a9a097d301"
#>  [2] "01917f2b-2f88-74bd-9029-46995e531243"
#>  [3] "01917f2b-2f88-7bcb-aaca-4e81a8d41899"
#>  [4] "01917f2b-2f88-7e8f-8bcd-0874deeb3657"
#>  [5] "01917f2b-2f88-7fd9-8fe1-acd9205af00a"
#>  [6] "01917f2b-2f88-7b34-86a9-f118bba6a852"
#>  [7] "01917f2b-2f88-7c5c-beff-53ab4c4c7316"
#>  [8] "01917f2b-2f88-7353-9e07-4dcd9831f3b9"
#>  [9] "01917f2b-2f88-7975-83d9-da160c2cb29d"
#> [10] "01917f2b-2f88-7748-a1d3-b6a4c88d18d1"
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
#> [2] "8c6d8454-dcda-405b-8e28-fe85fb4551c0"
#> [3] "c"
```

It can also have a prefix added to it:

``` r
x <- c("a", NA, "c")

# x has been imputed 
impute_uuid(x, prefix = "NA_")
x
#> [1] "a"                                      
#> [2] "NA_af225b72-2f1e-40a0-86c7-5bb993d4d849"
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
#> 3 NA_col_a_06d4ad99-978c-4039-93e8-c09aa012be0a
#>                                           col_b
#> 1                                             a
#> 2 NA_col_b_9b9e9dff-d9e4-471a-9607-43615f0fd12a
#> 3                                             c
#>                                           col_c
#> 1 NA_col_c_c82b2a6c-4f67-44d4-8020-c8bd5774234c
#> 2                                           and
#> 3                                            me
```

### Short uuids:

Generate short uuid string (default flickrBase58 alphabet)

``` r
n <- 10
new_short(n)
#>  [1] "aAyKCaje9FWAPdX8bd9DaK" "rkJG79fEvriq9gRksfSjBK" "sGgKgRUFNgNUFhgYhLXa51"
#>  [4] "46Gvz7S67Gc9TfVcEtsiRV" "5PWXFxi3b1cG5rK8EKp2ze" "n1kEJuXjT3Gibux8SGcN3h"
#>  [7] "fWV3GnFi1E2YYBAN6ryux2" "jSz13jD2atFXmztcAMtMRW" "wrn4ZXzHRKerGtQKJiDPGU"
#> [10] "e2hK9NgrQfMVjZFF8CXVob"
```

Bitcoin58 example:

``` r
new_short(n, "bitcoin58")
#>  [1] "StfvTyN7hxXMpXJAJeuoqu" "1fesAAnvCcnw99gHinKifD" "J75ALp6dP8yHVwygVNYCc9"
#>  [4] "7yqdHPx9vq11m2SoYetha9" "RD1rTBnLJid8CvbhFSUsua" "By9FgEcqgY2bDVU4ndSPDy"
#>  [7] "Xyd8DoZJWngDnthxqeF7hP" "MpkJunKciXBduvLosMHJ8H" "4i8oDfN8oxUKR6y2MZ3Ri5"
#> [10] "QN7LbG8gWzXpRJnNE7XcKS"
```

Convert uuid V4 to short (default flickrBase58 alphabet)

``` r
uuids <- new_v4(n)
uuids
#>  [1] "eeba13ff-d7f2-4bbb-a3af-05a0a444b648"
#>  [2] "1da5d818-5373-4e2d-8576-6f112aaeab33"
#>  [3] "8b4dc566-ee69-4bed-a13e-4a1f8201de91"
#>  [4] "c1113abe-5d3b-4793-aa24-2bdbdd31af2d"
#>  [5] "7cecfa63-da45-44bc-8840-63b874dcf619"
#>  [6] "26c3eda6-93f0-4334-b272-7bc7f89e7f15"
#>  [7] "310322e8-79ea-4cbb-9204-0b40143d98f3"
#>  [8] "66002302-ced2-4ce7-8eeb-a4ed93fc70b8"
#>  [9] "f2ebde18-0daf-41db-a8dd-b691f2a87aef"
#> [10] "f473ed24-77b5-4fc7-97cd-321c5fe47906"
```

``` r
su_flickr <- uuid_to_short(uuids)
su_flickr
#>  [1] "vtMoSduPhYgHCKDEdZGJQQ" "4EkJTzEvzdbuFJCEzLuCrZ" "icGWJoDXdLfLb3sq78hPCv"
#>  [4] "pQLn2gaMUnPhnQ4MJdAQfR" "gqJgsMeDrBc3RsjJ4Z2rbZ" "5MDaACF8jfkJY6fQiAH71n"
#>  [7] "742JZANKL4deGpwdWWXnjT" "dAx8xXMMJe1YYA1qdHjLmy" "vZPMNXWHaZMhaKQpFq5f4a"
#> [10] "wbMY9CHyGRWXknsbAaBAgh"
```

``` r
su_bitcoin <- uuid_to_short(uuids, "bitcoin58")
su_bitcoin
#>  [1] "WUnPsDVpHyGidkefDzhjqq" "4fLjtafWaDBVgjdfamVdSz" "JChwjPexDmFmB3TR78HpdW"
#>  [4] "QqmN2GAnuNpHNq4njDbqFr" "GRjGTnEeScC3rTKj4z2SBz" "5neAbdg8KFLjy6FqJbi71N"
#>  [7] "742jzbokm4DEhQXDwwxNKt" "DbY8YxnnjE1yyb1RDiKmMZ" "WzpnoxwiAznHAkqQgR5F4A"
#> [10] "XBny9diZhrwxLNTBbAcbGH"
```

Convert short uuid to uuid (default flickrBase58 alphabet)

``` r
uuids2 <- short_to_uuid(su_flickr)
uuids2
#>  [1] "eeba13ff-d7f2-4bbb-a3af-05a0a444b648"
#>  [2] "1da5d818-5373-4e2d-8576-6f112aaeab33"
#>  [3] "8b4dc566-ee69-4bed-a13e-4a1f8201de91"
#>  [4] "c1113abe-5d3b-4793-aa24-2bdbdd31af2d"
#>  [5] "7cecfa63-da45-44bc-8840-63b874dcf619"
#>  [6] "26c3eda6-93f0-4334-b272-7bc7f89e7f15"
#>  [7] "310322e8-79ea-4cbb-9204-0b40143d98f3"
#>  [8] "66002302-ced2-4ce7-8eeb-a4ed93fc70b8"
#>  [9] "f2ebde18-0daf-41db-a8dd-b691f2a87aef"
#> [10] "f473ed24-77b5-4fc7-97cd-321c5fe47906"
```

``` r
uuids3 <- short_to_uuid(su_bitcoin, "bitcoin58")
uuids3
#>  [1] "eeba13ff-d7f2-4bbb-a3af-05a0a444b648"
#>  [2] "1da5d818-5373-4e2d-8576-6f112aaeab33"
#>  [3] "8b4dc566-ee69-4bed-a13e-4a1f8201de91"
#>  [4] "c1113abe-5d3b-4793-aa24-2bdbdd31af2d"
#>  [5] "7cecfa63-da45-44bc-8840-63b874dcf619"
#>  [6] "26c3eda6-93f0-4334-b272-7bc7f89e7f15"
#>  [7] "310322e8-79ea-4cbb-9204-0b40143d98f3"
#>  [8] "66002302-ced2-4ce7-8eeb-a4ed93fc70b8"
#>  [9] "f2ebde18-0daf-41db-a8dd-b691f2a87aef"
#> [10] "f473ed24-77b5-4fc7-97cd-321c5fe47906"
```

comparison

``` r
identical(uuids, uuids2)
#> [1] TRUE
identical(uuids, uuids3)
#> [1] TRUE
```
