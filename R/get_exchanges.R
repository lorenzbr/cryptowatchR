#' Get exchange details
#'
#' Get information on exchanges.
#'
#' @usage get_exchanges(exchange = NULL)
#' @param exchange A string containing an exchange symbol, e.g. \emph{kraken} (Optional argument). Run \code{get_exchanges()} to get a list of exchanges.
#'
#' @return A list or data.frame containing data on exchanges.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Get all available exchanges
#' df.exchanges <- get_exchanges()
#' # Get information on the exchange Kraken
#' exchange.kraken <- get_exchanges("kraken")
#' }
#'
#' @export
get_exchanges <- function(exchange = NULL) {

  data <- get_data(exchange, "exchanges")

  return(data)

}
