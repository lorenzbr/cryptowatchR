#' Get prices for cryptocurrencies
#'
#' Get price data for cryptocurrencies using the REST API of cryptowat.ch.
#'
#' @usage get_markets(pair, params = NULL, exchange = "kraken", route = "ohlc")
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional). See \emph{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}.
#' @param route A string containing market prices. Possible values: \emph{price, trades, summary, orderbook, ohlc}. Default is \emph{ohlc}.
#'
#' @return data A list containing price data for a given pair of currencies.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' btcusd.data <- get_markets("btcusd")
#' btcusd.data2 <- get_markets("btcusd", list(periods = 3600, before = 1609851600,
#'                                            after = 1609506000))
#' }
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

#' Get prices for cryptocurrencies
#'
#' Get data.frame with prices for cryptocurrencies using the REST API of cryptowat.ch.
#' @usage markets(pair, params = NULL, exchange = "kraken", route = "ohlc", datetime = TRUE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional). See \url{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}.
#' @param route A string containing market prices. Possible values: \emph{price, trades, summary, orderbook, ohlc}. Default is \emph{ohlc}.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#'
#' @return df.data A data.frame containing price data for a given pair of currencies.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' df.btcusd.data <- markets("btcusd")
#' df.btcusd.data2 <- markets("btcusd", list(periods = 3600, before = 1609851600,
#'                                           after = 1609506000), datetime = FALSE)
#' df.btceur.data3 <- markets("btceur", list(periods = 86400, before = "2021-05-12",
#'                                           after = "2021-01-01"))
#' }
#'
#' @export
markets <- function(pair, params = NULL, exchange = "kraken", route = "ohlc", datetime = TRUE) {

  if (datetime) {

    if (!is.null(params[["before"]])) params$before <- as.numeric(as.POSIXct(params$before))
    if (!is.null(params[["after"]])) params$after <- as.numeric(as.POSIXct(params$after))

  }

  data <- get_markets(pair, params, exchange, route)

  df.data <- data.frame(data[[1]][[1]])

  names(df.data) <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  if (datetime) df.data$CloseTime <- lubridate::as_datetime(df.data$CloseTime)

  return(df.data)

}
