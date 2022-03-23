#' Get 24-hour summary of cryptocurrencies
#'
#' Get 24-hour summary of cryptocurrencies using the REST API of cryptowat.ch.
#' The route is \emph{summary} or \emph{summaries} and returns the current
#' 24-hour summary of a given pair or a summary of all pairs. See
#' \url{https://docs.cryptowat.ch/rest-api/markets/summary} for further information.
#'
#' @usage get_summary(pair, keyBy = NULL, exchange = "kraken", api_key = NULL,
#' allowance = FALSE)
#' @param pair A character string containing a pair symbol, e.g. \emph{btcusd}
#' (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param keyBy A single character string. Possible values are are either
#' \emph{id} or \emph{symbols}.
#' @param exchange A character string containing the exchange. Default is
#' \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param api_key A character string containing the API key. See
#' \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create
#' an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the
#' function returns a list which includes allowance information, i.e. cost of
#' the request, remaining credits and your account name.
#'
#' @return Current 24-hour summary of a given pair of currencies. If allowance
#' is \code{TRUE}, \code{get_summary()} returns a list with additional
#' information on allowances.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_current_price}},
#' \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # 24h-hour summary of cryptocurrency pairs
#' summary <- get_summary("btcusd")
#' summaries <- get_summary()
#' summaries2 <- get_summary(keyBy = "id")
#' summaries3 <- get_summary(keyBy = "symbols")
#' }
#' @export
get_summary <- function(pair = NULL, keyBy = NULL, exchange = "kraken",
                        api_key = NULL, allowance = FALSE) {

  route <- ifelse(!is.null(pair), "summary", "summaries")

  params <- list(keyBy = keyBy)

  summary <- get_markets(route = route, pair = pair, exchange = exchange,
                         params = params, api_key = api_key,
                         allowance = allowance)

  if (allowance) {

    allowance_list <- summary[[2]]
    summary <- summary[[1]]

  }

  if (is.null(pair)) {

    df1 <- as.data.frame(do.call(rbind, summary))
    df2 <- as.data.frame(do.call(rbind, df1$price))
    df3 <- as.data.frame(do.call(rbind, df2$change))

    df1 <- df1[, c("volume", "volumeQuote")]
    df2 <- df2[, c("last", "high", "low")]
    df3 <- df3[ , c("percentage", "absolute")]

    summary <- cbind(df2, df3, df1)

  }

  if (allowance) {

    output <- list(result = summary, allowance = allowance_list)

  } else if (allowance == FALSE) {

    output <- summary

  }

  return(output)

}
