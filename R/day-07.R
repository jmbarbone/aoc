input <- readLines("data/day-07.txt")

# Parse th bags rules
parse_bag_rules <- function(x) {
  # Remove "bags"
  x <- gsub("\\sbags?", "", x)
  ss <- strsplit(x, " contain ")[[1]]
  # Remove period at end
  ss[2] <- sub("\\.$", "", ss[2])
  inner <- strsplit(ss[2], ", ")[[1]]
  if (ss[2] == "no other") {
    nums <- NA_character_
  } else {
    nums <- as.integer(sub("(^[0-9]+).*", "\\1", inner))
  }

  bags <- trimws(sub("[0-9]+", "", inner))

  list(
    outer = ss[1],
    inner = setNames(nums, bags)
  )
}

# Parse bags and create named list of `bags`
bags0 <- lapply(input, parse_bag_rules)
bag_names <- sapply(bags0, `[[`, "outer")
bags <- lapply(bags0, `[[`, "inner")
names(bags) <- bag_names

# Function to retrieve outer bags
get_outer_bags <- function(x) {
  names(bags)[sapply(bags, function(xx) any(x %in% names(xx)))]
}

# Set up loop
new <- result <- "shiny gold"

# stop when no new bags are found
while (length(new) > 0) {
  # Retrieve the new finds
  finds <- get_outer_bags(new)
  # For each find, find new ones
  new <- setdiff(finds, result)
  # append new bags
  result <- c(result, new)
  # Now, loop repeats if there are new bags
}

result1 <- length(setdiff(result, "shiny gold"))

if (result1 != 155) {
  stop(result1, " is incorrect")
}


# Part 2 ------------------------------------------------------------------

count_bags <- function(x) {
  # browser()
  if (x == "no other") {
    return(0)
  }

  b <- bags[[x]]
  n <- names(b)

  count <- 1
  for (i in seq_along(b)) {
    count <- sum(count, as.numeric(b[[i]]) * count_bags(n[i]), na.rm = TRUE)
  }

  count

}

# Removing 1 because of the "shiny gold" bag itself
result2 <- count_bags("shiny gold") - 1

if (result2 != 54803) {
  stop(result2, " is not correct")
}
