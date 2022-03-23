# Information on crypto exchanges
df_exchanges <- get_exchanges()
exchange_kraken <- get_exchanges("kraken")

test_that("output is of expected type", {

  check_status()

  expect_type(exchange_kraken, "list")
  expect_s3_class(df_exchanges, "data.frame")

  expect_length(exchange_kraken, 5)
  expect_length(df_exchanges, 5)

})

test_that("non-existent exchange throws an error", {

  check_status()

  expect_error(get_exchanges("exchange does not exist"))

})
