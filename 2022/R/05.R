
# solve -------------------------------------------------------------------

x <- readLines("2022/data/05")
start <- x[1:8]
start <- paste0(format(start), " ")
start <- lapply(strsplit(start, ""), function(x) {
  sapply(split(x, (seq_along(x) - 1 ) %/% 4), paste0, collapse = "")
})

ls <- as.list(as.data.frame(apply(t(Reduce(rbind, start)), 1, \(i) as.character(trimws(i)))))
ls <- lapply(ls, function(i) {
  i <- i[i != ""]
  regmatches(i, regexpr("[A-Z]", i))
})

steps <- x[-c(1:10)]
regmatches(steps, gregexpr("([^0-9])", steps)) <- " "
steps <- trimws(steps)
steps <- strsplit(steps, "\\s+")
steps <- lapply(steps, as.integer)
steps <- lapply(steps, setNames, c("n", "here", "there"))
steps <- lapply(steps, as.list)

# move {this many} from {here} to {there}
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
