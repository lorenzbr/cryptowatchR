#' Get asset details
#'
#' Get asset information for cryptocurrencies.
#'
#' @usage get_assets(asset = NULL)
#' @param asset A string containing an asset symbol, e.g. \emph{btc}. Optional argument.
#'
#' @return data A list or data.frame containing asset data.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' asset.data <- get_assets("btc")
#' df.assets <- get_assets()
#' }
#'
#' @export
get_assets <- function(asset = NULL) {

  data <- get_data(asset, "assets")

  return(data)

}
