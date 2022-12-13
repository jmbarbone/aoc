#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

# read in as matrix
map <- do.call(rbind, strsplit(readLines("2022/data/12"), ""))

# for a prettier print of a solution
show_solution <- function(x) {
  draw <- map
  draw[] <- " "
  draw[x] <- map[x]
  writeLines(apply(draw, 1L, paste0, collapse = ""))
}

# code as values indicating height
values <- match(map, c("S", letters, "E"))
# store start and end positions
start <- match("S", map)
end <- match("E", map)

# Prepare network list.  For each square, what are the valid cardinal moves?  We
# can use the position and add/subtract to find other valid positions and the
# land height at that location.
n_rows <- nrow(map)
n_cells <- length(map)
pos <- seq_along(map)
names(pos) <- pos
network <- lapply(pos, function(i) {
  m <- i + c(r = n_rows, l = -n_rows, u = -1, d = 1)
  m[m < 1 | m > n_cells] <- NA_integer_
  m[which(values[m] - values[i] <= 1)]
})

# {igraph} implements the searching algorithm
ig <- igraph::graph_from_adj_list(network)
paths1 <- igraph::shortest_paths(ig, start, end)
if (interactive()) show_solution(paths1$vpath[[1]])
# take 1 off because we don't count the last step onto E.  Or is it the first
# step on S?  Either way, subtract 1.
solution1 <- length(paths1$vpath[[1]]) - 1L

paths2 <- lapply(
  which(map == "a"),
  # some of these these not work
  \(m) suppressWarnings(igraph::shortest_paths(ig, m, end)$vpath[[1]])
)

# remove the paths that don't have solutions, and select the smallest one
paths2 <- paths2[lengths(paths2) > 0]
w <- which.min(lengths(paths2))
if (interactive()) show_solution(paths2[[w]])
solution2 <- length(paths2[[w]]) - 1L

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/12")
stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
