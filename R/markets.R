#' Get prices of cryptocurrencies
#'
#' Get data.frame with prices of cryptocurrencies using the REST API of cryptowat.ch.
#'
#' @usage markets(pair, params = NULL, exchange = "kraken", datetime = TRUE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument).
#' @param params A list containing \code{before}, \code{after} and \code{periods} which is measured in seconds (optional). See \url{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to choose other exchanges.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#'
#' @return A data.frame containing prices of a given pair of currencies.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Prices (every four hours) of Bitcoin in USD
#' df.btcusd. <- markets("btcusd")
#' # Hourly prices of Bitcoin in USD for a specific period
#' df.btcusd.hourly <- markets("btcusd", list(periods = 3600, before = 1609851600,
#'                                           after = 1609506000), datetime = FALSE)
#' # Daily prices of Bitcoin in Euro for a specific period
#' df.btceur.daily <- markets("btceur", list(periods = 86400, before = "2021-05-12",
#'                                           after = "2021-01-01"), datetime = TRUE)
#' }
#'
#' @export
markets <- function(pair, params = NULL, exchange = "kraken", datetime = TRUE) {

  route <- "ohlc"

  if (datetime) {

    if (!is.null(params[["before"]])) params$before <- as.numeric(as.POSIXct(params$before))
    if (!is.null(params[["after"]])) params$after <- as.numeric(as.POSIXct(params$after))

  }

  prices <- get_markets(route, pair, exchange, params)

  df.prices <- data.frame(prices[[1]][[1]])

  names(df.prices) <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  if (datetime) df.prices$CloseTime <- lubridate::as_datetime(df.prices$CloseTime)

  return(df.prices)

}
