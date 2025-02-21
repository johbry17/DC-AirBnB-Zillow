# Test for read_airbnb_csv(), from load_airbnb.R

test_that("read_airbnb_csv() returns a dataframe with correct structure", {
  df <- read_airbnb_csv()
  
  expect_s3_class(df, "data.frame")
  expect_true("neighborhood" %in% colnames(df))
  expect_true("shortNeighborhood" %in% colnames(df))
  expect_false(any(df$price >= 3000))
})
