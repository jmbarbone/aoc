x <- readLines("data/day-03.txt")
splits <- vapply(strsplit(x, ""), \(i) as.integer(unlist(i)), integer(12))
mat <- matrix(splits, ncol = 12, byrow = TRUE)

day_03a <- function(mat) {
  bits <- apply(mat, 2, \(i) round(mean(i)))
  bits <- as.integer(bits)
  gamma <- strtoi(paste(bits, collapse = ""), base = 2)
  bits_switched <- c(1L, 0L)[bits + 1]
  epsilon <- strtoi(paste(bits_switched, collapse = ""), base = 2)
  gamma * epsilon
}

day_03b <- function(mat) {
  find_oxygen(mat) * find_c02(mat)
}

find_oxygen <- function(m) {
  i <- 0
  
  while (nrow(m) > 1) {
    i <- i + 1
    val <- if (mean(m[, i]) >= 0.5) 1L else 0L
    # I prefer the last value the one checked in the conditional
    m <- m[m[, i] == val, , drop = FALSE]
  }
  
  strtoi(paste(m, collapse = ""), base = 2)
}

find_c02 <- function(m) {
  i <- 0
  
  while (nrow(m) > 1) {
    i <- i + 1
    # switch the values
    val <- if (mean(m[, i]) >= 0.5) 0L else 1L
    m <- m[m[, i] == val, , drop = FALSE]
  }
  
  strtoi(paste(m, collapse = ""), base = 2)
}

stopifnot(
  identical(day_03a(mat), 2724524L),
  identical(day_03b(mat), 2775870L)
)
