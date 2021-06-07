
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptowatchR

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/cryptowatchR)](https://cran.r-project.org/package=cryptowatchR)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
[![R-CMD-check](https://github.com/lorenzbr/cryptowatchR/workflows/R-CMD-check/badge.svg)](https://github.com/lorenzbr/cryptowatchR/actions)
<!-- badges: end -->

An API wrapper for Cryptowatch written in R

## Introduction

This R package provides a wrapper for the Cryptowatch API. You can get
prices and other information about cryptocurrencies and crypto
exchanges. Check <https://docs.cryptowat.ch/rest-api> for a detailed
documentation. The API is free of charge and does not require you to
create an API key. For example, you can easily retrieve historical
prices for all major cryptocurrencies.

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

# Settings
exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

# Daily prices for longest possible time period
markets.btcusd <- get_markets(route, pair, exchange, list(periods = 86400))

# Daily prices of Bitcoin in USD
df.ohlc.daily <- get_ohlc(pair)

# Hourly prices
df.ohlc.hourly <- get_ohlc(pair, periods = 3600, before = 1609851600, after = 1609506000,
                           exchange, datetime = FALSE)

# Hourly prices using date/datetime variables
df.ohlc.hourly.datetime <- get_ohlc(pair, periods = 3600, before = "2021-01-05", after = "2021-01-01",
                                    exchange, datetime = TRUE)

# Daily prices using date/datetime variables
df.ohlc.daily.datetime <- get_ohlc(pair, periods = 86400, before = "2021-05-12", after = "2021-01-01",
                       exchange, datetime = TRUE)

# Daily prices using POSIX time
df.ohlc.daily.posix <- get_ohlc(pair, periods = 86400, before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")), exchange, datetime = FALSE)

# Current market price
current.price <- get_current_price("btcusd")
current.prices <- get_current_price()

## Get trades
# Most recent trades (default is 50)
trades <- get_trades(pair)
# 100 trades
trades.100 <- get_trades(pair, limit = 100, datetime = FALSE)
# 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
trades.unix <- get_trades(pair, since = 1589571417, limit = 200, datetime = FALSE)
# 1000 trades and datetime is TRUE
trades.datetime <- get_trades(pair, since = "2021-06-01", limit = 1000)

# 24h-hour summary of cryptocurrency pairs
summary <- get_summary("btcusd")
summaries <- get_summary()
summaries.id <- get_summary(keyBy = "id")
summaries.symbols <- get_summary(keyBy = "symbols")

# Orderbook for Bitcoin-USD (bid and ask with Price and Amount)
orderbook <- get_orderbook(pair, exchange = exchange)
orderbook.depth <- get_orderbook(pair, exchange = exchange, depth = 100)
orderbook.span <- get_orderbook(pair, exchange = exchange, span = 0.5)
orderbook.limit <- get_orderbook(pair, exchange = exchange, limit = 1)

# Get liquidity sums in the order book of Bitcoin in USD
liquidity <- get_orderbook_liquidity("btcusd")

# Asset information
df.assets <- get_assets()
asset.btc <- get_assets("btc")

# Information on pairs of currencies
df.pairs <- get_pairs()
pair.btcusd <- get_pairs("btcusd")

# Information on crypto exchanges
df.exchanges <- get_exchanges()
exchange.kraken <- get_exchanges("kraken")

# Current market price
markets.price.btcusd <- get_markets(route = "price", pair, exchange)

# All current market prices for all exchanges
markets.price <- get_markets(route = "prices")

# Most recent trades (default is 50)
markets.trades <- get_markets(route = "trades", pair, exchange)

# 200 Trades (maximum is 1000) since 1589571417
params.prices <- list(since = 1589571417, limit = 200)
markets.trades2 <- get_markets(route = "trades", pair, exchange, params.prices)

# Last price and other stats for Bitcoin-USD pair
markets.summary.btcusd <- get_markets(route = "summary", pair, exchange)

# Summaries for every pair and every exchange
markets.summaries <- get_markets(route = "summaries")
markets.summaries.id <- get_markets(route = "summaries", params = list(keyBy = "id"))
markets.summaries.symbols <- get_markets(route = "summaries", params = list(keyBy = "symbols"))

# Orderbook for Bitcoin-USD (bid and ask with Price and Amount)
markets.orderbook <- get_markets(route = "orderbook", pair, exchange)
markets.orderbook.depth <- get_markets(route = "orderbook", pair, exchange,
                                                    params = list(depth = 100))
markets.orderbook.span <- get_markets(route = "orderbook", pair, exchange, params = list(span = 0.5))
markets.orderbook.limit <- get_markets(route = "orderbook", pair, exchange, params = list(limit = 1))
markets.orderbook.liquidity <- get_markets(route = "orderbook/liquidity", pair, exchange)
markets.orderbook.calculator <- get_markets(route = "orderbook/calculator", pair, exchange,
                                                         params = list(amount = 1))
```

## Contact

Please contact <lorenz.brachtendorf@gmx.de> if you want to contribute to
this project.

You can also submit bug reports and suggestions via e-mail or
<https://github.com/lorenzbr/cryptowatchR/issues>

## License

This R package is licensed under the GNU General Public License v3.0.

See
[here](https://github.com/lorenzbr/cryptowatchR/blob/main/LICENSE.md)
for further information.
