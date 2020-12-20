input <- readLines("data/day-06.txt")

splits <- split(input, cumsum(input == ""))
counts <- sapply(splits, function(x) {
  length(unique(unlist(strsplit(x, ""))))
})

sum(counts) # 6161


# Part 2 ------------------------------------------------------------------

counts2 <- sapply(splits, function(x) {
  x <- x[x != ""]
  n <- length(x)
  s <- unlist(strsplit(x, ""))
  sum(tapply(s, s, length) == n)
})

sum(counts2) # 2971
