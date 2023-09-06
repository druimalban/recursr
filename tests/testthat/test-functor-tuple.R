test_that ("Either is a functor", {
  f = \(x) x+2
  g = \(x) x+4
  k = Tuple (1,2)

  expect_equal (fmap (k, identity), k)

  lhs = fmap (k, purrr::compose (g, f))
  rhs = purrr::compose (\(x) fmap (x, g), \(x) fmap (x, f)) (k)

  expect_equal (lhs, rhs)
})
