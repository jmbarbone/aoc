#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

df <- read.table("2022/data/04", sep = ",", col.names = c("x", "y"))

parse <- function(x) {
  lapply(strsplit(x, "-"), as.integer)
}

fully_contained <- function(x, y) {
  x <- parse(x)
  y <- parse(y)
  mapply(function(a, b) {
    (a[1] <= b[1] & a[2] >= b[2]) | (a[1] >= b[1] & a[2] <= b[2])
  },
  a = x,
  b = y)

}

solution1 <- sum(with(df, fully_contained(x, y)))

overlapped <- function(x, y) {
  x <- parse(x)
  y <- parse(y)
  mapply(function(a, b) {

    FALSE |
      (a[1] >= b[1] & a[1] <= b[2]) |
      (b[1] >= a[1] & b[1] <= a[2]) |
      (a[2] >= b[1] & a[2] <= b[2]) |
      (b[2] >= a[1] & b[2] <= a[2]) |
      FALSE
  },
  a = x,
  b = y)

}

solution2 <- sum(with(df, overlapped(x, y)))

# test --------------------------------------------------------------------

solutions <- readLines("2022/solutions/04")
stopifnot(
  solution1 == solutions[1],
  solution2 == solutions[2]
)
