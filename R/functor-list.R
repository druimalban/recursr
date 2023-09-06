## Functor
#' Flat-map over a list
#' @param x A list
#' @param f A function to flat-map
#' @export
fmap.list <- lapply

## Monad
#' Bind a list
#' @param lst A list
#' @param f A function to bind against the list
#' @export
bind.list <- function (lst, f)
  return (purrr::list_flatten (lapply (lst, f)))

## Recursive
#' Unwrap a single layer of recursion
#' @param lst A list
#' @export
project.list <- function (lst) {
  if (length (lst) == 0)
    return (NilF())
  else if (length (lst) == 1)
    return (ConsF (lst[[1]], list()))
  else
    return (ConsF (lst[[1]], lst[2:length(lst)]))
}
