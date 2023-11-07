test_that("output dimension matches", {
  out <- .wfh_predictor()
  expect_length(out, 2)
  expect_length(out$selection$p0, N)
  expect_length(out$frequency$p0, N)
  expect_length(out$frequency, 6)
})

test_that("all probabilities are > 0", {
  out <- .wfh_predictor()
  expect_true(all(unlist(out) > 0))
})

test_that("all probabilities are < 1", {
  out <- .wfh_predictor()
  expect_true(all(unlist(out) < 1))
})

test_that("`wfh_predictor` creates same output data as before", {
  out <- .wfh_predictor()
  expected <- readRDS(test_path("fixtures", "wfh_predictor_data.rds"))
  expect_equal(out, expected)
})
