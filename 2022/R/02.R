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

x <- read.table("2022/data/02", col.names = c("opponent", "me"))
solutions <- readLines("2022/solutions/02")

count <- with(x, table(opponent, me))
result <- matrix(c(3L, 6L, 0L, 0L, 3L, 6L, 6L, 0L, 3L), byrow = TRUE, nrow = 3)
dimnames(result) <- dimnames(count)
play <- matrix(rep(1:3, 3), byrow = TRUE, nrow = 3)
dimnames(play) <- dimnames(count)

res1 <- sum(count * (result + play))

result2 <- matrix(rep(c(0L, 3L, 6L), each = 3), ncol = 3)
dimnames(result2) <- dimnames(count)
play2 <- matrix(c(3L, 1L, 2L, 1L, 2L, 3L, 2L, 3L, 1L), ncol = 3)
dimnames(play2) <- dimnames(count)

res2 <- sum(count * (result2 + play2))

stopifnot(
  res1 == solutions[1],
  res2 == solutions[2]
)

