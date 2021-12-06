

#  x1, y1 ->  x2, y2
# 565,190 -> 756,381
# .. is transformed to ...
#     x   y
# 1 565 190
# 2 756 381

intersect_points <- function(m) {
  x <- seq(m[1], m[2])
  y <- seq(m[3], m[4])
  
  if (length(x) == 1L | length(y) == 1L) {
    return(as.matrix(expand.grid(x, y)))
  }
  
  if (length(x) != length(y)) {
    stop("this is wrong?")
  }
  
  cbind(x, y)
}


is_horizontal <- function(m) {
  (m[1] == m[2]) | (m[3] == m[4])
}

x <- 
  readLines("data/day-05.txt") |>
  strsplit(" -> ") |>
  lapply(\(i) vapply(strsplit(i, ","), as.integer, integer(2))) |>
  lapply(\(i) {
    dimnames(i) <- list(c("x", "y"), 1:2)
    t(i)
  })

head(x)

# get only horizontal lines

are_horizontal <- vapply(x, is_horizontal, NA)
m <- x[!are_horizontal][[1]]


n <- max(unlist(x))
board <- matrix(0L, nrow = n, ncol = n)

for (m in x[are_horizontal]) {
  pos <- intersect_points(m)
  board[pos] <- board[pos] + 1L
}

res <- sum(board >= 2)
stopifnot(res == 8622)

board <- matrix(0L, nrow = n, ncol = n)

for (m in x) {
  pos <- intersect_points(m)
  board[pos] <- board[pos] + 1L
}

res <- sum(board >= 2)
stopifnot(res == 22037)
