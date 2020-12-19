input <- readLines("data/day-04.txt")

# split based on
# length(input[input != ""])
splits <- split(input, cumsum(input == ""))

check_entries <- function(x) {
  x <- x[x != ""]
  y <- unlist(strsplit(x, " "))
  res <- sapply(strsplit(y, ":"), function(xx) {
    setNames(trimws(xx[2]), trimws(xx[1]))
  })
  # res
  is_valid_passport(res)
}

is_valid_passport <- function(x) {
  !anyNA(match(fields, names(x)))
}

fields <- c(
  "byr",
  "iyr",
  "eyr",
  "hgt",
  "hcl",
  "ecl",
  "pid",
  # "cid", # this isn't needed
  NULL
)

sum(sapply(splits, check_entries))


# Part 2 ------------------------------------------------------------------

check_entries2 <- function(x) {
  x <- x[x != ""]
  y <- unlist(strsplit(x, " "))
  res <- sapply(strsplit(y, ":"), function(xx) {
    setNames(trimws(xx[2]), trimws(xx[1]))
  })
  # res
  is_valid_passport2(res)
}

is_valid_passport2 <- function(x) {
  if (!is_valid_passport(x)) {
    # Early exit
    return(FALSE)
  }

  byr <- suppressWarnings(as.integer(x["byr"]))
  iyr <- suppressWarnings(as.integer(x["iyr"]))
  eyr <- suppressWarnings(as.integer(x["eyr"]))

  height <- x["hgt"]
  height_n <- nchar(height)
  height_val <- substr(height, 1, height_n - 2)
  height_u <- substr(height, height_n - 1, height_n)

  all(
    byr >= 1920 & byr <= 2002,
    iyr >= 2010 & iyr <= 2020,
    eyr >= 2020 & eyr <= 2030,
    switch(height_u,
      `cm` = height_val >= 150 & height_val <= 193,
      `in` = height_val >= 59 & height_val <= 76,
      FALSE # if height_u is neither cm or in, it's invalid
    ),
    x['ecl'] %in% c('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'),
    grepl("^#[0-9a-f]{6}$", x["hcl"]),
    grepl("^[0-9]{9}$", x["pid"]),

    na.rm = TRUE
  )
}

# Instructions provide examples of (in)valid passports
stopifnot(
  # invalid
  !is_valid_passport2(
    c(eyr = '1972',  cid = '100', hcl = '#18171d', ecl = 'amb', hgt = '170',
      pid = '186cm', iyr = '2018', byr = '1926')
  ),

  !is_valid_passport2(
    c(iyr = '2019', hcl = '#602927', eyr = '1967', hgt = '170cm', ecl = 'grn',
      pid = '012533040', byr = '1946')
  ),

  !is_valid_passport2(
    c(hcl = 'dab227', iyr = '2012', ecl = 'brn', hgt = '182cm',
      pid = '021572410', eyr = '2020', byr = '1992', cid = '277')
  ),

  !is_valid_passport2(
    c(hgt = '59cm', ecl = 'zzz', eyr = '2038', hcl = '74454a',
      iyr = '2023', pid = '3556412378', byr = '2007')
  ),

  # valid
  is_valid_passport2(
    c(pid = '087499704', hgt = '74in', ecl = 'grn', iyr = '2012', eyr = '2030',
      byr = '1980', hcl = '#623a2f')
  ),

  is_valid_passport2(
    c(eyr = '2029', ecl = 'blu', cid = '129', byr = '1989', iyr = '2014',
      pid = '896056539', hcl = '#a97842', hgt = '165cm')
  ),

  is_valid_passport2(
    c(hcl = '#888785', hgt = '164cm', byr = '2001', iyr = '2015', cid = '88',
      pid = '545766238', ecl = 'hzl', eyr = '2022')
  ),

  is_valid_passport2(
    c(iyr = '2010', hgt = '158cm', hcl = '#b6652a', ecl = 'blu', byr = '1944',
      eyr = '2021', pid = '093154719')
  )
)

sum(sapply(splits, check_entries2))
