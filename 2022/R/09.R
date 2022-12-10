#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- read.table("2022/data/09", col.names = c("direction", "steps"))
head(data)

chase <- function(direction, steps) {
  for (i in seq_len(steps)) {
    do_chase(direction)
  }
}

record_pos <- function() {
 x <- as.character(tail$x)
 y <- as.character(tail$y)
 dn <- dimnames(tail$record)

 if (!x %in% dn$x) {
   tail$record <- rbind(tail$record, x = 0L)
 }

 if (!y %in% dn$y) {
   tail$record <- cbind(tail$record, y = 0L)
 }

 dimnames(tail$record) <- list(x = unique(c(dn$x, x)), y = unique(c(dn$y, y)))
 tail$record[x, y] <- tail$record[x, y] + 1L
 invisible(tail$record)
}

do_chase <- function(direction) {
  switch(
    direction,
    U = {
      head$x <- head$x + 1L
    },
    D = {
      head$x <- head$x - 1L
    },
    R = {
      head$y <- head$y + 1L
    },
    L = {
      head$y <- head$y - 1L
    }
  )

  diff <- with(tail, c(x, y)) - with(head, c(x, y))
  diff <- abs(diff)

  if (diff[1L] == 2L) {
    tail$x <- (tail$x + head$x) %/% 2
    if (diff[2L] == 1L) {
      tail$y <- head$y
    }
  }

  if (diff[2L] == 2L) {
    tail$y <- (tail$y + head$y) %/% 2
    if (diff[1L] == 1L) {
      tail$x <- head$x
    }
  }

  record_pos()
}

pos <- list(x = 0L, y = 0L)
head <- list2env(pos)
tail <- list2env(pos)
tail$record <- matrix(0L, dimnames = list(x = 0, y = 0))

for (i in seq_len(nrow(data))) {
  with(data[i, ], chase(direction, steps))
}

stopifnot(sum(data$steps) == sum(tail$record))

solution1 <- sum(tail$record > 0L)

solution2 <- NULL

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/09")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
