test_that ("list is a functor", {
    f = \(x) x+2
    g = \(x) x+4
    k = list (1,2,3,4)

    expect_setequal (fmap (k, identity), k)

    lhs = fmap (k, purrr::compose (g, f))
    rhs = purrr::compose (\(x) fmap (x, g), \(x) fmap (x, f)) (k)

    expect_setequal (lhs, rhs)
})

test_that ("list is a monad", {
  f = \(x) list (x+2)
  g = \(x) list (x+4)
  k = list (1,2,3,4)

  # Left identity
  lidLHS = k %>>=% f
  lidRHS = list (3,4,5,6)

  expect_setequal (lidLHS, lidRHS)

  # Right identity
  ridLHS = c(f(1), f(2), f(3), f(4)) %>>=% list
  ridRHS = list (3,4,5,6)

  expect_setequal (ridLHS, ridRHS)

  # Associativity
  assocLHS = (k %>>=% f) %>>=% g
  assocRHS = k %>>=% (\(x) f(x) %>>=% g)

  expect_setequal (assocLHS, assocRHS)
})
