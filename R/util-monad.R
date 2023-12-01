# Monad

#' Bind a monad
#' @param m A monad
#' @param f A function to bind against the monad
#' @export
bind <- function (m, ...)
    UseMethod ("bind", m)

#' Infix bind
#' @param m A monad
#' @param f A function to bind against the monad
#' @export
`%>>=%` <- bind

#' Bind a monad, albeit discard the initial result
#' @param m A monad
#' @param f A function to bind against the monad
#' @export
mdiscard <- function (m, f)
    m %>>=% \(x) return (f)

#' Infix bind-discard
#' @param m A monad
#' @param f A function to bind against the monad
#' @export
`%>>%` <- mdiscard

#' Join a monad
#' @param m A monad
#' @export
join <- function (m)
    m %>>=% identity

# Comonad

#' Extract a value from a comonad
#' @param cm A comonad
#' @export
extract <- function (cm, ...)
    UseMethod ("extract", cm)

#' Extend takes a function and applies it to the comonad's attribute
#' @param cm A comonad
#' @param f  A function
extend <- function (cm, ...)
    UseMethod ("extend", cm)

#' Create two comonads from a single one
#' @param cm A comonad
duplicate <- function (cm)
    return (extend (cm, identity))
