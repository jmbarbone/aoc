input <- readLines("data/day-10.txt")
input <- as.integer(input)

diffs <- diff(sort(c(0, input, max(input) + 3)))
result1 <- prod(sum(diffs == 1), sum(diffs == 3))
result1
stopifnot(result1 == 2030)


# Part 2 ------------------------------------------------------------------

sorted <- sort(c(0, input, max(input) + 3))
diffs <- diff(sorted)

# Between all of these are 3 points
splits <- sapply(split(diffs, cumsum(diffs == 3)), function(x) x[x == 1])

tribonacci <- function(n) {
  if (n < 2) {
    return(1)
  }

  out <- c(0, 0, 1)
  for (i in 1:n) {
    out <- c(out, sum(tail(out, 3)))
  }

  out[3 + n]
}

result2 <- prod(sapply(splits, function(x) tribonacci(length(x))))
print(result2, digits = 9)
format(result2, scientific = FALSE)
stopifnot(result2 == 42313823813632)
