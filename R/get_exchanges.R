#' Get exchange details
#'
#' Get information on exchanges.
#'
#' @usage get_exchanges(exchange = NULL, api_key = NULL, allowance = FALSE)
#' @param exchange A string containing an exchange symbol, e.g. \emph{kraken}
#' (optional argument). Run \code{get_exchanges()} to get a list of exchanges.
#' @param api_key A string containing the API key. See
#' \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create
#' an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the
#' function returns a list which includes allowance information, i.e. cost of
#' the request, remaining credits and your account name.
#'
#' @return A list or data frame containing data on exchanges.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Get all available exchanges
#' df_exchanges <- get_exchanges()
#' # Get information on the exchange Kraken
#' exchange_kraken <- get_exchanges("kraken")
#' }
#'
#' @export
get_exchanges <- function(exchange = NULL, api_key = NULL, allowance = FALSE) {

  data <- get_data(exchange, "exchanges", api_key, allowance)

  return(data)

}
