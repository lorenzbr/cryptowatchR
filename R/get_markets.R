#' Get prices of cryptocurrencies
#'
#' Get prices of cryptocurrencies using the REST API of cryptowat.ch.
#'
#' @usage get_markets(route, pair = NULL, exchange = NULL, params = NULL)
#' @param route A string containing a market endpoint. Possible values: \emph{price, prices, trades, summary, summaries, orderbook, orderbook/liquidity, orderbooks/calculator, ohlc} (required argument).
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (optional argument).
#' @param exchange A string containing the exchange (optional argument). Run \code{get_exchanges()} to choose an exchange.
#' @param params A list containing query parameters. E.g., for the route \emph{ohlc}, this is \code{before}, \code{after} and \code{periods} (optional). See \emph{https://docs.cryptowat.ch/rest-api/markets} for further information.
#'
#' @return A list containing markets data.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Prices (every four hours) of Bitcoin in USD
#' btcusd.ohlc <- get_markets(route = "ohlc", pair = btcusd", exchange = "kraken")
#' # Hourly prices of Bitcoin in USD for a specific period
#' btcusd.ohlc2 <- get_markets(route = "ohlc", pair = "btcusd", exchange = "kraken",
#'                             list(periods = 3600, before = 1609851600, after = 1609506000))
#' }
#'
#' @export
get_markets <- function(route, pair = NULL, exchange = NULL, params = NULL) {

  path <- get_cryptowatch_url()

  path <- file.path(path, "markets")

  if( !is.null(pair) && !is.null(exchange) ) {

    path <- file.path(path, exchange, pair, route)

  } else {

    path <- file.path(path, route)

  }

  if (is.null(params)) {

    request <- httr::GET(path)

  } else {
    request <- httr::GET(path, query = params)

  }

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if ( !grepl("^2", as.character(request$status_code)) ) stop(request$status_code, " ", data$error)

  return(data)

}
