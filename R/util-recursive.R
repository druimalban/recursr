#' Unwrap a single layer of recursion
#' @param f A functor
#' @export
project <- function (x, ...)
  UseMethod ("project", x)

#' Wrap a single layer of recursion
#' @param bf A base functor
#' @export
embed <- function (x, ...)
  UseMethod ("embed", x)
