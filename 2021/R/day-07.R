x <- as.integer(strsplit(readLines("data/day-07.txt"), ",")[[1]])

day_07a <- function(x) {
  sum(abs(x - median(x)))
}

day_07b <- function(x) {
  ans <- Inf
  
  for (i in unique(x)) {
    res <- sum(iterative_cumsum(abs(x - i)))
    if (res < ans) ans <- res
  }
  
  ans
}

iterative_cumsum <- function(n) (n^2 + n) / 2
reverse_cumsum <- function(n) (-1 + sqrt(1 + 8 * n)) / 2


# test --------------------------------------------------------------------

stopifnot(
  day_07a(x) == 356958L,
  day_07b(x) == 105461913
)
