#' Construct a `Right` value of the Either monad
#' @param x A value wrapped by `Right`
#' @export
Right <- function (x) {
    res         = list (type = "Right", carrier = x)
    class (res) = "Either"
    return (res)
}
#' Construct a `Left` value of the Either monad
#' @param x A value wrapped by `Left`
#' @export
Left <- function (x) {
    res         = list (type = "Left", attr = x)
    class (res) = "Either"
    return (res)
}

#' Check if a value is a `Right` Either monad
#' @param x A value to check
#' @export
is.Right <- function (x) {
    if ("Either" %in% class (x))
        return (x$type == "Right")
    else return (FALSE)
}
#' Check if a value is a `Right` Either monad
#' @param x A value to check
#' @export
is.Left <- function (x) {
    if ("Either" %in% class (x))
        return (x$type == "Left")
    else return (FALSE)
}

#' Compare two Either monads
#' @param x An Either monad
#' @param y Another Either monad
#' @export
'==.Either' <- function (x, y) {
    if ((is.Right (x) && is.Right (y)))
        return (x$carrier == y$carrier)
    else if (is.Left (x) && is.Left (y))
        return (x$attr == y$attr)
    else return (F)
}

#' Run a function depending on whether an Either value is `Left` or `Right`
#' @param fl A function to run on the value held by a `Left` value
#' @param fr A function to run on the value held by a `Right` value
#' @param ex A value to check
#' @export
either <- function (fl, fr, ex) {
    if (is.Right (ex))
        return (fr (ex$carrier))
    else if (is.Left (ex))
        return (fl (ex$attr))
    else stop ("Not an Either value!")
}

## Functor
#' Map over an Either monad
#' @param x An Either monad
#' @param f A function to map
#' @export
fmap.Either <- function (ex, f) {
    if (is.Left (ex))
        return (ex)
    else
        return (Right (f (ex$carrier)))
}

## Monad
#' Bind a list
#' @param ex An Either monad
#' @param f A function to bind against the Either monad
#' @export
bind.Either <- function (ex, f) {
    if (is.Left (ex))
        return (ex)
    else {
        return (f (ex$carrier))
    }
}
