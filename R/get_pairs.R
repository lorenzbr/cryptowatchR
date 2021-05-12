#' Get pair of currencies
#' @usage get_pairs(pair = NULL)
#' @param pair A string containing a pair symbol, e.g. \emph{btcusd}. Optional argument.
#'
#' @return data A list containing pair data.
#'
#' @export
get_pairs <- function(pair = NULL) {

  data <- get_data(pair, "pairs")

  return(data)

}
