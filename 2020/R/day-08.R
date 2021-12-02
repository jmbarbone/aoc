input <- readLines("data/day-08.txt")

commands0 <- strsplit(input, "\\s")
commands <- sapply(
  commands0,
  function(x) {
    nm <- x[1]
    val <- as.integer(x[2])
    names(val) <- nm
    val
  }
)

# Create global variables (could probably be done with R6)
reset_tracking <- function() {
  tracking <- new.env()
  assign("accumulator", 0L, envir = tracking)
  assign("position_tracker", 1L, envir = tracking)
  assign("error", FALSE, envir = tracking)
  assign("success", FALSE, envir = tracking)
  assign("tracking", tracking, envir = globalenv())
}

reset_tracking()

# Function to control what to do
do_command <- function(x) {
  stopifnot(length(x) == 1L)

  switch(
    names(x),
    acc = {
      # Add the position (also checks) before adding to the accumulator
      add_position_tracker()
      add_accumulator(x)
    },
    nop = add_position_tracker(),
    jmp = add_position_tracker(x[[1]])
  )
}

add_accumulator <- function(x = 0L) {
  new <- get("accumulator", envir = tracking) + x
  assign("accumulator", new, envir = tracking)
  invisible(new)
}

add_position_tracker <- function(x = 1L) {
  pt <- c(
    get("position_tracker", envir = tracking),
    get_current_position() + x
  )
  assign("position_tracker", pt, envir = tracking)
  check_positions()
}

get_current_position <- function() {
  x <- get("position_tracker", envir = tracking)
  x[[length(x)]]
}

check_positions <- function() {
  x <- get("position_tracker", envir = tracking)
  pos <- tapply(x, x, length)
  bad <- pos[pos > 1]
  assign("error", TRUE, envir = tracking)

  if (length(bad)) {
    stop("Failure after ", length(x), " commands:\n",
         "  Position is repeated: ", names(bad), "\n",
         "  accumulator value is: ", add_accumulator())
  }

  pos
}

# Guaranteed error so this isn't bad
repeat {
  do_command(commands[get_current_position()])
}

stopifnot(tracking$accumulator == 1939)

# Part 2 ------------------------------------------------------------------

try_program <- function(cmd) {
  reset_tracking()

  n <- length(cmd)
  cp <- 1L

  while (cp < n) {
    do_command(cmd[cp])
    cp <- get_current_position()
  }

  assign("success", TRUE, envir = tracking)
  a <- get("accumulator", envir = tracking)
  message("Program is successful! Accumulator value: ", a)
  invisible(a)
}

# Get a vector of indices for each value to possible change
possible <- which(names(commands) %in% c("nop", "jmp"))
i <- 0
reset_tracking()

# Continue until we found a success or `i` has reached the last possible try
# while (!tracking$success && i != length(possible)) {
repeat {
  i <- i + 1
  pos <- possible[i]

  if (is.na(pos)) {
    stop("What?")
  }

  # create a new vector of commands
  commands1 <- commands
  # switch the command
  names(commands1)[pos] <- switch(
    names(commands)[pos],
    jmp = "nop",
    nop = "jmp"
  )

  # Do not stop on failures
  # If error, return FALSE
  res <- tryCatch(try_program(commands1), error = function(e) FALSE)
  # if result is not FALSE, then it is a success
  if (!isFALSE(res)) {
    message("Success when chaning line ", pos)
    message("  ", names(commands)[pos], " ", commands[pos])
    break
  }
}

stopifnot(tracking$accumulator == 2212)
