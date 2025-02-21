# Test for read_real_estate_json(), from load_real_estate.R

test_that("read_real_estate_json() returns a dataframe with correct structure", {
  df <- read_real_estate_json()
  
  expect_s3_class(df, "data.frame")
  expect_true("latitude" %in% colnames(df))
  expect_true("longitude" %in% colnames(df))
  expect_true("price" %in% colnames(df))
  expect_true("url" %in% colnames(df))
})
