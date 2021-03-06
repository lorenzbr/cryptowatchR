
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptowatchR

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/cryptowatchR)](https://cran.r-project.org/package=cryptowatchR)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
[![R-CMD-check](https://github.com/lorenzbr/cryptowatchR/workflows/R-CMD-check/badge.svg)](https://github.com/lorenzbr/cryptowatchR/actions)
[![Codecov test
coverage](https://codecov.io/gh/lorenzbr/cryptowatchR/branch/main/graph/badge.svg)](https://codecov.io/gh/lorenzbr/cryptowatchR?branch=main)
<!-- badges: end -->

An API wrapper for Cryptowatch written in R

## Introduction

This R package provides a wrapper for the Cryptowatch API. You can get
prices and other information (volume, trades, order books, bid and ask
prices, live quotes, and more) about cryptocurrencies and crypto
exchanges. Check <https://docs.cryptowat.ch/rest-api> for a detailed
documentation. The API is free of charge and does not require you to
create an API key. For example, you can easily retrieve historical
prices for a large number of cryptocurrencies without setting up an
account. However, for heavy users, this option is included in the
package as well.

## Installation

You can install the released version of cryptowatchR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cryptowatchR")
```

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lorenzbr/cryptowatchR")
```

## Usage

``` r
## Examples

library(cryptowatchR)

# Some settings
exchange <- "kraken"
pair <- "btcusd"

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

# Current market price
current_price <- get_current_price("btcusd")
current_prices <- get_current_price()

## Get trades
# Most recent trades (default is 50)
trades <- get_trades(pair)
# 100 trades
trades_100 <- get_trades(pair, limit = 100, datetime = FALSE)
# 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
trades_unix <- get_trades(pair, since = 1589571417, limit = 200, datetime = FALSE)
# 1000 trades and datetime is TRUE
trades_datetime <- get_trades(pair, since = "2021-06-01", limit = 1000)

# 24h-hour summary of cryptocurrency pairs
summary <- get_summary("btcusd")
summaries <- get_summary()
summaries_id <- get_summary(keyBy = "id")
summaries_symbols <- get_summary(keyBy = "symbols")

# Orderbook for Bitcoin-USD (bid and ask with Price and Amount)
orderbook <- get_orderbook(pair, exchange = exchange)
orderbook_depth <- get_orderbook(pair, exchange = exchange, depth = 100)
orderbook_span <- get_orderbook(pair, exchange = exchange, span = 0.5)
orderbook_limit <- get_orderbook(pair, exchange = exchange, limit = 1)

# Get liquidity sums in the order book of Bitcoin in USD
liquidity <- get_orderbook_liquidity("btcusd")

# Live quote for 50 Bitcoins
calculator <- get_orderbook_calculator("btcusd", amount = 50)

# Asset information
df_assets <- get_assets()
asset_btc <- get_assets("btc")

# Information on pairs of currencies
df_pairs <- get_pairs()
pair_btcusd <- get_pairs("btcusd")

# Information on crypto exchanges
df_exchanges <- get_exchanges()
exchange_kraken <- get_exchanges("kraken")
```

## Contact

Please submit bug reports and suggestions via
<https://github.com/lorenzbr/cryptowatchR/issues>

## License

This R package is licensed under the GNU General Public License v3.0.

See
[here](https://github.com/lorenzbr/cryptowatchR/blob/main/LICENSE.md)
for further information.
