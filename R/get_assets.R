#' Get asset details
#'
#' Get asset information on cryptocurrencies.
#'
#' @usage get_assets(asset = NULL, api_key = NULL, allowance = FALSE)
#' @param asset A string containing an asset symbol, e.g. \emph{btc} (optional argument). Run \code{get_assets()} to get all available assets.
#' @param api_key A string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A list or data.frame containing data on assets.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Get all assets available on 'Cryptowatch'
#' df.assets <- get_assets()
#' # Bitcoin asset details
#' asset.btc <- get_assets("btc")
#' }
#'
#' @export
get_assets <- function(asset = NULL, api_key = NULL, allowance = FALSE) {

  data <- get_data(asset, "assets", api_key, allowance)

  return(data)

}
