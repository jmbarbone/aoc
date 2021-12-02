input <- readLines("data/day-05.txt")

splits <- strsplit(input, "")

seats <- lapply(
  splits,
  function(x) {
    rows <- 0:127
    cols <- 0:7

    for (i in x[1:7]) {
      m <- length(rows)
      m2 <- m / 2
      rows <- switch(
        i,
        `F` = rows[1:m2],
        `B` = rows[(m2 + 1):m],
      )
    }

    stopifnot(length(rows) == 1)

    for (j in x[8:10]) {
      n <- length(cols)
      n2 <- n / 2
      cols <- switch(
        j,
        `L` = cols[1:n2],
        `R` = cols[(n2 + 1):n],
      )
    }

    stopifnot(length(cols) == 1)

    c(row = rows, col = cols)
  })

ids <- sapply(seats, function(x) {
  x["row"] * 8 + x["col"]
})

max(ids) # 951


# Part 2 ------------------------------------------------------------------

all_rows <- sapply(seats, `[`, "row")
all_cols <- sapply(seats, `[`, "col")
row_ranges <- range(all_rows)
col_ranges <- range(all_cols)
row_seq <- row_ranges[1]:row_ranges[2]
col_seq <- col_ranges[1]:col_ranges[2]

ok <- sapply(
  seats,
  function(x) {
    !(x["row"] %in% row_seq | x["col"] %in% col_seq)
  }
)

all_seats <- Reduce(rbind, seats)
expanded_seats <- expand.grid(row = row_seq, col = col_seq)
expanded_seats$id <- expanded_seats[["row"]] * 8 + expanded_seats[["col"]]
subset(expanded_seats, !id %in% ids & row != 0 & col != 0, id, drop = TRUE) # 653
