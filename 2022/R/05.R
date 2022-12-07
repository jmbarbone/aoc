#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

x <- readLines("2022/data/05")

# get the starting list.  we end up with a named list of vectors, where the
# first position is the item on "top" (which will be helpful)
ls <- x[1:8]
ls <- paste0(format(ls), " ")
ls <- lapply(strsplit(ls, ""), function(x) {
  x <- split(x, (seq_along(x) - 1L) %/% 4L)
  sapply(x, paste0, collapse = "")
})

ls <- Reduce(rbind, ls)
ls <- t(ls)
ls <- apply(ls, 1L, \(i) as.character(trimws(i)))
ls <- as.list(as.data.frame(ls))
ls <- lapply(ls, function(i) {
  i <- i[i != ""]
  regmatches(i, regexpr("[A-Z]", i))
})

# get the steps.  the only things that matter here are the numbers, so we just
# need to know the 3 numbers so we know how to move how much from where to where
# ie, move {n} from {here} to {there}
steps <- x[-c(1:10)]
regmatches(steps, gregexpr("([^0-9])", steps)) <- " "
steps <- trimws(steps)
steps <- strsplit(steps, "\\s+")
steps <- lapply(steps, as.integer)
steps <- lapply(steps, setNames, c("n", "here", "there"))
steps <- lapply(steps, as.list)

# copy lists for two separate solutions
ls2 <- ls1 <- ls

for (i in steps) {
  n <- rev(seq_len(i$n)) # reverse order for placement
  ls1[[i$there]] <- c(ls1[[i$here]][n], ls1[[i$there]])
  ls1[[i$here]] <- ls1[[i$here]][-n]
}

solution1 <- paste0(vapply(ls1, head, NA_character_, 1), collapse = "")

for (i in steps) {
  n <- seq_len(i$n) # don't reverse order (which is what I did by accident...)
  ls2[[i$there]] <- c(ls2[[i$here]][n], ls2[[i$there]])
  ls2[[i$here]] <- ls2[[i$here]][-n]
}

solution2 <- paste0(vapply(ls2, head, NA_character_, 1), collapse = "")

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/05")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
