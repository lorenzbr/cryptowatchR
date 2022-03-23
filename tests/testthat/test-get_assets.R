# Asset information
df_assets <- get_assets()
asset_btc <- get_assets("btc")

test_that("output is of expected type", {

  check_status()

  expect_type(asset_btc, "list")
  expect_s3_class(df_assets, "data.frame")

  expect_length(df_assets, 5)
  expect_length(asset_btc, 5)

})

test_that("non-existent asset throws an error", {

  check_status()

  expect_error(get_assets("asset does not exist"))

})
