#! /usr/bin/env python3

import numpy as np
import pandas as pd


def main() :
    df = pd.read_table("2022/data/04", dtype=str, sep=",", header=None, names=["x", "y"])
    df = df.apply(lambda x: [str_to_set(i) for i in x], axis=0)    
    solution1 = df.apply(lambda x: fully_contained(x[0], x[1]), axis=1).sum()
    solution2 = df.apply(lambda x: any_overlap(x[0], x[1]), axis=1).sum()
    return [solution1, solution2]


def str_to_set(x) :
    nums = [int(i) for i in x.split("-")]
    return set(range(nums[0], nums[1] + 1))


def fully_contained(a, b) :
    return a.intersection(b) == a or b.intersection(a) == b


def any_overlap(a, b) :
    return len(a.intersection(b)) > 0


if __name__ == "__main__" :
    results = main()
    solutions = np.loadtxt("2022/solutions/04", dtype=int)

    if np.all(results != solutions) :
        raise ValueError("solutions are incorrect")

