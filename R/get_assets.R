#' Get asset details
#'
#' Get asset information on cryptocurrencies.
#'
#' @usage get_assets(asset = NULL)
#' @param asset A string containing an asset symbol, e.g. \emph{btc} (optional argument). Run \code{get_assets()} to get all available assets.
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
get_assets <- function(asset = NULL) {

  data <- get_data(asset, "assets")

  return(data)

}
