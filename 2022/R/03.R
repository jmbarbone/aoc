x <- readLines("2022/data/03")
solutions <- readLines("2022/solutions/03")
match(a, c(letters, LETTERS))
sapply(x, function(i) {
  n <- nchar(i)
  h <- n %% 2
  a <- strsplit(x[1:h], "")[[2]]
  b <- x[(h + 1):n]
})

splits <- strsplit(x, "")
splits <- lapply(splits, match, c(letters, LETTERS))
ns <- lengths(splits)
half <- ns %/% 2

left <- mapply(function(i, a, b) i[a:b], i = splits, a = 1, b = half)
right <- mapply(function(i, a, b) i[a:b], i = splits, a = half + 1, b = ns)

res1 <- sum(mapply(intersect, left, right))

stopifnot(res1 == solutions[[1]])

groups <- (seq_along(ns) - 1) %/% 3
gsplit <- split(splits, groups)
res2 <- sum(vapply(gsplit, function(i) Reduce(intersect, i), NA_integer_))
