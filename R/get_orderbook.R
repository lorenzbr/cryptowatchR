#' Get order book of cryptocurrencies
#'
#' Get the order book of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{orderbook} and returns two arrays, bids and asks. See \url{https://docs.cryptowat.ch/rest-api/markets/order-book} for further information.
#'
#' @usage get_orderbook(pair, depth = NULL, span = NULL, limit = NULL,
#'         exchange = "kraken", api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param depth A number: Only return orders cumulating up to this size (optional).
#' @param span A number: Only return orders within this percentage of the midpoint (optional). Example: 0.5 (meaning 0.5 percent).
#' @param limit An integer limiting the number of orders on each side of the book (optional).
#' @param exchange A character string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param api_key A character string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A list containing an order book of a given pair of currencies. It contain two data.frames for bid and ask prices with columns \emph{Price} and \emph{Amount}. The function also returns the sequence number \emph{seqNum}. If allowance is \code{TRUE}, \code{get_orderbook()} returns a list which additionally includes allowance information.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_orderbook_liquidity}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Entire order book of Bitcoin in USD
#' orderbook <- get_orderbook("btcusd")
#' # Order book of Bitcoin in USD: only the best bid and best ask, i.e. the spread
#' orderbook.limit <- get_orderbook("btcusd", limit = 1)
#' # Order book of Bitcoin in USD for orders within 0.5% of the top of the book
#' orderbook.span <- get_orderbook("btcusd", span = 0.5)
#' # Order book of Bitcoin in Euro for orders adding up to 100 BTC on each side
#' orderbook.depth <- get_orderbook("btceur", depth = 100)
#' }
#'
#' @export
get_orderbook <- function(pair, depth = NULL, span = NULL, limit = NULL, exchange = "kraken",
                          api_key = NULL, allowance = FALSE) {

  params <- list(depth = depth, span = span, limit = limit)
  # if ( is.null(params$depth) && is.null(params$span) && is.null(params$limit) ) params <- NULL

  orderbook <- get_markets(route = "orderbook", pair, exchange, params, api_key, allowance)

  if (allowance) {

    allowance.list <- orderbook[[2]]
    orderbook <- orderbook[[1]]

  }

  asks <- data.frame(orderbook$asks)
  df.asks <- data.frame(Price = asks$X1, Amount = asks$X2)

  bids <- data.frame(orderbook$bids)
  df.bids <- data.frame(Price = bids$X1, Amount = bids$X2)

  seqNum <- orderbook$seqNum

  result <- list(asks = df.asks, bids = df.bids, seqNum = seqNum)

  if (allowance) {

    output <- list(result = result, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- result

  }

  return(output)

}
