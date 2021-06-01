#' Get data from Cryptowatch
#' @param ... Arguments to be passed to or from other methods.
#' @noRd
get_data <- function(...) {

  path <- get_cryptowatch_url()

  type <- list(...)

  input <- type[[1]]
  endpoint <- type[[2]]
  api_key <- type[[3]]
  allowance <- type[[4]]

  path <- file.path(path, endpoint)

  if ( !is.null(input) ) path <- file.path(path, input)

  if ( !is.null(api_key) ) path <- paste0(path, "?apikey=", api_key)

  request <- httr::GET(path)

  request$status_code

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if (!grepl("^2", as.character(request$status_code))) stop(request$status_code, " ", data$error)

  if (allowance == FALSE) data <- data[[1]]

  return(data)

}
