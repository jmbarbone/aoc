
x <- as.integer(readLines("data/day-01.txt"))

n <- length(x)
res <- sum(x[seq(1, n - 1)] < x[seq(2, n)])

stopifnot(identical(res, 1696L))
