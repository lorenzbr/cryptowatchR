#' Get pair of currencies
#'
#' Get details on pairs of (crypto)currencies.
#'
#' @usage get_pairs(pair = NULL, api_key = NULL, allowance = FALSE)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd} (optional
#' argument). Run \code{get_pairs()} to get all available pairs of currencies.
#' @param api_key A string containing the API key. See
#' \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create
#' an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the
#' function returns a list which includes allowance information, i.e. cost of
#' the request, remaining credits and your account name.
#'
#' @return A list or data.frame containing data on pairs.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}},
#' \code{\link{get_exchanges}}
#' @examples
#' \dontrun{
#' # Get all available pairs of currencies
#' df_pairs <- get_pairs()
#' # Get details on the pair Bitcoin-USD
#' pair_btcusd <- get_pairs("btcusd")
#' }
#'
#' @export
get_pairs <- function(pair = NULL, api_key = NULL, allowance = FALSE) {

  data <- get_data(pair, "pairs", api_key, allowance)

  return(data)

}
