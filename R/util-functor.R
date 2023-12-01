#' Flat-map over a functor
#'
#' @description
#' flat-map is implemented differently for each functor, with each functor
#' satisfying the functor laws.
#'
#' Nonetheless this is set up so that unlike in Haskell, we use `fmap (x, f)`
#' rather than fmap f x. The reason for this is to enable use of `fmap()` in
#' native pipes without a placeholder, e.g. `x |> fmap (\(a) a+2)`.
#'
#' In contrast, the infix operator `%<$>%` works as in Haskell as this is more
#' natural.
#'
#' @param x A functor
#' @param f A function to flat-map
#' @export
fmap <- function (fnct, ...)
    UseMethod ("fmap", fnct)

#' Infix flat-map
#' @param f A function to flat-map
#' #' @param fnct A functor
#' @export
`%<$>%` <- function (f, fnct)
    fmap (fnct, f)
