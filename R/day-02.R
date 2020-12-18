input <- read.table("data/day-02.txt", col.names = c("range", "letter", "password"))

# Part 1
sum(
  mapply(
    function(x, let, r) {
      x <- strsplit(x, "")[[1]]
      s <- sum(let == x)
      s >= r[1] & s <= r[2]
    },
    x = input[["password"]],
    let = sub(":", "", input[["letter"]]),
    r = lapply(strsplit(input[["range"]], "-"), as.integer),
    USE.NAMES = FALSE
  )
)

sum(
  mapply(
    function(x, let, r) {
      x <- strsplit(x, "")[[1]]
      xor(let == x[r[1]], let == x[r[2]])
    },
    x = input[["password"]],
    let = sub(":", "", input[["letter"]]),
    r = lapply(strsplit(input[["range"]], "-"), as.integer),
    USE.NAMES = FALSE
  )
)
