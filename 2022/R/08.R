#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- readLines("2022/data/08")
data <- do.call(rbind, strsplit(data, ""))
mode(data) <- "integer"

# data <- matrix(c(3,0,3,7,3,2,5,5,1,2,6,5,3,3,2,3,3,5,4,9,3,5,3,9,0), ncol = 5, byrow = TRUE)

is_visible <- function(x) {
  left <- do_is_visible(x)
  right <- do_is_visible(rev(x))
  left[1L] <- TRUE
  right[1L] <- TRUE
  left | rev(right)
}

do_is_visible <- function(x) {
  x <- as.numeric(x)
  is_greater_lead(x, roll_max(x))
}

# x <- c(2, 1, 0, 0, 2, 1, 2, 2, 3, 2, 0, 0, 1, 2)
# x <- rev(x)
# data.frame(x, v = is_visible(x), m = roll_max(x), l = is_greater_lead(x, roll_max(x)))

is_greater_lead <- function(x, y = x) {
  c(TRUE, c(x[-1L] > y[-length(y)]))
}

roll_max <- function(x) {
  x <- rle(x)
  max <- min(x$values)

  for (i in seq_along(x$values)) {
    if (x$values[i] > max) {
      max <- x$values[i]
    } else {
      x$values[i] <- max
    }
  }

  with(x, rep(values, lengths))
}

vis_rows <- t(apply(data, 1L, is_visible))
vis_cols <- apply(data, 2L, is_visible)

solution1 <- sum(vis_rows | vis_cols)

stopifnot(
  all(vis_rows[, 1]),
  all(vis_rows[, ncol(data)]),
  all(vis_cols[1, ]),
  all(vis_cols[nrow(data), ]),
  solution1 != 5095,
  solution1 != 3434
)

# data <- matrix(c(3,0,3,7,3,2,5,5,1,2,6,5,3,3,2,3,3,5,4,9,3,5,3,9,0), ncol = 5, byrow = TRUE)

scenic_score <- function(x) {
  do_scenic_score(x) * rev(do_scenic_score(rev(x)))
}

do_scenic_score <- function(x) {
  vapply(
    seq_along(x),
    function(i) {
      if (i == 1L) {
        return(1L)
      }

      runs <- rle(x[i] > rev(x[seq_len(i - 1L)]))

      if (runs$values[1L]) {
        runs$lengths[1L] + if (length(runs$values) == 1L) 0L else 1L
      } else {
        1L
      }
    },
    NA_integer_
  )
}

scores <- t(apply(data, 1L, scenic_score)) * apply(data, 2L, scenic_score)
solution2 <- max(scores)

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/08")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
