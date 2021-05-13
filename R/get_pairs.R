#' Get pair of currencies
#'
#' Get details on pairs of (crypto)currencies.
#'
#' @usage get_pairs(pair = NULL)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd}. Optional argument.
#'
#' @return data A list or data.frame containing pair data.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}
#' @examples
#' \dontrun{
#' btcusd.data <- get_pairs("btcusd")
#' df.pairs <- get_pairs()
#' }
#'
#' @export
get_pairs <- function(pair = NULL) {

  data <- get_data(pair, "pairs")

  return(data)

}
