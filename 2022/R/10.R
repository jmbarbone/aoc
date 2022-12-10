#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- readLines("2022/data/10-sample")
commands <- regmatches(data, regexec("(?<=\\s)-?[0-9]+$", data, perl = TRUE))
commands <- as.integer(commands)
none <- is.na(commands)
commands[none] <- 0L
values <- 1 + cumsum(commands)
cycles <- rep(2L, length(commands))
cycles[none] <- 1L
# cycles[1L] <- cycles[1L] + 2L
results <- c(1, 1, rep(values, times = cycles))
stopifnot(
  results[20] == 21,
  results[60] == 19,
  results[100] == 18,
  results[140] == 21,
  results[180] == 16,
  results[220] == 18
)

solution1 <- NULL
solution2 <- NULL

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/10")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
