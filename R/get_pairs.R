#' Get pair of currencies
#'
#' Get details on pairs of (crypto)currencies.
#'
#' @usage get_pairs(pair = NULL)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (optional argument). Run \code{get_pairs()} to get all available pairs of currencies.
#'
#' @return A list or data.frame containing data on pairs.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}
#' @examples
#' \dontrun{
#' # Get all available pairs of currencies
#' df.pairs <- get_pairs()
#' # Get details on the pair Bitcoin-USD
#' pair.btcusd <- get_pairs("btcusd")
#' }
#'
#' @export
get_pairs <- function(pair = NULL) {

  data <- get_data(pair, "pairs")

  return(data)

}
