x <- as.integer(strsplit(readLines("data/day-06.txt"), ",")[[1]])

day_06x <- function(x) {
  # Not great
  for (i in 1:80) {
    x <- x - 1L
    new <- x == -1L
    
    if (any(new)) {
      # just make it 9 instead of 8
      x[new] <- 6L
      x <- c(x, rep(8L, sum(new)))
    }
  }
  
  length(x)
}


day_06a <- function(x) {
  do_day_06_solution(x, 80)
}

day_06b <- function(x) {
  do_day_06_solution(x, 256)
}
 
do_day_06_solution <- function(x, n) {
  counts <- rep(0, 9)
  names(counts) <- 0:8
  tab <- table(x)
  counts[names(tab)] <- tab
  
  for (i in seq_len(n)) {
    zeros <- counts[1]
    counts <- c(counts[-1], counts[1])
    counts[7] <- counts[7] + zeros
  }
  
  sum(counts)
}


# test --------------------------------------------------------------------


stopifnot(
  day_06a(x) == 388739,
  day_06b(x) == 1741362314973
)
