#' The anamorphism, categorical dual of the catamorphism
#'
#' @param coalg A coalgebra
#' @param expr A terminal expression
#' @export
ana <-  function (coalg, expr)
    coalg (expr) |> fmap (\(x) ana (coalg, x)) |> embed ()

#' The apomorphism, categorical dual of the paramorphism
#'
#' @param coalg A coalgebra
#' @param expr A terminal expression
#' @export
apo <- function (coalg, expr) {
    worker = function (x)
        either (identity, \(a) apo (coalg, a), x)
    coalg (expr) |> fmap (worker) |> embed ()
}

#' The futumorphism, categorical dual of the histomorphism
#'
#' @param coalg A coalgebra
#' @param expr A terminal expression
#' @export
futu <- function (coalg, a) {
    worker = function (x) {
        if (is.Pure (x))
            return (futu (coalg, x$functor))
        else if (is.Free (x)) {
            return (embed (fmap (x$functor, worker)))
        }
        else stop ("Not a free monad!")
    }
    coalg (a) |> fmap (worker) |> embed ()
}
