# cryptowatchR

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
[![R-CMD-check](https://github.com/lorenzbr/cryptowatchR/workflows/R-CMD-check/badge.svg)](https://github.com/lorenzbr/cryptowatchR/actions)
<!-- badges: end -->

An API wrapper for Cryptowatch written in R


## Introduction

This R package provides a wrapper for the Cryptowatch API. You can get prices and other information about cryptocurrencies and crypto exchanges. Check [https://docs.cryptowat.ch/rest-api](https://docs.cryptowat.ch/rest-api) for a detailed documentation. The API is free of charge and does not require you to create an API key. For example, you can easily retrieve historical prices for all major cryptocurrencies.


## Installation

You can install the development version from
[GitHub](https://github.com/) with:

```R
devtools::install_github("lorenzbr/cryptowatchR")
# if not, try:
devtools::install_github("lorenzbr/cryptowatchR@main")
```


## Usage

```R
## Examples

# Set parameters
exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

# Get daily prices for longest possible time period
params1 <- list(periods = 86400)
df.markets1 <- cryptowatchR::get_markets(pair, params1, exchange = "kraken", route = "ohlc")

# Get hourly prices
params2 <- list(periods = 3600, before = 1609851600, after = 1609506000)
df.markets2 <- cryptowatchR::markets(pair, params2, exchange = "kraken", route = "ohlc", datetime = FALSE)

# Get hourly prices using date/datetime variables
params3 <- list(periods = 3600, before = "2021-01-05", after = "2021-01-01")
df.markets3 <- cryptowatchR::markets(pair, params3, exchange = "kraken", route = "ohlc", datetime = TRUE)

# Get daily prices using date/datetime variables
params4 <- list(periods = 86400, before = "2021-05-12", after = "2021-01-01")
df.markets4 <- cryptowatchR::markets(pair, params4, exchange = "kraken", route = "ohlc", datetime = TRUE)

# Get daily prices using POSIX time
params5 <- list(periods = 86400, before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")))
df.markets5 <- cryptowatchR::markets(pair, params5, exchange = "kraken", route = "ohlc", datetime = FALSE)

# Get asset information
asset.data <- cryptowatchR::get_assets("btc")
df.assets <- cryptowatchR::get_assets()

# Get information on pairs of currencies
btcusd.data <- cryptowatchR::get_pairs("btcusd")
df.pairs <- cryptowatchR::get_pairs()

# Get information on crypto exchanges
exchange.data <- cryptowatchR::get_exchanges("kraken")
df.exchanges <- cryptowatchR::get_exchanges()
```


## Contact

Please contact <lorenz.brachtendorf@gmx.de> if you want to contribute to this project.

You can also submit bug reports and suggestions via e-mail or <https://github.com/lorenzbr/cryptowatchR/issues> 


## License

This R package is licensed under the GNU General Public License v3.0.

See [here](https://github.com/lorenzbr/cryptowatchR/blob/main/LICENSE) for further information.
