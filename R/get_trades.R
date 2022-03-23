#' Get trades of cryptocurrencies
#'
#' Get data.frame with trades of cryptocurrencies using the REST API of
#' cryptowat.ch. The route is \emph{trades} and returns trades for a specified
#' market. See \url{https://docs.cryptowat.ch/rest-api/markets/trades} for
#' further information.
#'
#' @usage get_trades(pair, since = NULL, limit = NULL, exchange = "kraken",
#'            datetime = TRUE, api_key = NULL, allowance = FALSE)
#' @param pair A character string containing a pair symbol, e.g. \emph{btcusd}
#' (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param since An integer if \emph{datetime} is \code{FALSE} and a character
#' string if it is \code{TRUE}: Limit the response to trades after this date
#' (optional). This can only be used to filter recent trades. Historical trades
#' cannot be retrieved.
#' @param limit An integer: Limit the number of trades (optional). Max: 1000.
#' @param exchange A character string containing the exchange. Default is
#' \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used.
#' \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#' @param api_key A character string containing the API key. See
#' \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create
#' an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the
#' function returns a list which includes allowance information, i.e. cost of
#' the request, remaining credits and your account name.
#'
#' @return A data frame containing trades of a given pair of currencies. If
#' allowance is \code{TRUE}, \code{get_trades()} returns a list.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}},
#' \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Most recent trades (default is 50)
#' trades <- get_trades(pair)
#' # 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
#' trades_unix <- get_trades(pair, since = 1589571417, limit = 200, datetime = FALSE)
#' # 1000 trades and datetime is TRUE
#' trades_datetime <- get_trades(pair, since = "2021-06-01", limit = 1000)
#' }
#'
#' @export
get_trades <- function(pair, since = NULL, limit = NULL, exchange = "kraken",
                       datetime = TRUE, api_key = NULL, allowance = FALSE) {

  if (datetime)
    if (!is.null(since)) since <- as.numeric(as.POSIXct(since))

  params <- list(since = since, limit = limit)

  trades <- get_markets(route = "trades", pair, exchange,
                        params, api_key, allowance)

  if (allowance) {

    allowance_list <- trades[[2]]
    trades <- trades[[1]]

  }

  df_trades <- as.data.frame(trades)

  names(df_trades) <- c("ID", "Timestamp", "Price", "Amount")

  if (datetime)
    df_trades$Timestamp <- lubridate::as_datetime(df_trades$Timestamp)

  if (allowance) {

    output <- list(result = df_trades, allowance = allowance_list)

  } else if (allowance == FALSE) {

    output <- df_trades

  }

  return(output)

}
