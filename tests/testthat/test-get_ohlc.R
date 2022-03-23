test_that("output are data frames with price information", {

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
                                      before = Sys.Date(), after = Sys.Date() - 5,
                                      exchange, datetime = TRUE)

  # Daily prices using date/datetime variables
  df_ohlc_daily_datetime <- get_ohlc(pair, periods = 86400,
                                     before = "2021-05-12", after = "2021-01-01",
                                     exchange, datetime = TRUE)

  # Daily prices using POSIX time
  df_ohlc_daily_posix <- get_ohlc(pair, periods = 86400,
                                  before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                                  after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")),
                                  exchange, datetime = FALSE)

  ## Expect that output are data frames
  expect_match(class(df_ohlc_daily), "data.frame")
  expect_match(class(df_ohlc_hourly), "data.frame")
  expect_match(class(df_ohlc_hourly_datetime), "data.frame")
  expect_match(class(df_ohlc_daily_datetime), "data.frame")
  expect_match(class(df_ohlc_daily_posix), "data.frame")

  ## Expect that data frame has 7 columns
  expect_equal(length(df_ohlc_daily), 7)
  expect_equal(length(df_ohlc_hourly), 7)
  expect_equal(length(df_ohlc_hourly_datetime), 7)
  expect_equal(length(df_ohlc_daily_datetime), 7)
  expect_equal(length(df_ohlc_daily_posix), 7)

})
