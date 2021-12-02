input <- readLines("data/day-09.txt")
# as.integer() will produce errors because they are outside range
input <- as.numeric(input)

is_valid <- function(pos) {
  prev <- input[pos:(pos - 25)]
  any(prev %in% (input[pos] - prev))
}

invalid_pos <- which(!sapply(26:length(input), is_valid)) + 25
result1 <- input[invalid_pos]

stopifnot(result1 == 85848519)


# Part 2 ------------------------------------------------------------------

combs <- combn(seq_along(input), 2)
res <- apply(combs, 2, function(x) {
  r <- input[x[1]:x[2]]
  if (sum(r) == result1) {
    sum(range(r))
  } else {
    NA_real_
  }
})

result2 <- res[!is.na(res)]
stopifnot(result2 == 13414198)
