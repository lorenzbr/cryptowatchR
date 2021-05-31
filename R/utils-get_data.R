#' Get data from Cryptowatch
#' @param ... Arguments to be passed to or from other methods.
#' @noRd
get_data <- function(...) {

  path <- get_cryptowatch_url()

  type <- list(...)

  path <- file.path(path, type[[2]])

  if ( !is.null(type[[1]]) ) path <- file.path(path, type[[1]])

  if ( !is.null(type[[3]]) ) path <- paste0(path, "?apikey=", type[[3]])

  request <- httr::GET(path)

  request$status_code

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if (!grepl("^2", as.character(request$status_code))) stop(request$status_code, " ", data$error)

  data <- data[[1]]

  return(data)

}
