UUID_REGEX <- "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"

test_that("check new_v4", {
  uuid <- new_v4(1)
  expect_equal(nchar(uuid), 36)
  expect_true(grepl(UUID_REGEX, uuid))
})

test_that("check new_v7", {
  uuid <- new_v7(1)
  expect_equal(nchar(uuid), 36)
  expect_true(grepl(UUID_REGEX, uuid))
})

test_that("check impute_uuid", {
  data <- list(
    actual = c("a", NA, "c"),
    expect = c("a", UUID_REGEX, "c")
  )
  impute_uuid(data$actual)
  for (i in seq_along(data$actual)) {
    expect_true(
      grepl(data$expect[i], data$actual[i])
    )
  }
})
