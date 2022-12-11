#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

env <- new.env()

read_monkeys <- function(path, env = new.env()) {
  data <- readLines(path)
  data <- split(data, cumsum(grepl("^Monkey\\s[0-9]", data)) - 1L)
  lapply(data, function(x) {
    list2env(list(
      start     = parse_start(x[2L]),
      operation = parse_operation(x[3L]),
      test      = parse_test(x[4L]),
      true      = parse_true(x[5L]),
      false     = parse_false(x[6L]),
      counter   = 0L
    ))
  })
}

parse_start <- function(x) {
  as.integer(strsplit(substr(x, 19L, nchar(x)), ",\\s")[[1L]])
}

parse_operation <- function(x) {
  body <- parse(text = substr(x, 20L, nchar(x)))
  fun <- function(old) { }
  body(fun) <- body
  environment(fun) <- env
  fun
}

parse_test <- function(x) {
  n <- as.integer(substr(x, 22L, nchar(x)))
  fun <- function(i) { }
  environment(fun) <- env
  body(fun) <- substitute(i %% n == 0L)
  fun
}

parse_true <- function(x) {
  as.integer(substr(x, 30L, nchar(x)))
}

parse_false <- function(x) {
  as.integer(substr(x, 31L, nchar(x)))
}

get_starts <- function(obj) {
  lapply(obj, function(o) o$start)
}

get_product_2 <- function(obj) {
  as.integer(prod(sort(sapply(obj, \(i) i$counter), decreasing = TRUE)[1:2]))
}

play_keep_away <- function(monkeys, rounds = 1L) {
  for (round in seq_len(rounds)) {
    # message("round ", round)
    m <- 0L
    for (monkey in monkeys) {
      # message("monkey", m)
      i <- 0L
      for (item in monkey$start) {
        # if (round == 16 && m == 6 && i == 1) browser()
        # message("item ", i)
        monkey$counter <- monkey$counter + 1L

        item <- monkey$operation(item)
        monkey$start <- monkey$start[-1L]
        item <- item %/% 3L

        if (monkey$test(item)) {
          to <- monkey$true
        } else {
          to <- monkey$false
        }

        to <- to + 1L
        monkeys[[to]]$start <- c(monkeys[[to]]$start, item)
        i <- i + 1L
      }
      m <- m + 1L
    }
  }
}

monkeys <- read_monkeys("2022/data/11")
# debugonce(play_keep_away)
play_keep_away(monkeys, rounds = 20)
solution1 <- get_product_2(monkeys)
solution2 <- NULL

# test --------------------------------------------------------------------

## examples ----

monkeys <- read_monkeys("2022/data/11-sample")
play_keep_away(monkeys)

obj_01 <- get_starts(monkeys)
exp_01 <- list(
  `0` = c(20L, 23L, 27L, 26L),
  `1` = c(2080L, 25L, 167L, 207L, 401L, 1046L),
  `2` = integer(),
  `3` = integer()
)

# another round
play_keep_away(monkeys)
obj_02 <- get_starts(monkeys)
exp_02 <- list(
  `0` = c(695L, 10L, 71L, 135L, 350L),
  `1` = c(43L, 49L, 58L, 55L, 362L),
  `2` = integer(),
  `3` = integer()
)

play_keep_away(monkeys)
obj_03 <- get_starts(monkeys)
exp_03 <- list(
  `0` = c(16L, 18L, 21L, 20L, 122L),
  `1` = c(1468L, 22L, 150L, 286L, 739L),
  `2` = integer(),
  `3` = integer()
)

# play 17 more times
play_keep_away(monkeys, 17)
obj <- get_product_2(monkeys)
exp <- 10605L

stopifnot(
  all.equal(obj_01, exp_01),
  all.equal(obj_02, exp_02),
  all.equal(obj_03, exp_03),
  all.equal(obj, exp)
)

## real ----

solution <- readLines("2022/solutions/11")
stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
