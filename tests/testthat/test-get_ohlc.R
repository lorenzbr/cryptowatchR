check_status <- function() {
  request <- httr::GET( "https://api.cryptowat.ch/markets/kraken/btceur/price")
  if (!startsWith(as.character(request$status_code), "2"))
    skip("Request failed.")
}

# Settings
exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

# Daily prices of Bitcoin in USD
df_ohlc_daily <- get_ohlc(pair)

# Hourly prices
df_ohlc_hourly <- get_ohlc(pair, periods = 3600,
                           before = as.numeric(as.POSIXct(Sys.Date())),
                           after = as.numeric(as.POSIXct(Sys.Date() - 5)),
                           exchange, datetime = FALSE)

# Hourly prices using date/datetime variables
df_ohlc_hourly_datetime <- get_ohlc(pair, periods = 3600,
                                    before = Sys.Date(),
                                    after = Sys.Date() - 5,
                                    exchange, datetime = TRUE)

# Daily prices using date/datetime variables
df_ohlc_daily_datetime <- get_ohlc(pair, periods = 86400,
                                   before = "2021-05-12",
                                   after = "2021-01-01",
                                   exchange, datetime = TRUE)

# Daily prices using POSIX time
df_ohlc_daily_posix <- get_ohlc(pair, periods = 86400,
                                before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")),
                                exchange, datetime = FALSE)


test_that("output are data frames", {

  check_status()

  output_type <- "data.frame"

  expect_s3_class(df_ohlc_daily, output_type)
  expect_s3_class(df_ohlc_hourly, output_type)
  expect_s3_class(df_ohlc_hourly_datetime, output_type)
  expect_s3_class(df_ohlc_daily_datetime, output_type)
  expect_s3_class(df_ohlc_daily_posix, output_type)

})

test_that("data frames have 7 columns", {

  check_status()

  col_length <- 7

  expect_equal(length(df_ohlc_daily), col_length)
  expect_equal(length(df_ohlc_hourly), col_length)
  expect_equal(length(df_ohlc_hourly_datetime), col_length)
  expect_equal(length(df_ohlc_daily_datetime), col_length)
  expect_equal(length(df_ohlc_daily_posix), col_length)

})

test_that("dates are valid", {

  check_status()

  posixct_type <- "POSIXct"
  num_type <- "numeric"

  expect_match(class(df_ohlc_daily$CloseTime)[1], posixct_type)
  expect_match(class(df_ohlc_hourly$CloseTime)[1], num_type)
  expect_match(class(df_ohlc_hourly_datetime$CloseTime)[1], posixct_type)
  expect_match(class(df_ohlc_daily_datetime$CloseTime)[1], posixct_type)
  expect_match(class(df_ohlc_daily_posix$CloseTime)[1], num_type)

})

test_that("non-existent pair throws an error.", {

  check_status()

  expect_error(get_ohlc("pair does not exist"))

})

test_that("error is thrown when prices are not available.", {

  check_status()

  expect_error(
    get_ohlc("btcusd", periods = 3600,
             before = "2021-01-05", after = "2021-01-01",
             exchange = "kraken", datetime = TRUE)
  )

})
