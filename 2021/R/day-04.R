

# data --------------------------------------------------------------------

x <- readLines("data/day-04.txt")

calls <- as.integer(strsplit(x[1], ",")[[1]])
boards <- get_boards(x[-c(1:2)])
game_boards <- rep(list(matrix(logical(25), ncol = 5)), length(boards))


# solutions ---------------------------------------------------------------

day_04a <- function(calls, boards, game_boards) {
  play_bingo(calls = calls, boards = boards, game_boards = game_boards, method = "first")
}

day_04b <- function(calls, boards, game_boards) {
  play_bingo(calls = calls, boards = boards, game_boards = game_boards, method = "last")
}


# helpers -----------------------------------------------------------------

play_bingo <- function(calls, boards, game_boards, method = c("first", "last")) {
  method <- match.arg(method)
  method_fun <- switch(method, first = "any", last = "all")
  method_fun <- match.fun(method_fun)
  
  bingo <- FALSE
  i <- 0L
  winners <- integer()
  
  while (!bingo) {
    i <- i + 1L
    # object[integer()] <- TRUE should be safe
    inds <- sapply(boards, \(j) which(j == calls[i]))
    
    for (s in seq_along(inds)) {
      game_boards[[s]][inds[[s]]] <- TRUE
    }
    
    if (i > 5) {
      bingo_search <- vapply(game_boards, any_bingo, NA)
      # track the winners
      winners <- unique(c(winners, which(bingo_search)))
      bingo <- method_fun(bingo_search)
    }
    
    if (i > length(calls)) {
      stop("something went wrong")
    }
  }
  
  n_winners <- length(winners)
  
  if (method == "first" && n_winners > 1) {
    stop("whoops, can't have multiple winners")
  } 
  
  id <- winners[n_winners]
  sum(boards[[id]][!game_boards[[id]]]) * calls[i]
}

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


# checks ------------------------------------------------------------------

stopifnot(
  identical(day_04a(calls, boards, game_boards), 55770L),
  identical(day_04b(calls, boards, game_boards), 2980L)
)

