check_status <- function() {
  request <- httr::GET( "https://api.cryptowat.ch/markets/kraken/btceur/price")
  if (!startsWith(as.character(request$status_code), "2"))
    skip("Request failed.")
}
