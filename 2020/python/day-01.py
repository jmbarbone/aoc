import pandas as pd

input = pd.read_table("data/day-01.txt", header=None, names=["x"])

# Part 1

input["y"] = [2020 - x for x in input.x]

# Similar method as in R
input[input.y.isin(input.x)].x.prod()


# Part 2

from itertools import combinations

combs = combinations(input.x, 3)

[x for x in combs if sum(x) == 2020]
