Full package documentation is [hosted on Github pages](https://druimalban.github.io/)!

# Generalised folds and unfolds for R
## Preface

This is an experiment in porting the Haskell
[`recursion-schemes`](https://hackage.haskell.org/package/recursion-schemes)
package to R.

The library provides generalised folding and unfolding functions, which can be
applied to a large number of data structures. The library provides just enough
of the Haskell language infrastructure to make it possible to use the following
higher-order functions:

  - The catamorphism and its categorical dual the anamorphism
  - The paramorphism and its categorical dual the apomorphism
  - The histomorphism and its categorical dual the futumorphism
  
Refolds like the hylomorphism are not implemented, but using building-blocks
and the examples of the code provided, it should be feasible to
implement these.

## Tutorial articles (vignettes) and package license

[The first package vignette](https://druimalban.github.io/articles/list-morphisms.html) 
is a tutorial on making use of the various morphisms with the familiar list type. 
This is primarily a demonstration of each function rather than an explanation of
how to implement a "base" functor for a given type.

[The second package vignette](https://druimalban.github.io/articles/tree-morphisms.html)
explores implementation of fmap for the `data.tree` package's `Node` type,
implementation of a "base" functor for this type. 
Because of that package's unpredictable behaviour, the vignette then explores
implementation of a basic `Tree` type. 
Finally, it explores implementation of a monad instance for the basic `Tree` 
type, and testing it against the monad laws.

[The third package vignette](https://druimalban.github.io/articles/fixed-point-programming.html)
explores using fixed-points instead of `project()`/`embed()`, 
and demonstrates this using Peano numbers.
When I was building/testing the library, I used fixed-points instead of the 
`project()`/`embed()` functions, but I later replaced that code with those 
functions, and also adapted the "base" functor of a list to demonstrate the 
package, so this library is to an extent adapted from the Haskell
`recursion-schemes` package. It isn't clear to me what the implications are in
terms of software licensing when adapting code/ideas (other libraries which 
implement recursion-schemes such as SCALA's
[`matryoshka`](https://github.com/precog/matryoshka/tree/master)
don't share the same license as `recursion-schemes`), so I've applied the same
license (BSD 2-Clause) with a note of attribution. My own code is licensed under
BSD 2-Clause.

## Recursion schemes
  
My initial explorations of catamorphisms and anamorphisms was largely inspired
by the following, excellent, series of blog-posts: 
https://blog.ploeh.dk/2017/10/04/from-design-patterns-to-category-theory/
(Seemann's book *Code that Fits in Your Head* also happens to be very good.)

Other resources which are fairly accessible include the following:

  - https://jtobin.io/practical-recursion-schemes (this is a series)
  - https://blog.sumtypeofway.com/posts/introduction-to-recursion-schemes.html (this is a series)
  - https://fho.f12n.de/posts/2014-05-07-dont-fear-the-cat.html
  - https://arxiv.org/pdf/2202.13633.pdf

I think that others are better able to explain the theory behind the various
recursion schemes in a more accurate and insightful manner than I can, so the
function reference tends to be fairly sparse, although every function is
documented, and the tutorial vignettes describe usage.
Some of the terminology can also be confusing, and Haskell examples provided by
others tend to be more succint and clearer than my corresponding implementation
in R. 

## Additional features implemented

Futu and histo depend on the free monad and the cofree comonad, and para and apo
depend on the either monad and tuples. As such, the following language features
are also implemented:

  - S3 methods for functors (`fmap()`)
  - S3 methods for monads (bind a.k.a. `>>=`, discard a.k.a. `>>`, and `join()`)
  - S3 methods for comonads (`extract()`, `extend()`, and `duplicate()`)
  - Infix pipes which work like the Haskell infix operators, surrounded by percentage signs similar to magrittr pipes
  
Thus enabling the following:
  
  - The free monad and the cofree comonad
  - An fmap and bind implementation for a list
  - "Base" functor for a list, which represents the list functor at a given point in recursion
  - The Either monad, as well as Tuple, with a fmap implementation for both and a bind implementation for Either. Not all tuples are monads.

Note that Haskell has another typeclass, which bears mentioning, Applicative.
In fact, all monads are applicative functors. However, some Applicative 
instances are pretty unintuitive, and there is invariably more than one possible
Applicative instance, so I've not implemented Applicative for any of the types 
in this package.

## Miscellaneous remarks

Pattern-matching—not supported in base R, and the various libraries do
not work like in Haskell—would have made many of my R functions much more
succint.

Type signatures would have been helpful especially when implementing
building-blocks like fmap and free/cofree.
Indeed, R is not strongly-typed—it will freely coerce values—but the S3 class
system does at least enable writing functions which are specific to a given
functor/monad, e.g. the bind implementation for Either only applies to Either
values.