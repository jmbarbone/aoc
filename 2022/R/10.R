#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

## functions ----

collapse <- function(...) {
  paste0(..., collapse = "")
}

read_block_letters <- function() {
  blocks <- readLines("2022/solutions/10-letters")
  blocks <- split(blocks, cumsum(blocks == ""))
  names(blocks) <- c(LETTERS, " ")
  blocks <- lapply(blocks, function(line) unlist(strsplit(line, "")))
  sapply(blocks, function(b) collapse(gsub("[A-Z]+", "#", b)))
}

split_screen <- function(x) {
  x <- draw(x)
  cols <- seq_len(ncol(x))
  group <- (cols - 1) %/% 5
  mats <- lapply(split(cols, group), function(cg) x[, cg])
  sapply(mats, function(m) collapse(as.character(apply(m, 1L, unlist))))
}

show <- function(x) {
  writeLines(apply(draw(x), 1L, paste, collapse = ""))
}

draw <- function(x) {
  matrix(x, nrow = 6L, byrow = TRUE)
}

get_results <- function(file) {
  # returns solution for part 1
  data <- readLines(file)
  commands <- regmatches(data, regexec("(?<=\\s)-?[0-9]+$", data, perl = TRUE))
  commands <- as.integer(commands)
  none <- is.na(commands)
  commands[none] <- 0L
  values <- 1 + cumsum(commands)
  cycles <- rep(2L, length(commands))
  cycles[none] <- 1L
  c(1L, 1L, rep(values, times = cycles))
}

write_screen <- function(res) {
  screen <- rep(".", 240)
  pos <- rep(0:39, 6)
  screen[abs(pos - res[1:240]) <= 1] <- "#"
  screen
}

match_letters <- function(scr) {
  # use match_letters(write_screen(get_results(file)))
  splits <- split_screen(screen)
  blocks <- read_block_letters()
  smat <- stringdist::stringdistmatrix(splits, blocks, method = "lv")
  dimnames(smat) <- list(screen = 1:8, letters = names(blocks))
  collapse(names(blocks)[apply(smat, 1L, which.min)])
}

## read data and commands ----

results <- get_results("2022/data/10")
x <- seq(20, 220, 40)
solution1 <- sum(x * results[x])

screen <- write_screen(results)
# show(screen)
solution2 <- match_letters(screen)

# test --------------------------------------------------------------------

## examples ----

results <- get_results("2022/data/10-sample")
# tests with sample data
stopifnot(
  results[20] == 21,
  results[60] == 19,
  results[100] == 18,
  results[140] == 21,
  results[180] == 16,
  results[220] == 18
)
exp <- "
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
"

exp <- Reduce(rbind, strsplit(capture.output(cat(exp))[-1], ""))
stopifnot(exp == draw(write_screen(results)))

## real solutions ----

solution <- readLines("2022/solutions/10")
stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
