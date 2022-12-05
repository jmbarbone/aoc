#!/usr/bin/env -S Rscript --vanilla

# info --------------------------------------------------------------------

#     win  = 6 | r > s; s > p; p > r
#     tie  = 3 | r == r; s == s; r == r
#     loss = 0 | s < r; p < s; r < p
#     rock = 1 | A X
#    paper = 2 | B Y
# scissors = 3 | C Z

# A Y = 6 + 2 = 8
# B X = 0 + 1 = 1
# C Z = 3 + 3 = 6
# total: 15

# x = lose
# y = draw
# z = win
#
# A Y = 1r + 3t = 4
# B X = 1r + 0l = 1
# C Z = 1r + 6w = 7
# total: 12


# solve -------------------------------------------------------------------

x <- read.table("2022/data/02", col.names = c("opponent", "me"))

mat <- function(..., by_row = FALSE) {
  matrix(
    as.integer(unlist(c(...))),
    byrow = by_row,
    ncol = 3L,
    dimnames = list(
      opponent = c("A", "B", "C"),
      me = c("X", "Y", "Z")
    )
  )
}

count <- with(x, table(opponent, me))
result <- mat(3L, 0L, 6L, 6L, 3L, 0L, 0L, 6L, 3L)
play <- mat(rep(1:3, each = 3))

solution1 <- sum(count * (result + play))

result2 <- mat(rep(0:2 * 3, each = 3))
play2 <- mat(3L, 1L, 2L, 1L, 2L, 3L, 2L, 3L, 1L)

solution2 <- sum(count * (result2 + play2))


# test --------------------------------------------------------------------

solutions <- readLines("2022/solutions/02")

stopifnot(
  solution1 == solutions[1],
  solution2 == solutions[2]
)
