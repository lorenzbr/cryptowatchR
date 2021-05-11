[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

# cryptowatchR
A simple API wrapper in R for cryptowatch


## Introduction

This R package is a unofficial API wrapper for cryptowatch.


## Contact

Please contact <lorenz.brachtendorf@gmx.de> if you want to contribute to this project.

You can also submit bug reports and suggestions via e-mail or <https://github.com/lorenzbr/cryptowatchR/issues> 


## Installation


```R
devtools::install_github("lorenzbr/cryptowatchR")
```


## Usage

```R
# Example

exchange <- "kraken"
pair <- "btcusd"
route <- "ohlc"
params <- list(periods = 86400)
# params <- list(periods = 3600, before = 1602179348, after = 1594087200)

df.markets <- get_markets(pair, params, exchange = "kraken", route = "ohlc")
```


## License

This R package is licensed under the GNU General Public License v3.0.

See [here](https://github.com/lorenzbr/cryptowatchR/blob/main/LICENSE) for further information.
