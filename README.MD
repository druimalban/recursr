# Generalised folds and unfolds for R
## Preface

This is an experiment in porting the Haskell recursion-schemes package to R. 
The code should be correct, but it is easy to break, i.e. this is a tech demo.

These are generalised fold and unfolding functions, which can be applied to a
large number of data structures. 

This package includes just enough of the Haskell language infrastructure to make
it possible to use the following recursion schemes:

  - The catamorphism and its categorical dual the anamorphism
  - The paramorphism and its categorical dual the apomorphism
  - The histomorphism and its categorical dual the futumorphism
  
Refolds like the hylomorphism are not implemented, but it should be possible to
implement them using these building blocks.
  
## Recursion schemes
  
This package does not explain what the different recursion schemes actually are.
The initial explorations of catamorphisms and anamorphisms was largely inspired
by the following series of blog-posts. Seemann's book *Code that Fits in Your 
Head* is also very good: 
https://blog.ploeh.dk/2017/10/04/from-design-patterns-to-category-theory/

Other resources which are fairly accessible include the following:

  - https://jtobin.io/practical-recursion-schemes (this is a series)
  - https://blog.sumtypeofway.com/posts/introduction-to-recursion-schemes.html (this is a series)
  - https://fho.f12n.de/posts/2014-05-07-dont-fear-the-cat.html
  - https://arxiv.org/pdf/2202.13633.pdf

## Additional features implemented

Futu and histo depend on the free monad and the cofree comonad, and para and apo
depend on the either monad and tuples. As such, the following language features
are also implemented:

  - S3 methods for functors (flat-map a.k.a. `fmap`)
  - S3 methods for monads (bind a.k.a. `>>=`, discard a.k.a. `>>` and `join`)
  - S3 methods for comonads (`extract`, `extend`, and `duplicate`)
  - Infix pipes which work like the Haskell infix operators, surrounded by percentage signs similar to magrittr pipes
  
Thus enabling the following:
  
  - The free monad and the cofree comonad
  - A flat-map and a bind implementation for a list
  - "Base" functor for a list, which represents the list functor at a given point in recursion
  - The Either monad, as well as Tuple, with a flat-map implementation for both and a bind implementation for Either. Not all Tuples are monads.

Note that Haskell has another typeclass, which bears mentioning, Applicative.
In fact, all monads are all applicative functors. However, some Applicative 
instances are pretty unintuitive, and there is invariably more than one possible
Applicative instance, so I've not implemented Applicative for any of the types 
in this package.

## The R type system (or lack thereof)

R is not strongly-typed - it will freely coerce values - but the S3 class system
does at least enable writing functions which are specific to a given 
functor/monad, e.g. the bind implementation for Either only applies to Either 
values. 

## License

License is BSD 2-Clause as I translated code from the recursion-schemes package into R.
