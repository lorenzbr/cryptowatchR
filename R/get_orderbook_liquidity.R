#' Get liquidity sums in the order book of cryptocurrencies
#'
#' Get liquidity sums in the order book of cryptocurrencies using the REST API
#' of cryptowat.ch. The route is \emph{orderbook/liquidity}. See \url{https://docs.cryptowat.ch/rest-api/markets/order-book} for further information.
#'
#' @usage get_orderbook_liquidity(pair, exchange = "kraken", api_key = NULL,
#' allowance = FALSE)
#' @param pair A character string containing a pair symbol, e.g. \emph{btcusd}
#' (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param exchange A character string containing the exchange. Default is
#' \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param api_key A character string containing the API key. See
#' \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create
#' an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the
#' function returns a list which includes allowance information, i.e. cost of
#' the request, remaining credits and your account name.
#'
#' @return A list containing liquidity sums at several basis point levels in
#' the order book. If allowance is \code{TRUE}, \code{get_orderbook()} returns
#' a list which additionally includes allowance information.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_orderbook}},
#' \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Get liquidity sums in the order book of Bitcoin in USD
#' liquidity <- get_orderbook_liquidity("btcusd")
#' }
#'
#' @export
get_orderbook_liquidity <- function(pair, exchange = "kraken", api_key = NULL,
                                    allowance = FALSE) {

  liquidity <- get_markets(route = "orderbook/liquidity", pair = pair,
                           exchange = exchange, api_key = api_key,
                           allowance = allowance)

  if (allowance) {

    allowance_list <- liquidity[[2]]
    liquidity <- liquidity[[1]]

  }

  df_ask_base <- data.frame(base = unlist(liquidity$ask$base))
  df_ask_quote <- data.frame(quote = unlist(liquidity$ask$quote))
  df_ask <- cbind(df_ask_base, df_ask_quote)

  df_bid_base <- data.frame(base = unlist(liquidity$bid$base))
  df_bid_quote <- data.frame(quote = unlist(liquidity$bid$quote))
  df_bid <- cbind(df_bid_base, df_bid_quote)

  result <- list(ask = df_ask, bid = df_bid)

  if (allowance) {

    output <- list(result = result, allowance = allowance_list)

  } else if (allowance == FALSE) {

    output <- result

  }

  return(output)

}
