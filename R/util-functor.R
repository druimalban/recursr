#' Map over a functor
#'
#' @description
#' map is implemented differently for each functor, with each functor
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
#' @param f A function to map
#' @export
fmap <- function (fnct, ...)
    UseMethod ("fmap", fnct)

#' Infix map
#' @param f A function to map
#' @param fnct A functor
#' @export
`%<$>%` <- function (f, fnct)
    fmap (fnct, f)
