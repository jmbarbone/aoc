#!/usr/bin/env -S Rscript --vanilla

# solve -------------------------------------------------------------------

data <- readLines("2022/data/07")
is_command <- grepl("^\\$\\s", data)
steps <- split(data, cumsum(is_command))
commands <- data[which(is_command)]
commands <- gsub("(?<=^\\$\\s[a-z]{2}).*$", "", commands, perl = TRUE)
commands <- substr(commands, 3L, 4L)
steps <- Map(
  function(step, command) {
    step[1] <- substr(step[1], 6L, nchar(step[1]))
    step <- step[step != ""]
    attr(step, "command") <- command
    step
  },
  step = steps,
  command = commands
)

find_directory_sizes <- function() {
  wd <- getwd()
  on.exit(setwd(wd), add = TRUE)

  root <- tempfile("foot")
  on.exit(try(unlink(root, recursive = TRUE)), add = TRUE)

  dir.create(root, showWarnings = FALSE)
  setwd(root)

  for (step in steps) {
    switch(
      attr(step, "command"),
      cd = {
        if (isTRUE(step == "/")) {
          setwd(root)
        } else {
          setwd(step)
        }
      },
      ls = {
        dirs <- grep("^dir\\s", step)
        files <- grep("^[0-9]+\\s", step)

        for (dir in step[dirs]) {
          dir.create(sub("^dir\\s", "", dir), showWarnings = FALSE)
        }

        for (file in step[files]) {
          writeLines(sub("\\s.*$", "", file), sub("^[0-9]+\\s", "", file))
        }
      },
    )
  }

  setwd(root)
  dirs <- list.dirs()
  names(dirs) <- dirs
  sapply(dirs, function(i) {
    files <- list.files(i, recursive = TRUE, full.names = TRUE)
    sum(as.integer(sapply(files, readLines)))
  })
}

sizes <- find_directory_sizes()
solution1 <- sum(sizes[sizes <= 100000])
solution2 <- min(sizes[sizes > (max(sizes) - (70000000 - 30000000))])

# test --------------------------------------------------------------------

solution <- readLines("2022/solutions/07")

stopifnot(
  solution1 == solution[1],
  solution2 == solution[2]
)
