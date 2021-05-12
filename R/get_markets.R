#' Get price data for cryptocurrencies
#' @usage get_markets(pair, params = NULL, exchange = "kraken", route = "ohlc")
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional). See \emph{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}.
#' @param route A string containing market prices. Possible values: \emph{price, trades, summary, orderbook, ohlc}. Default is \emph{ohlc}.
#'
#' @return data A list containing price data for given pair.
#'
#' @export
get_markets <- function(pair, params = NULL, exchange = "kraken", route = "ohlc") {

  path <- get_cryptowatch_url()

  path <- file.path(path, "markets", exchange, pair, route)

  if (is.null(params)) request <- httr::GET(path)

  if (!is.null(params)) request <- httr::GET(path, query = params)

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if (!grepl("^2", as.character(request$status_code))) stop(request$status_code, " ", data$error)

  return(data)

}

#' Get data.frame with prices for cryptocurrencies
#' @usage get_markets_as_df(pair, params = NULL, exchange = "kraken", route = "ohlc")
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional). See \emph{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}.
#' @param route A string containing market prices. Possible values: \emph{price, trades, summary, orderbook, ohlc}. Default is \emph{ohlc}.
#'
#' @return df.data A data.frame containing price data for given pair.
#'
#' @export
get_markets_as_df <- function(pair, params = NULL, exchange = "kraken", route = "ohlc") {

  data <- get_markets(pair, params, exchange, route)

  df.data <- data.frame(data[[1]][[1]])

  names(df.data) <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  return(df.data)

}

#' Get data.frame with prices for cryptocurrencies (use dates as in-/output)
#' @usage get_markets_by_date(pair, params = NULL, exchange = "kraken", route = "ohlc")
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional). Dates can be of type "Y-m-d". \code{periods} in seconds: 86400 refers to daily prices.
#' @param exchange A string containing the exchange. Default is \emph{kraken}.
#' @param route A string containing market prices. Possible values: \emph{price, trades, summary, orderbook, ohlc}. Default is \emph{ohlc}.
#'
#' @return df.data A data.frame containing price data for given pair.
#'
#' @export
get_markets_by_date <- function(pair, params = NULL, exchange = "kraken", route = "ohlc") {

  if (!is.null(params[["before"]])) params$before <- as.numeric(as.POSIXct(params$before))
  if (!is.null(params[["after"]])) params$after <- as.numeric(as.POSIXct(params$after))

  df.data <- get_markets_as_df(pair, params, exchange, route)

  df.data$CloseTime <- lubridate::as_datetime(df.data$CloseTime)

  return(df.data)

}
