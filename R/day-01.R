# https://adventofcode.com/2020/day/1

input <- as.integer(readLines("data/day-01.txt"))

# Part 1
bench::mark(
  `1` = {
    combs <- combn(
      input,
      m = 2,
      function(x) {
        if (sum(x) == 2020) {
          prod(x)
        } else {
          NA_real_
        }
      }
    )

    combs[!is.na(combs)]
  },

  `2` = {
    combs <- unique(combn(input, 2))
    prod(combs[, apply(combs, 2, sum) == 2020])
  },
  # https://www.r-bloggers.com/2020/12/advent-of-code-2020/
  `3` = prod(input[(2020 - input) %in% input])
)[1:9]

# Part 2
bench::mark(
  `1` = {
    combs <- combn(
      input,
      m = 3,
      function(x) {
        if (sum(x) == 2020) {
          prod(x)
        } else {
          NA_real_
        }
      }
    )

    combs[!is.na(combs)]
  },

  `2` = {
    combs <- unique(combn(input, 3))
    prod(combs[, apply(combs, 2, sum) == 2020])
  },

  # https://www.r-bloggers.com/2020/12/advent-of-code-2020/
  `3` = {
    prod(combn(input, 3)[, combn(input, 3, sum) == 2020])
  }
)[1:9]
