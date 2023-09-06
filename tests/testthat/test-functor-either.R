test_that ("Either is a functor", {
  f = \(x) x+2
  g = \(x) x+4
  k = Right (1)

  expect_equal (fmap (k, identity), k)

  lhs = fmap (k, purrr::compose (g, f))
  rhs = purrr::compose (\(x) fmap (x, g), \(x) fmap (x, f)) (k)

  expect_equal (lhs, rhs)
})

test_that ("Either is a monad", {
  f = \(x) Right (x+2)
  g = \(x) Right (x+4)
  k = Right (2)

  # Left identity
  lidLHS = k %>>=% f
  lidRHS = Right (4)

  expect_equal (lidLHS, lidRHS)

  # Right identity
  ridLHS = f(2) %>>=% Right
  ridRHS = Right (4)

  expect_equal (ridLHS, ridRHS)

  # Associativity
  assocLHS = (k %>>=% f) %>>=% g
  assocRHS = k %>>=% (\(x) f(x) %>>=% g)

  expect_equal (assocLHS, assocRHS)
})
