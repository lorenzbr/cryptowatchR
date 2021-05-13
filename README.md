[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

# cryptowatchR
An API wrapper for cryptowatch in R


## Introduction

This R package is an API wrapper for cryptowatch. Check [https://docs.cryptowat.ch/rest-api](https://docs.cryptowat.ch/rest-api) for a detailed documentation.


## Installation


```R
devtools::install_github("lorenzbr/cryptowatchR")
```


## Usage

```R
# Examples

exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"

params1 <- list(periods = 86400)
params2 <- list(periods = 3600, before = 1609851600, after = 1609506000)
params3 <- list(periods = 3600, before = "2021-01-05", after = "2021-01-01")
params4 <- list(periods = 86400, before = "2021-05-12", after = "2021-01-01")
params5 <- list(periods = 86400, before = as.numeric(as.POSIXct("2021-05-12 14:00:00 UCT")),
                after = as.numeric(as.POSIXct("2021-01-01 14:00:00 UCT")))
df.markets1 <- cryptowatchR::get_markets(pair, params1, exchange = "kraken", route = "ohlc")
df.markets2 <- cryptowatchR::markets(pair, params2, exchange = "kraken", route = "ohlc", datetime = FALSE)
df.markets3 <- cryptowatchR::markets(pair, params3, exchange = "kraken", route = "ohlc")
df.markets4 <- cryptowatchR::markets(pair, params4, exchange = "kraken", route = "ohlc")
df.markets5 <- cryptowatchR::markets(pair, params5, exchange = "kraken", route = "ohlc", datetime = FALSE)

asset.data <- cryptowatchR::get_assets("btc")
df.assets <- cryptowatchR::get_assets()

btcusd.data <- cryptowatchR::get_pairs("btcusd")
df.pairs <- cryptowatchR::get_pairs()

exchange.data <- cryptowatchR::get_exchanges("kraken")
df.exchanges <- cryptowatchR::get_exchanges()
```


## Contact

Please contact <lorenz.brachtendorf@gmx.de> if you want to contribute to this project.

You can also submit bug reports and suggestions via e-mail or <https://github.com/lorenzbr/cryptowatchR/issues> 


## License

This R package is licensed under the GNU General Public License v3.0.

See [here](https://github.com/lorenzbr/cryptowatchR/blob/main/LICENSE) for further information.
