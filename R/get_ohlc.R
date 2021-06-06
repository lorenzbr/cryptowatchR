#' Get prices of cryptocurrencies
#'
#' Get data.frame with prices of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{ohlc} and returns OHLC candlestick prices. The default is daily prices but can be changed with \code{params} and \code{periods}.
#'
#' @usage get_ohlc(pair, params = NULL, exchange = "kraken", datetime = TRUE,
#'         api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param params A list containing \code{before}, \code{after} and \code{periods} which is measured in seconds (optional). See \url{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#' @param api_key A string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A data.frame containing OHLC candlestick prices of a given pair of currencies. If allowance is \code{TRUE}, \code{get_ohlc()} returns a list.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Daily prices of Bitcoin in USD
#' df.btcusd <- get_ohlc("btcusd")
#' # Hourly prices of Bitcoin in USD for a specific time period
#' df.btcusd.hourly <- get_ohlc("btcusd", list(periods = 3600, before = 1609851600,
#'                                           after = 1609506000), datetime = FALSE)
#' # Daily prices of Bitcoin in Euro for a specific time period
#' df.btceur.daily <- get_ohlc("btceur", list(periods = 86400, before = "2021-05-12",
#'                                           after = "2021-01-01"), datetime = TRUE)
#' }
#'
#' @export
get_ohlc <- function(pair, params = NULL, exchange = "kraken", datetime = TRUE, api_key = NULL, allowance = FALSE) {

  if (datetime) {

    if ( !is.null(params[["before"]]) ) params$before <- as.numeric(as.POSIXct(params$before))
    if ( !is.null(params[["after"]]) ) params$after <- as.numeric(as.POSIXct(params$after))

  }

  prices <- get_markets(route = "ohlc", pair, exchange, params, api_key, allowance)

  if (allowance) {

    if ( !is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]][[1]])

    } else if ( is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]][names(prices) == "86400"])

    }

    allowance.list <- prices[[2]]

  } else if (allowance == FALSE) {

    if ( !is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]])

    } else if ( is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[names(prices) == "86400"])

    }

  }

  names(df.prices) <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  if (datetime) df.prices$CloseTime <- lubridate::as_datetime(df.prices$CloseTime)


  if (allowance) {

    output <- list(result = df.prices, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- df.prices

  }

  return(output)

}
