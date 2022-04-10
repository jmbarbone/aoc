x <- as.integer(strsplit(readLines("data/day-07.txt"), ",")[[1]])

day_07a <- function(x) {
  sum(abs(x - median(x)))
}

day_07b <- function(x) {
  ans <- Inf
  
  for (i in unique(x)) {
    res <- sum(unlist(sapply(abs(x - i), seq_len)))
    if (res < ans) ans <- res
  }
  
  ans
}


# test --------------------------------------------------------------------

stopifnot(
  day_07a(x) == 356958L,
  day_07b(x) == 105461913
)
