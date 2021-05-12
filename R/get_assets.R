#' Get asset details
#' @usage get_assets(asset = NULL)
#' @param asset A string containing an asset symbol, e.g. \emph{btc}. Optional argument.
#'
#' @return data A list containing asset data.
#'
#' @export
get_assets <- function(asset = NULL) {

  data <- get_data(asset, "assets")

  return(data)

}
