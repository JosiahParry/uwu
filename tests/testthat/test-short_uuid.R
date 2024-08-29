UUID <- "bf34000c-3779-4519-a82f-8c8b45b80dab"
UUID_FALSE <- c(UUID, NA, "123")

test_that("check uuid short", {
  flickr <- new_short(1)
  bitcoin <- new_short(1, "bitcoin58")
  expect_equal(nchar(flickr), 22)
  expect_equal(nchar(bitcoin), 22)
  expect_true(all(grepl("[0-9a-zA-Z]{22}", c(flickr, bitcoin))))
})

test_that("check flickr encoding", {
  expect_equal(uuid_to_short(UUID) , "pBpYVoXrShgRxX5o3yg6Kz")
  expect_equal(uuid_to_short(UUID_FALSE) , c("pBpYVoXrShgRxX5o3yg6Kz", NA, NA))
})

test_that("check bitcoin encoding", {
  expect_equal(uuid_to_short(UUID, "bitcoin58"), "QcQyvPxSsHGrYx5P3ZG6ka")
  expect_equal(uuid_to_short(UUID_FALSE, "bitcoin58") , c("QcQyvPxSsHGrYx5P3ZG6ka", NA, NA))
})

test_that("check flickr roundhouse", {
  short_uuid <- uuid_to_short(UUID)
  expect_equal(short_to_uuid(short_uuid) , UUID)
})

test_that("check bitcoin58 roundhouse", {
  short_uuid <- uuid_to_short(UUID, "bitcoin58")
  expect_equal(short_to_uuid(short_uuid, "bitcoin58") , UUID)
})

test_that("check flickr false uuid short", {
  short_uuid <- c("pBpYVoXrShgRxX5o3yg6Kz", NA, "abc")
  expect_equal(short_to_uuid(short_uuid), c(UUID, NA, NA))
})

test_that("check bitcoin58 false uuid short", {
  short_uuid <- c("QcQyvPxSsHGrYx5P3ZG6ka", NA, "abc")
  expect_equal(short_to_uuid(short_uuid, "bitcoin58"), c(UUID, NA, NA))
})

test_that("check mixed short alphabet encoding", {
  # flickr short uuid
  short_uuid <- "pBpYVoXrShgRxX5o3yg6Kz"
  expect_equal(short_to_uuid(short_uuid, "bitcoin58"), NA_character_)

  # bitcoin58 short uuid
  short_uuid <- "QcQyvPxSsHGrYx5P3ZG6ka"
  expect_equal(short_to_uuid(short_uuid), NA_character_)
})
