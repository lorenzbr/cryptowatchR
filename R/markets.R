#' Get prices of cryptocurrencies
#'
#' Get data frame with prices of cryptocurrencies using the REST API of cryptowat.ch.
#'
#' @usage markets(pair, params = NULL, exchange = "kraken", route = "ohlc",
#' datetime = TRUE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} (optional).
#' See \url{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A character string containing the exchange. Default is \emph{kraken}.
#' @param route A character string containing the route. Default is \emph{ohlc}.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used.
#' \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#'
#' @return A data frame containing OHLC candlestick prices of a given pair of currencies.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}},
#' \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' df_ohlc_hourly <- markets("btcusd")
#' df_ohlc_hourly2 <- markets("btcusd", list(periods = 3600, before = 1609851600,
#'                                           after = 1609506000), datetime = FALSE)
#' df_ohlc_daily <- markets("btceur", list(periods = 86400, before = "2021-05-12",
#'                                           after = "2021-01-01"), datetime = TRUE)
#' }
#'
#' @export
markets <- function(pair, params = NULL, exchange = "kraken", route = "ohlc",
                    datetime = TRUE) {

  .Deprecated("get_ohlc")

  if (route != "ohlc") {

    stop("markets() only works with route 'ohlc'. For other routes use
    get_trades, get_summary, get_current_price, get_orderbook,
    get_orderbook_liquidity")

  }

  if (datetime) {

    if (!is.null(params[["before"]])) params$before <- as.numeric(as.POSIXct(params$before))
    if (!is.null(params[["after"]])) params$after <- as.numeric(as.POSIXct(params$after))

  }

  data <- get_markets(route = route, pair = pair,
                      exchange = exchange, params = params)

  df_data <- data.frame(data[[1]])

  names(df_data) <- c(
    "CloseTime", "OpenPrice", "HighPrice", "LowPrice",
    "ClosePrice", "Volume", "QuoteVolume"
  )

  if (datetime) df_data$CloseTime <- lubridate::as_datetime(df_data$CloseTime)

  return(df_data)

}
