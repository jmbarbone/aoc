
x <- readLines("data/day-02.txt")
x <- strsplit(x, "\\s")
s <- seq_along(x)
steps <- vapply(s, \(i) as.integer(x[[i]][2]), NA_integer_)
names(steps) <- vapply(s, \(i) x[[i]][1], NA_character_)
sums <- tapply(steps, names(steps), sum)
res <- (sums[["down"]] - sums[["up"]]) * sums[["forward"]]

stopifnot(identical(res, 1459206L))

aim <- 0L
horizontal <- 0L
depth <- 0L

for (i in s) {
  switch(
    names(steps[i]),
    down = {
      aim <- aim + steps[[i]]
    },
    up = {
      aim <- aim - steps[[i]]
    },
    forward = {
      horizontal <- horizontal + steps[[i]]
      depth <- depth + aim * steps[[i]]
    }
  )
}

res <- horizontal * depth
stopifnot(identical(res, 1320534480L))
