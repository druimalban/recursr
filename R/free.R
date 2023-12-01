#' `Free` constructor of a free monad
#' @param fnct A given functor
#' @export
Free <- function (fnct) {
    res         = list (type = "Free", functor = fnct)
    class (res) = append (class (res), "free.monad")
    return (res)
}
#' `Pure` constructor of a free monad
#' @param fnct A given functor
#' @export
Pure <- function (fnct) {
    res         = list (type = "Pure", functor = fnct)
    class (res) = append (class (res), "free.monad")
    return (res)
}

#' Check if the `Free` constructor governs an expression
#' @param fr A free monad
#' @export
is.Free <- function (fr) {
    if ("free.monad" %in% class (fr))
        return (fr$type == "Free")
    else return (F)
}
#' Check if the `Pure` constructor governs an expression
#' @param fr A free monad
#' @export
is.Pure <- function (fr) {
    if ("free.monad" %in% class (fr))
        return (fr$type == "Pure")
    else return (F)
}

#' Bind operation for a free monaad
#' @param fr A free monad
#' @param f A function to bind
#' @export
bind.free.monad <- function (fr, f) {
    if (is.Pure (fr))
        return (f (fr$functor))
    else if (is.Free (fr)) {
        x     = fr$functor
        bind_ = \(m) bind.free.monad (m, f)
        inner = fmap (x, bind_)
        freeM = Free (inner)
        return (freeM)
    }
}

escape.free.monad <- Pure

#' Flat-map over a free monaad
#' @param fr A free monad
#' @param f A function to flat-map
#' @export
fmap.free.monad <- function (fr, f)
    fr %>>=% \(x) escape.free.monad (f (x))

#' Lift a functor into the free monad
#' @param fnct A functor
#' @export
liftF <- function (fnct)
    return (Free (Pure %<$>% fnct))
