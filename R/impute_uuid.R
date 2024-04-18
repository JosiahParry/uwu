#' Impute UUID for missing values
#'
#' This function imputes a v4 UUID by refernce into a character
#' vector. Be careful. This operation cannot be undone!
#'
#' @param x a character vector.
#' @examples
# x <- c("a", NA, "c")
# impute_uuid(x)
#' @export
impute_uuid <- function(x, prefix = NULL) {
  if (is.null(prefix)) {
    prefix <- ""
  }

  impute_uuid_(x, prefix)
  invisible(x)
}
