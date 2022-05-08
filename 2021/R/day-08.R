x <- strsplit(readLines("data/day-08.txt"), " ")
entries <- lapply(x, \(i) i[seq.int(1, match("|", i) - 1)])
outputs <- lapply(x, \(i) i[seq.int(match("|", i) + 1, length(i))])

day_08a <- function() {
  # Count 1, 4, 7, and 8.
  # Count the number of segments
  
  #   0:      1:      2:      3:      4:
  #  aaaa    ....    aaaa    aaaa    ....
  # b    c  .    c  .    c  .    c  b    c
  # b    c  .    c  .    c  .    c  b    c
  #  ....    ....    dddd    dddd    dddd
  # e    f  .    f  e    .  .    f  .    f
  # e    f  .    f  e    .  .    f  .    f
  #  gggg    ....    gggg    gggg    ....
  # 
  #   5:      6:      7:      8:      9:
  #  aaaa    aaaa    aaaa    aaaa    aaaa
  # b    .  b    .  .    c  b    c  b    c
  # b    .  b    .  .    c  b    c  b    c
  #  dddd    dddd    ....    dddd    dddd
  # .    f  e    f  .    f  e    f  .    f
  # .    f  e    f  .    f  e    f  .    f
  #  gggg    gggg    ....    gggg    gggg
  sum(nchar(unlist(outputs)) %in% c(2, 4, 3, 7))
}

day_08b <- function() {
  # New configuration
  #  dddd
  # e    a
  # e    a
  #  ffff
  # g    b
  # g    b
  #  cccc
  
  old <- c("a", "b", "c", "d", "e", "f", "g")
  
  old_numbers <- c(
    `0` = "abcefg",
    `1` = "cf",
    `2` = "acdeg",
    `3` = "acdfg",
    `4` = "bcdf",
    `5` = "abdfg",
    `6` = "abdefg",
    `7` = "acf",
    `8` = "abcdefg",
    `9` = "abcdfg"
  )
  
  rearrange_letters <- function(x, by) {
    x <- strsplit(x, "")
    sapply(x, \(i) paste(sort(old[match(i, by)]), collapse = ""))
  }
  
  orders <- lapply(entries, f_determine_arrangement)
  
  res <- vapply(
    Map(rearrange_letters, outputs, orders),
    \(i) as.integer(paste(match(i, old_numbers) - 1L, collapse = "")),
    NA_integer_
  )
  sum(res)
}

f_determine_arrangement <- function(x) {
  one   <- which(nchar(x) == 2)
  four  <- which(nchar(x) == 4)
  seven <- which(nchar(x) == 3)
  
  splits <- strsplit(x, "")
  a <- setdiff(splits[[seven]], splits[[one]])
  c_f <- intersect(splits[[seven]], splits[[one]])
  b_d <- setdiff(splits[[four]], c(a, c_f))
  
  # 4 is inside 9 (remove a)
  g_e <- lapply(splits, setdiff, c(splits[[four]], a))
  g <- g_e[lengths(g_e) == 1][[1]]
  e <- setdiff(unlist(g_e), g)
  
  two_three_five <- lengths(splits) == 5
  d <- setdiff(Reduce(intersect, splits[two_three_five]), c(a, g))
  b <- setdiff(b_d, d)
  
  zero_six_nine <- lengths(splits) == 6
  f <- setdiff(Reduce(intersect, splits[zero_six_nine]), c(a, b, d, g, e))
  c_ <- setdiff(c_f, f)
  
  c(a, b, c_, d, e, f, g)
}

stopifnot(
  day_08a() == 470,
  day_08b() == 989396
)
