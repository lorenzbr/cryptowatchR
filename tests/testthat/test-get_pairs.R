# Information on pairs of currencies
pair_btcusd <- get_pairs("btcusd")
# df_pairs <- get_pairs()

test_that("output is of expected type", {

  check_status()

  expect_type(pair_btcusd, "list")
  # expect_s3_class(df_pairs, "data.frame")

  expect_length(pair_btcusd, 6)
  # expect_length(df_pairs, 14)

})

test_that("non-existent pair throws an error", {

  check_status()

  expect_error(get_pairs("pair does not exist"))

})
