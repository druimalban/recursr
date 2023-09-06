#' Construct a cofree comonad
#' @param attr The comonad attribute
#' @param carrier The comonad carrier
#' @export
Cofree <- function (attr, carrier) {
  res         = list (type = "Cofree", attr = attr, carrier = carrier)
  class (res) = append (class (res), "cofree.comonad")
  return (res)
}

#' Infix constructor of a cofree comonad
#' @param attr The comonad attribute
#' @param carrier The comonad carrier
#' @export
`%:<%` <- Cofree

#' Check if an expression is a cofree comonad
#' @param x The value to check
#' @export
is.Cofree <- function (x) {
  if ("cofree.comonad" %in% class (x))
    return (x$type == "Cofree")
  else return (F)
}

#' Extract a value from a cofree comonad
#' @param cfr A cofree comonad
#' @export
extract.cofree.comonad <- function (cfr) {
  return (cfr$attr)
}

#' Take a function and apply it to the comonad's attribute
#' @param cfr A cofree comonad
#' @param f   A function to apply to the cofree comonad's attribute
extend.cofree.comonad <- function (cfr, f) {
  wb = cfr$attr
  bc = cfr$carrier
  return (f(wb) %:<% fmap (bc, \(a) extend (a, f)))
}
