#! /usr/bin/env python3

import pandas as pd
import numpy as np


def main() :

    df = pd.read_table("2022/data/02", header=None, sep=" ", names=["opponent", "me"])

    counts = df.\
        value_counts().\
        sort_index().\
        to_frame().\
        pivot_table(
            index="me",
            columns="opponent",
            values=0,
            fill_value=0
        )

    counts = np.asarray(counts)
    result = np.array([[3, 0, 6], [6, 3, 0], [0, 6, 3]], dtype=int)
    play = np.array([[1, 1, 1], [2, 2, 2], [3, 3, 3]], dtype=int)

    solution1 = np.sum(counts * [result + play])

    result2 = np.array([[0, 0, 0], [3, 3, 3], [6, 6, 6]], dtype=int)
    play2 = np.array([[3, 1, 2], [1, 2, 3], [2, 3, 1]], dtype=int)

    solution2 = np.sum(counts * (result2 + play2))

    return [solution1, solution2]


if __name__ == "__main__" :
    results = main()
    solutions = np.loadtxt("2022/solutions/02")

    if any(results != solutions):
        raise ValueError("solutions are incorrect")
