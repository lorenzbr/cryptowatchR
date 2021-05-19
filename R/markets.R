#' Get prices for cryptocurrencies
#'
#' Get data.frame with prices for cryptocurrencies using the REST API of cryptowat.ch.
#'
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
