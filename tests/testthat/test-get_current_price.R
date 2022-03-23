current_price <- get_current_price("btcusd")
current_prices <- get_current_price()



test_that("all current prices are retrieved", {

  check_status()

  ## Current price should be either double/numeric or integer
  expect_match(class(current_price), "numeric|integer")
  expect_s3_class(current_prices, "data.frame")

  expect_length(current_prices, 2)

})

test_that("non-existent pair throws an error", {

  check_status()

  expect_error(get_current_price("pair does not exist"))

})
