#' The catamorphism
#'
#' @param alg  An algebra
#' @param expr An initial expression
#' @export
cata <- function (alg, expr)
    project (expr) |> fmap (\(x) cata (alg, x)) |> alg ()

#' The paramorphism
#'
#' @param alg An algebra
#' @param expr An initial expression
#' @export
para <- function (alg, expr) {
    worker = function (x)
        return (Tuple (x, para (alg, x)))
    project (expr) |> fmap (worker) |> alg ()
}

#' The histomorphism
#'
#' @param alg An algebra
#' @param expr An initial expression
#' @export
histo <- function (alg, expr) {
    mkTuple = function (a)
        return (Tuple (alg (a), identity (a)))
    mkAttr = function (t) {
        a = first  (t)
        b = second (t)
        return (Cofree (a, b))
    }
    worker = function (k) {
        project (k) |>
            fmap (worker) |>
            mkTuple () |>
            mkAttr ()
    }
  
    worker (expr) |> extract.cofree.comonad ()
}
