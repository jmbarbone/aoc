#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------
x <- readLines("2022/data/01")
x <- as.integer(x)

sums <-
  x |>
  split(cumsum(is.na(x))) |>
  sapply(sum, na.rm = TRUE)

solution_1 <- max(sums)

solution_2 <-
  sums |>
  sort(decreasing = TRUE) |>
  head(3) |>
  sum()


# test --------------------------------------------------------------------

solutions <- readLines("2022/solutions/01")

stopifnot(
  solution_1 == solutions[1],
  solution_2 == solutions[2]
)
