## Set pair
pair <- "btcusd"

## Get trades
# Most recent trades (default is 50)
trades <- get_trades(pair)
# 100 trades
trades_100 <- get_trades(pair, limit = 100, datetime = FALSE)
# 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
trades_unix <- get_trades(pair, since = 1589571417, limit = 200, datetime = FALSE)
# 1000 trades and datetime is TRUE
trades_datetime <- get_trades(pair, since = "2021-06-01", limit = 1000)


test_that("output are data frames", {

  check_status()

  output_type <- "data.frame"

  expect_s3_class(trades, output_type)
  expect_s3_class(trades_100, output_type)
  expect_s3_class(trades_unix, output_type)
  expect_s3_class(trades_datetime, output_type)

})

test_that("data frames have expected dimension", {

  check_status()

  col_length <- 4

  expect_length(trades, col_length)
  expect_length(trades_100, col_length)
  expect_length(trades_unix, col_length)
  expect_length(trades_datetime, col_length)

  expect_equal(nrow(trades_100), 100)
  expect_equal(nrow(trades_unix), 200)
  expect_equal(nrow(trades_datetime), 1000)

})

test_that("dates are of expected type", {

  check_status()

  posixct_type <- "POSIXct"
  num_type <- "numeric"

  expect_match(class(trades$Timestamp)[1], posixct_type)
  expect_match(class(trades_100$Timestamp)[1], num_type)
  expect_match(class(trades_unix$Timestamp)[1], num_type)
  expect_match(class(trades_datetime$Timestamp)[1], posixct_type)

})

test_that("non-existent pair throws an error.", {

  check_status()

  expect_error(get_trades("pair does not exist"))

})
