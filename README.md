
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

# Settings
exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

# Daily prices for longest possible time period
params1 <- list(periods = 86400)
markets.btcusd <- cryptowatchR::get_markets(route, pair, exchange, params1)

# Daily prices of Bitcoin in USD
df.btcusd <- cryptowatchR::markets(pair)

# Hourly prices
params2 <- list(periods = 3600, before = 1609851600, after = 1609506000)
df.btcusd2 <- cryptowatchR::markets(pair, params2, exchange, datetime = FALSE)

# Hourly prices using date/datetime variables
params3 <- list(periods = 3600, before = "2021-01-05", after = "2021-01-01")
df.btcusd3 <- cryptowatchR::markets(pair, params3, exchange, datetime = TRUE)

# Daily prices using date/datetime variables
params4 <- list(periods = 86400, before = "2021-05-12", after = "2021-01-01")
df.btcusd4 <- cryptowatchR::markets(pair, params4, exchange, datetime = TRUE)

# Daily prices using POSIX time
params5 <- list(periods = 86400, before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")))
df.btcusd5 <- cryptowatchR::markets(pair, params5, exchange, datetime = FALSE)

# Current market price
markets.price.btcusd <- cryptowatchR::get_markets(route = "price", pair, exchange)

# All current market prices for all exchanges
markets.price <- cryptowatchR::get_markets(route = "prices")

# Most recent trades (default is 50)
markets.trades <- cryptowatchR::get_markets(route = "trades", pair, exchange)

# 200 Trades (maximum is 1000) since 1589571417
params.prices <- list(since = 1589571417, limit = 200)
markets.trades2 <- cryptowatchR::get_markets(route = "trades", pair, exchange, params.prices)

# Last price and other stats for Bitcoin-USD pair
markets.summary.btcusd <- cryptowatchR::get_markets(route = "summary", pair, exchange)

# Summaries for every pair and every exchange
markets.summaries <- cryptowatchR::get_markets(route = "summaries")
markets.summaries2 <- cryptowatchR::get_markets(route = "summaries", params = list(keyBy = "id"))
markets.summaries3 <- cryptowatchR::get_markets(route = "summaries", params = list(keyBy = "symbols"))

# Orderbook for Bitcoin-USD (bid and ask with Price and Amount)
markets.oderbook <- cryptowatchR::get_markets(route = "orderbook", pair, exchange)
markets.oderbook.depth <- cryptowatchR::get_markets(route = "orderbook", pair, exchange,
                                                    params = list(depth = 100))
markets.oderbook.span <- cryptowatchR::get_markets(route = "orderbook", pair, exchange, params = list(span = 0.5))
markets.oderbook.limit <- cryptowatchR::get_markets(route = "orderbook", pair, exchange, params = list(limit = 1))
markets.oderbook.liquidity <- cryptowatchR::get_markets(route = "orderbook/liquidity", pair, exchange)
markets.oderbook.calculator <- cryptowatchR::get_markets(route = "orderbook/calculator", pair, exchange,
                                                         params = list(amount = 1))

# Asset information
df.assets <- cryptowatchR::get_assets()
asset.btc <- cryptowatchR::get_assets("btc")

# Information on pairs of currencies
df.pairs <- cryptowatchR::get_pairs()
pair.btcusd <- cryptowatchR::get_pairs("btcusd")

# Information on crypto exchanges
df.exchanges <- cryptowatchR::get_exchanges()
exchange.kraken <- cryptowatchR::get_exchanges("kraken")
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
