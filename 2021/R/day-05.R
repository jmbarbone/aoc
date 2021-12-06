

#  x1, y1 ->  x2, y2
# 565,190 -> 756,381
# .. is transformed to ...
#     x   y
# 1 565 190
# 2 756 381


x <- 
  readLines("data/day-05.txt") |>
  strsplit(" -> ") |>
  lapply(\(i) vapply(strsplit(i, ","), as.integer, integer(2))) |>
  lapply(\(i) {
    dimnames(i) <- list(c("x", "y"), 1:2)
    t(i)
  })


day_05a <- function(x) {
  do_solution(x[vapply(x, is_horizontal, NA)])
}

day_05b <- function(x) {
  do_solution(x)
}

do_solution <- function(x) {
  n <- max(unlist(x))
  board <- matrix(0L, nrow = n, ncol = n)
  
  for (m in x) {
    pos <- intersect_points(m)
    board[pos] <- board[pos] + 1L
  }
  
  sum(board >= 2)
}

intersect_points <- function(m) {
  x <- seq.int(m[1], m[2])
  y <- seq.int(m[3], m[4])
  cbind(x, y) 
}

is_horizontal <- function(m) {
  (m[1] == m[2]) | (m[3] == m[4])
}

stopifnot(
  identical(day_05a(x), 8622L),
  identical(day_05b(x), 22037L)
)
