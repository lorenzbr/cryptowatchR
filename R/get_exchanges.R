#' Get exchange details
#'
#' Get information on exchanges.
#'
#' @usage get_exchanges(exchange = NULL)
#' @param exchange A string containing an exchange symbol, e.g. \emph{kraken}. Optional argument.
#'
#' @return data A list or data.frame containing exchange data.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' exchange.data <- get_exchanges("kraken")
#' df.exchanges <- get_exchanges()
#' }
#'
#' @export
get_exchanges <- function(exchange = NULL) {

  data <- get_data(exchange, "exchanges")

  return(data)

}
