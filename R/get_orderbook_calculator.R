#' Get live quotes from order book
#'
#' Get a live quote from the order book for a given buy and sell amount. The route is \emph{orderbook/calculator} and returns two data.frames containing buy and sell projections. See \url{https://docs.cryptowat.ch/rest-api/markets/order-book} for further information.
#'
#' @usage get_orderbook_calculator(pair, amount = NULL, exchange = "kraken",
#'                          api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param amount A number: Amount to buy or sell (required).
#' @param exchange A character string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param api_key A character string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A list containing projections for the buy and sell side for a given amount. \emph{Reach} indicates the farthest your reach would fill. \emph{Avg} indicates the volume-weighted average. If allowance is \code{TRUE}, \code{get_orderbook_calculator()} returns a list which additionally includes allowance information.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_orderbook}}, \code{\link{get_orderbook_liquidity}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Live quote for 50 Bitcoins
#' calculator <- get_orderbook_calculator("btcusd", amount = 50)
#' }
#'
#' @export
get_orderbook_calculator <- function(pair, amount = NULL, exchange = "kraken", api_key = NULL, allowance = FALSE) {

  params <- list(amount = amount)

  calculator <- get_markets(route = "orderbook/calculator", pair, exchange, params, api_key, allowance)

  if (allowance) {

    allowance.list <- calculator[[2]]
    calculator <- calculator[[1]]

  }

  df.buy <- data.frame(calculator$buy)

  df.sell <- data.frame(calculator$sell)

  result <- list(buy = df.buy, sell = df.sell)

  if (allowance) {

    output <- list(result = result, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- result

  }

  return(output)

}
