#! /usr/bin/env python3

import numpy as np


def main() :
    with open("2022/data/01") as f:
        data = f.read().rstrip().splitlines()

    # there are no 0s in the data
    data = ["0" if i == "" else i for i in data]
    data = np.asarray(data, dtype=int)

    id = np.cumsum(data == 0)
    grouped = [data[np.where(id == i)] for i in np.unique(id)]
    sums = [sum(i) for i in grouped]

    solution1 = max(sums)

    sums.sort()

    solution2 = sum(sums[-3:])
    return [solution1, solution2]



if __name__ == "__main__" :
    results = main()
    solutions = np.loadtxt("2022/solutions/01")

    if any(results != solutions):
        raise ValueError("Solutions are incorrect")


