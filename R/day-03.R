input <- read.table("data/day-03.txt", sep = "", as.is = TRUE, comment.char = "")

mat <- t(sapply(strsplit(input[[1]], ""), as.matrix))

N <- nrow(mat)
nc <- ncol(mat)
x <- (2:N)
y <- (x - 1) * 3 + 1

some <- TRUE
while (some) {
  ind <- y > nc
  some <- any(ind)
  y[ind] <- y[ind] - nc
}

out <- mapply(function(xx, yy) mat[xx, yy], xx = x, yy = y)
stopifnot(length(out) == N - 1)
sum(out == "#") # 244


slope_it <- function(right, down) {
  x <- seq.int((1 + down), to = N, by = down)
  y <- (seq_along(x)) * right + 1

  some <- TRUE
  while (some) {
    ind <- y > nc
    some <- any(ind)
    y[ind] <- y[ind] - nc
  }

  out <- mapply(function(xx, yy) mat[xx, yy], xx = x, yy = y)
  sum(out == "#")
}

stopifnot(slope_it(3, 1) == 244)

res <- mapply(
  slope_it,
  right = c(1, 3, 5, 7, 1),
  down =  c(1, 1, 1, 1, 2)
)
res       # [1]  90 244  97  92  48
prod(res) # 9406609920

