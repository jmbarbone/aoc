
day_01 <- function() {
  x <- as.integer(readLines("data/day-01.txt"))
  n <- length(x)
  sum(x[seq(1, n - 1)] < x[seq(2, n)])
}

stopifnot(identical(day_01(), 1696L))
