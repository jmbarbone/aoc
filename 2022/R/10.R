#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- readLines("2022/data/10")
commands <- regmatches(data, regexec("(?<=\\s)-?[0-9]+$", data, perl = TRUE))
commands <- as.integer(commands)
none <- is.na(commands)
commands[none] <- 0L
values <- 1 + cumsum(commands)
cycles <- rep(2L, length(commands))
cycles[none] <- 1L
results <- c(1L, 1L, rep(values, times = cycles))
# for sample
# stopifnot(
#   results[20] == 21,
#   results[60] == 19,
#   results[100] == 18,
#   results[140] == 21,
#   results[180] == 16,
#   results[220] == 18
# )

x <- seq(20, 220, 40)
solution1 <- sum(x * results[x])

show <- function(x) {
  writeLines(apply(draw(x), 1L, paste, collapse = ""))
}

draw <- function(x) {
  matrix(x, nrow = 6L, byrow = TRUE)
}

screen <- rep(".", 240)
pos <- rep(0:39, 6)
screen[abs(pos - results[1:240]) <= 1] <- "#"
show(screen)

exp <- "
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
"
exp <- Reduce(rbind, strsplit(capture.output(cat(exp))[-1], ""))
# stopifnot(exp == draw(screen))

blocks <- readLines("2022/solutions/10-letters")
blocks <- split(blocks, cumsum(blocks == ""))
names(blocks) <- c(LETTERS, " ")
blocks <- lapply(blocks, function(line) unlist(strsplit(line, "")))
blocks <- sapply(blocks, function(b) paste(gsub("[A-Z]+", "#", b), collapse = ""))

split_screen <- function(x) {
  x <- draw(x)
  cols <- seq_len(ncol(x))
  group <- (cols - 1) %/% 5
  mats <- lapply(split(cols, group), function(cg) x[, cg])
  sapply(mats, function(m) paste(as.character(apply(m, 1L, unlist)), collapse = ""))
}

splits <- split_screen(screen)

smat <- stringdist::stringdistmatrix(splits, blocks, method = "lv")
dimnames(smat) <- list(screen = 1:8, letters = names(blocks))
smat

show(screen)
solution2 <- paste(names(blocks)[apply(smat, 1L, which.min)], collapse = "")

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/10")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
