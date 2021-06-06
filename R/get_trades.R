#' Get trades of cryptocurrencies
#'
#' Get data.frame with trades of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{trades} and returns trades for a specified market.
#'
#' @usage get_trades(pair, params = NULL, exchange = "kraken", datetime = TRUE,
#'         api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param params A list containing \code{since} and \code{limit}. The former is a date can be used to limit the response to trades after the date. This filter cannot be used to get historical trades. The latter is an integer and limits the number of trades in the response (max: 1000). See \url{https://docs.cryptowat.ch/rest-api/markets/trades} for further information.
#' @param exchange A string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#' @param api_key A string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A data.frame containing trades of a given pair of currencies. If allowance is \code{TRUE}, \code{get_trades()} returns a list.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Most recent trades (default is 50)
#' markets.trades <- get_trades(pair)
#' # 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
#' params.trades2 <- list(since = 1589571417, limit = 200)
#' markets.trades2 <- get_trades(pair, params = params.trades2, datetime = FALSE)
#' # 1000 trades and datetime is TRUE
#' params.trades3 <- list(since = "2021-06-01", limit = 1000)
#' markets.trades3 <- get_trades(pair, params = params.trades3)
#' }
#'
#' @export
get_trades <- function(pair, params = NULL, exchange = "kraken", datetime = TRUE, api_key = NULL, allowance = FALSE) {

  if (datetime) {

    if ( !is.null(params[["since"]]) ) params$since <- as.numeric(as.POSIXct(params$since))

  }

  trades <- get_markets(route = "trades", pair, exchange, params, api_key, allowance)

  if (allowance) {

    allowance.list <- trades[[2]]
    trades <- trades[[1]]

  }

  df.trades <- as.data.frame(trades)

  names(df.trades) <- c("ID", "Timestamp", "Price", "Amount")

  if (datetime) df.trades$Timestamp <- lubridate::as_datetime(df.trades$Timestamp)


  if (allowance) {

    output <- list(result = df.trades, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- df.trades

  }

  return(output)

}
