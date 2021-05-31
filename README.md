
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

# Set parameters
exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

# Get daily prices for longest possible time period
params1 <- list(periods = 86400)
markets.btcusd <- cryptowatchR::get_markets(route, pair, exchange, params1)

# Get hourly prices
params2 <- list(periods = 3600, before = 1609851600, after = 1609506000)
df.btcusd2 <- cryptowatchR::markets(pair, params2, exchange, datetime = FALSE)

# Get hourly prices using date/datetime variables
params3 <- list(periods = 3600, before = "2021-01-05", after = "2021-01-01")
df.btcusd3 <- cryptowatchR::markets(pair, params3, exchange, datetime = TRUE)

# Get daily prices using date/datetime variables
params4 <- list(periods = 86400, before = "2021-05-12", after = "2021-01-01")
df.btcusd4 <- cryptowatchR::markets(pair, params4, exchange, datetime = TRUE)

# Get daily prices using POSIX time
params5 <- list(periods = 86400, before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")))
df.btcusd5 <- cryptowatchR::markets(pair, params5, exchange, datetime = FALSE)

# Get asset information
df.assets <- cryptowatchR::get_assets()
asset.btc <- cryptowatchR::get_assets("btc")

# Get information on pairs of currencies
df.pairs <- cryptowatchR::get_pairs()
pair.btcusd <- cryptowatchR::get_pairs("btcusd")

# Get information on crypto exchanges
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
