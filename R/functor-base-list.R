#' Construct a `Nil` value of the list base functor
#' @export
NilF <- function () {
    res         = list (type = "NilF")
    class (res) = "ListF"
    return (res)
}
#' Construct a `Cons` value of the list base functor
#' @param x First list element
#' @param xs Subsequent list elements, constructed with `Cons`
#' @export
ConsF <- function (x, xs) {
    res         = list (type = "ConsF", attr = x, carrier = xs)
    class (res) = "ListF"
    return (res)
}

#' Check if a value is a nil base functor
#' @param x The value to check
#' @export
is.NilF <- function (x) {
    if ("ListF" %in% class (x))
        return (x$type == "NilF")
    else return (FALSE)
}
#' Check if a value is a concatenated list base functor
#' @param x The value to check
#' @export
is.ConsF <- function (x) {
    if ("ListF" %in% class (x))
        return (x$type == "ConsF")
    else return (FALSE)
}

## Functor
#' Flat-map over a list base functor
#' @param x A list base functor
#' @param f A function to flat-map
#' @export
fmap.ListF <- function (lstf, f) {
    if (is.ConsF (lstf)) {
        x  = lstf$attr
        xs = f (lstf$carrier)
        return (ConsF (x, xs))
    }
    else if (is.NilF (lstf)) {
        return (lstf)
    }
}

## Corecursive
#' Wrap a single layer of recursion
#' @param lstf A list base functor
#' @export
embed.ListF <- function (lstf) {
    if (is.NilF (lstf))
        return (list())
    else if (is.ConsF (lstf)) {
        x  = lstf$attr
        xs = lstf$carrier
        return (append (xs, x, after=0))
    }
}
