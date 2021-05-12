#' Get data from cryptowatch
#' @param ... Additional arguments.
#' @noRd
get_data <- function(...) {

  path <- get_cryptowatch_url()

  type <- list(...)

  path <- file.path(path, type[[2]])

  if (!is.null(type[[1]])) path <- file.path(path, type[[1]])

  request <- httr::GET(path)

  request$status_code

  response <- httr::content(request, as = "text", encoding = "UTF-8")

  data <- jsonlite::fromJSON(response, flatten = TRUE)

  if (!grepl("^2", as.character(request$status_code))) stop(request$status_code, " ", data$error)

  data <- data[[1]]

  return(data)

}
