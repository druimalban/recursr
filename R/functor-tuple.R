#' Construct a tuple
#' @param x First element
#' @param y Second element
#' @export
Tuple <- function (x, y) {
  res         = list (type = "Tuple", a=x, b=y)
  class (res) = "tuple"
  return (res)
}

#' Get the first element of a object
#' @param x An object
#' @export
first <- function (x, ...)
  UseMethod ("first", x)

#' Get the second element of a object
#' @param x An object
#' @export
second <- function (x, ...)
  UseMethod ("second", x)

#' Get the first element of a tuple
#' @param t A tuple
#' @export
first.tuple <- function (t)
  return (t$a)
#' Get the second element of a tuple
#' @param t A tuple
#' @export
second.tuple <- function (t)
  return (t$b)

#' Compare two tuple objects
#' @param x A tuple
#' @param y Another tuple
#' @export
'==.tuple' <- function (x,y)
  first (x) == first (y) && second (x) == second (y)

#' Flat-map over a tuple
#' @param t A tuple
#' @param f A function to flat-map
#' @export
fmap.tuple <- function (t, f) {
  x = first (t)
  y = second (t)
  return (Tuple (x, f(y)))
}

as.tuple <- function (x, ...)
  UseMethod ("as.tuple")
as.tuple.list <- function (l) {
  if (length (l) != 2)
    stop ("List is not of length 2")
  else
    return (Tuple (l[[1]], l[[2]]))
}

#' Get a text representation of a tuple
#' @param t A tuple
#' @export
as.character.tuple <- function (t)
  paste ('(', first (t), ', ', second (t), ')'
         , sep='')
#' Print a tuple
#' @param t A tuple
#' @export
print.tuple <- function (t)
  print (as.character (t), quote=F)
