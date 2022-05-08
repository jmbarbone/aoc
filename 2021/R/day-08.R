x <- strsplit(readLines("data/day-08.txt"), " ")

day_08a <- function(x) {
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
  #  
  outputs <- unlist(lapply(x, \(i) i[seq.int(match("|", i) + 1, length(i))]))
  sum(nchar(outputs) %in% c(2, 4, 3, 7))
}

stopifnot(
  day_08a(x) == 470
)
