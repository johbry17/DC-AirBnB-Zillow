# Test for assign_neighborhood(), from label_dc_neighborhoods.R

test_that("assign_neighborhood() assigns neighborhoods correctly", {
  df <- data.frame(
    latitude = c(38.9, 38.85),
    longitude = c(-77.0, -76.95)
  )
  
  df <- assign_neighborhood(df)
  
  expect_s3_class(df, "data.frame")
  expect_true("neighborhood" %in% colnames(df))
  expect_true("shortNeighborhood" %in% colnames(df))
  expect_true(all(!is.na(df$neighborhood)))
})
