# Get liquidity sums in the order book of Bitcoin in USD
liquidity <- get_orderbook_liquidity("btcusd")

# Live quote for 50 Bitcoins
calculator <- get_orderbook_calculator("btcusd", amount = 50)

test_that("output are of expected type", {

  check_status()

  output_type <- "data.frame"

  expect_s3_class(calculator$buy, output_type)
  expect_s3_class(calculator$sell, output_type)
  expect_s3_class(liquidity$ask, output_type)
  expect_s3_class(liquidity$bid, output_type)

})
