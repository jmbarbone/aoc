#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

x <- readLines("2022/data/03")

splits <-
  x |>
  strsplit("") |>
  lapply(match, c(letters, LETTERS))

ns <- lengths(splits)
half <- ns %/% 2L

solution1 <-
  intersect |>
  mapply(
    mapply(function(i, a, b) i[a:b], i = splits, a = 1L, b = half),
    mapply(function(i, a, b) i[a:b], i = splits, a = half + 1L, b = ns)
  ) |>
  sum()

solution2 <-
  splits |>
  split((seq_along(ns) - 1L) %/% 3L) |>
  vapply(\(i) Reduce(intersect, i), NA_integer_) |>
  sum()

# test --------------------------------------------------------------------

solutions <- readLines("2022/solutions/03")
stopifnot(
  solution1 == solutions[1L],
  solution2 == solutions[2L]
)
