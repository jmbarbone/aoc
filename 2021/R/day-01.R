
x <- as.integer(readLines("data/day-01.txt"))

day_01a <- function(x) {
  n <- length(x)
  sum(x[seq(1, n - 1)] < x[seq(2, n)])
}

day_01b <- function(x) {
  n <- length(x)
  y <- RcppRoll::roll_sum(x, 3)
  sum(y[seq(1, n - 1)] < y[seq(2, n)], na.rm = TRUE)
}

stopifnot(
  identical(day_01a(x), 1696L),
  identical(day_01b(x), 1737L)
)
