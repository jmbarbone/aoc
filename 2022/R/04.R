#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

df <- read.table("2022/data/04", sep = ",", col.names = c("x", "y"))

parse <- function(x) {
  lapply(strsplit(x, "-"), as.integer)
}

fully_contained <- function(x, y) {
  x <- parse(x)
  y <- parse(y)
  mapply(do_fully_contained, x, y)
}

do_fully_contained <- function(x, y) {
  (x[1] <= y[1] & x[2] >= y[2]) | (x[1] >= y[1] & x[2] <= y[2])
}

solution1 <- sum(with(df, fully_contained(x, y)))

overlapped <- function(x, y) {
  x <- parse(x)
  y <- parse(y)
  mapply(do_overlapped, x, y)
}

do_overlapped <- function(x, y) {
  FALSE |  # just to keep indenting aligned
    (x[1] >= y[1] & x[1] <= y[2]) |
    (y[1] >= x[1] & y[1] <= x[2]) |
    (x[2] >= y[1] & x[2] <= y[2]) |
    (y[2] >= x[1] & y[2] <= x[2])
}

solution2 <- sum(with(df, overlapped(x, y)))

# test --------------------------------------------------------------------

solutions <- readLines("2022/solutions/04")
stopifnot(
  solution1 == solutions[1],
  solution2 == solutions[2]
)
