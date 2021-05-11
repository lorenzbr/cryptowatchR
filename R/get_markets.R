#' Get price data for crypto currencies
#' @usage get_markets(pair, params, exchange = "kraken", route = "ohlc")
#' @param pair A string containing a pair symbol, e.g. (btcusd). Required argument.
#' @param params A list containing before, after and periods (optional).
#' @param exchange A string containing the exchange. Default is kraken.
#' @param route A string containing market prices. Default is ohlc.
#'
#' @return df.markets A data frame containing price data for given arguments.
#'
#' @export
get_markets <- function(pair, params = NULL, exchange = "kraken", route = "ohlc") {

  path <- get_cryptowatch_url()

  col.names <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  path <- file.path(path, "markets", exchange, pair, route)

  if (is.null(params)) request <- httr::GET(path)

  if (!is.null(params)) request <- httr::GET(path, query = params)

  request$status_code

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  markets <- jsonlite::fromJSON(response, flatten = TRUE)

  df.markets <- data.frame(markets[[1]][[1]])

  names(df.markets) <- col.names

  return(df.markets)

}
