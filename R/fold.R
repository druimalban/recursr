#' The catamorphism
#'
#' @param alg  An algebra
#' @param expr An initial expression
#' @examples
#' len <- function (lst) {
#'   ln = function (st) {
#'     if (is.NilF (st)) {
#'       return (0)
#'     }
#'     else if (is.ConsF (st)) {
#'       return (1 + st$carrier)
#'     }
#'   }
#'   return (cata (ln, lst))
#' }
#' len (list (1,2,3,4))
#'
#' @export
cata <- function (alg, expr)
  project (expr) |> fmap (\(x) cata (alg, x)) |> alg ()

#' The paramorphism
#'
#' @param alg An algebra
#' @param expr An initial expression
#' @examples
#' tailL <- function (lst) {
#'     alg = function (l) {
#'         if (is.NilF (l))
#'             return (list())
#'         else {
#'             x  = l$attr
#'             xs = l$carrier
#'             xsa = first (xs)
#'             xsc = second (xs)
#'
#'             return (xsa)
#'         }
#'     }
#'     return (para (alg, lst))
#' }
#'
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
#' @examples
#' oddIndices <- function (lst) {
#'   alg = function (l) {
#'     if (is.NilF (l))
#'       return (list())
#'     else {
#'       h0  = l$attr
#'       cf0 = l$carrier
#'       xs0 = peelBack (l$carrier)
#'
#'       if (is.NilF (xs0))
#'         return (list (h0))
#'       else {
#'         cf1 = xs0$carrier
#'         t1  = currElement (cf1)
#'
#'         return (c(h0, t1))
#'       }
#'     }
#'   }
#'   return (histo (alg, lst))
#' }
#'
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
