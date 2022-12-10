#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- read.table("2022/data/09", col.names = c("direction", "steps"))

knot <- setRefClass(
  "adventKnot",
  fields = list(
    x      = "integer",
    y      = "integer",
    record = "matrix",
    dn     = "list",
    diff   = "integer"
  ),
  methods = list(
    initialize = function() {
      .self$x <- 0L
      .self$y <- 0L
      .self$dn <- list(x = 0L, y = 0L)
      .self$record <- matrix(1L, dimnames = .self$dn)
      invisible(.self)
    },
    chase = function(env) {
      .self$find_diff(env)

      if (.self$diff[1L] == 2L) {
        .self$chase_x(env$x)
        if (diff[2L] == 1L) {
          .self$move_y(env$y)
        }
      }

      if (.self$diff[2L] == 2L) {
        .self$chase_y(env$y)
        if (diff[1L] == 1L) {
          .self$move_x(env$x)
        }
      }

      .self$record_pos()
      invisible(.self)
    },
    find_diff = function(env) {
      .self$diff <- abs(c(.self$x, .self$y) - c(env$x, env$y))
      invisible(.self)
    },
    chase_x = function(i) {
      .self$x <- (.self$x + i) %/% 2L
      invisible(.self)
    },
    chase_y = function(i) {
      .self$y <- (.self$y + i) %/% 2L
      invisible(.self)
    },
    move_x = function(i) {
      .self$x <- i
      invisible(.self)
    },
    move_y = function(i) {
      .self$y <- i
      invisible(.self)
    },
    record_pos = function() {
      xc <- as.character(.self$x)
      yc <- as.character(.self$y)

      if (!xc %in% .self$dn$x) {
        .self$dn$x <- c(.self$dn$x, xc)
        .self$record <- rbind(.self$record, 0L)
      }

      if (!yc %in% .self$dn$y) {
        .self$dn$y <- c(.self$dn$y, yc)
        .self$record <- cbind(.self$record, 0L)
      }

      dimnames(.self$record) <- .self$dn
      .self$record[xc, yc] <- .self$record[xc, yc] + 1L
      invisible(.self)
    }
  )
)

chase <- function(n = 1) {
  head <- list2env(list(x = 0L, y = 0L))
  tails <- replicate(n, knot())

  for (i in seq_len(nrow(data))) {
    with(data[i, ], chase_head(head, tails, direction, steps))
  }

  sum(tails[[n]]$record > 0)
}

chase_head <- function(head, tails, direction, steps) {
  for (i in seq_len(steps)) {
    do_chase_head(head, tails, direction)
  }
}

do_chase_head <- function(head, tails, direction) {
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

  ls <- c(list(head), tails)
  for (i in seq_along(ls)[-1L]) {
    ls[[i]]$chase(ls[[i - 1L]])
  }
}

solution1 <- chase(1)
solution2 <- chase(9)

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/09")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
