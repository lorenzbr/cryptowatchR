#' Get current price of cryptocurrencies
#'
#' Get current price of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{price} or \emph{prices} and returns the current price of a given pair or current prices of all pairs.
#'
#' @usage get_current_price(pair, exchange = "kraken", api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param exchange A string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param api_key A string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return Current price of a given pair of currencies. If allowance is \code{TRUE}, \code{get_current_price()} returns a list.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_ohlc}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Daily prices of Bitcoin in USD
#' current.price <- get_current_price("btcusd")
#' current.prices <- get_current_price()
#' }
#' @export
get_current_price <- function(pair = NULL, exchange = "kraken", api_key = NULL, allowance = FALSE) {

  if ( !is.null(pair) ) route <- "price" else if ( is.null(pair) ) route <- "prices"

  prices <- get_markets(route = route, pair = pair, exchange = exchange,
                        api_key = api_key, allowance = allowance)

  if (allowance) {

    allowance.list <- prices[[2]]
    prices <- prices[[1]]

  }


  if ( !is.null(pair) ) {

    if (allowance) { price.out <- prices } else if (allowance == FALSE) { price.out <- prices$price }

  } else if ( is.null(pair) ) {

    price.out <- data.frame(name = names(prices), price = unlist(prices))
    rownames(price.out) <- 1:nrow(price.out)

  }


  if (allowance) {

    output <- list(result = price.out, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- price.out

  }

  return(output)

}
