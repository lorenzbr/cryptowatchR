#' Get exchange details
#' @usage get_exchanges(exchange = NULL)
#' @param exchange A string containing an exchange symbol, e.g. \emph{kraken}. Optional argument.
#'
#' @return data A list containing exchange data.
#'
#' @export
get_exchanges <- function(exchange = NULL) {

  data <- get_data(exchange, "exchanges")

  return(data)

}
