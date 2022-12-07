#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- readLines("2022/data/06")

n_unique <- function(x) {
  length(unique(x))
}

foo <- function(string, n = 4L) {
  m <- n - 1L
  x <- strsplit(string, "")[[1]]
  ind <- seq.int(1L, length(x) - m)
  uniques <- vapply(ind, \(i) n_unique(x[i:(i + m)]), NA_integer_)
  which(uniques == n)[1L] + m
}

stopifnot(
  foo("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5L,
  foo("nppdvjthqldpwncqszvftbrmjlhg") == 6L,
  foo("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10L,
  foo("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11L
)

solution1 <- foo(data, 4L)
solution2 <- foo(data, 14L)

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/06")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
