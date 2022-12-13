#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

# read in as matrix
map <- do.call(rbind, strsplit(readLines("2022/data/12"), ""))
values <- match(map, c("S", letters, "E"))
start <- match("S", map)
end <- match("E", map)

pos <- seq_along(map)
names(pos) <- pos

network <- lapply(pos, \(i) {
  m <- i + c(right = 41, left = -41, up = -1, down = 1)
  m[m < 1 | m > 4141] <- NA
  diff <- values[m] - values[i]
  m[which(diff <= 1)]
})

# df <- cbind(
#   from = rep(names(network), lengths(network)),
#   to = do.call(rbind, lapply(network, matrix))
# )
# mode(df) <- "integer"
# df <- as.data.frame(df)
# df <- df[complete.cases(df), ]
# names(df) <- c("from", "to")
# row.names(df) <- NULL

ig <- igraph::graph_from_adj_list(network)
(spaths <- igraph::shortest_paths(ig, start, end, algorithm = "dijkstra"))

blank_map <- map
blank_map[] <- " "
ok <- as.integer(spaths$vpath[[1]])
blank_map[ok] <- map[ok]
writeLines(apply(blank_map, 1L, paste0, collapse = ""))

solution1 <- length(spaths$vpath[[1]]) - 1L

stopifnot(
  solution1 != 359,
  solution1 != 78,
  solution1 != 354,
  solution1 != 45,
  solution1 != 35,
  solution1 != 362,
  TRUE
)

solution2 <- NULL

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/12")
stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
