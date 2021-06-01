#' Get prices of cryptocurrencies
#'
#' Get prices of cryptocurrencies using the REST API of cryptowat.ch.
#'
#' @usage get_markets(route, pair = NULL, exchange = NULL, params = NULL,
#'        api_key = NULL, allowance = FALSE)
#' @param route A string containing a market endpoint. Possible values: \emph{price, prices, trades, summary, summaries, orderbook, orderbook/liquidity, orderbooks/calculator, ohlc} (required argument). See \emph{https://docs.cryptowat.ch/rest-api/markets} for further information.
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (optional argument). Run \code{get_pairs()} to find other available pairs.
#' @param exchange A string containing the exchange (optional argument). Run \code{get_exchanges()} to find other available exchanges.
#' @param params A list containing query parameters. E.g., for the route \emph{ohlc}, this is \code{before}, \code{after} and \code{periods} (optional). See \emph{https://docs.cryptowat.ch/rest-api/markets} for further information.
#' @param api_key A string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance Logical (default is \emph{FALSE}). If \emph{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A list containing markets data.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Prices of Bitcoin in USD for all periods
#' btcusd.ohlc.all <- get_markets(route = "ohlc", pair = "btcusd", exchange = "kraken")
#' # Hourly prices of Bitcoin in USD for a specific time period
#' btcusd.ohlc.hourly <- get_markets(route = "ohlc", pair = "btcusd", exchange = "kraken",
#'                             list(periods = 3600, before = 1609851600, after = 1609506000))
#' }
#'
#' @export
get_markets <- function(route, pair = NULL, exchange = NULL, params = NULL, api_key = NULL, allowance = FALSE) {

  path <- get_cryptowatch_url()

  path <- file.path(path, "markets")

  if( !is.null(pair) && !is.null(exchange) ) {

    path <- file.path(path, exchange, pair, route)

  } else {

    path <- file.path(path, route)

  }

  if ( !is.null(api_key) ) path <- paste0(path, "?apikey=", api_key)

  if (is.null(params)) {

    request <- httr::GET(path)

  } else {

    request <- httr::GET(path, query = params)

  }

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if ( !grepl("^2", as.character(request$status_code)) ) stop(request$status_code, " ", data$error)

  if (allowance == FALSE) data <- data[[1]]

  return(data)

}
