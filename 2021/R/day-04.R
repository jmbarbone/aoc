x <- readLines("data/day-04.txt")

make_board <- function(x) {
  t(vapply(strsplit(trimws(x), "\\s+"), as.integer, integer(5)))
}

get_boards <- function(x) {
  blank <- x == ""
  board_id <- cumsum(blank)
  boards <- split(x[!blank], board_id[!blank])
  lapply(boards, make_board)
}

any_bingo <- function(mat) {
  any(apply(mat, 1, all) | apply(mat, 2, all))
}

calls <- as.integer(strsplit(x[1], ",")[[1]])
boards <- get_boards(x[-c(1:2)])
game_boards <- rep(list(matrix(logical(25), ncol = 5)), length(boards))

day_04a <- function(calls, boards, game_boards) {
  bingo <- FALSE
  i <- 0L
  
  while (!bingo) {
    i <- i + 1L
    # object[integer()] <- TRUE should be safe
    inds <- sapply(boards, \(j) which(j == calls[i]))
    
    for (s in seq_along(inds)) {
      game_boards[[s]][inds[[s]]] <- TRUE
    }
    
    if (i > 5) {
      bingo_search <- vapply(game_boards, any_bingo, NA)
      bingo <- any(bingo_search)
    }
    
    if (i > length(calls)) {
      stop("something went wrong")
    }
  }
  
  id <- which(bingo_search)
  sum(boards[[id]][!game_boards[[id]]]) * calls[i]
}

stopifnot(
  identical(day_04a(calls, boards, game_boards), 55770L)
)

