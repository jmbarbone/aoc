#! /usr/bin/env python3

import numpy as np


def main() :
    data = np.loadtxt("2022/data/03", dtype=str)
    ns = [len(i) for i in data]

    ints2 = [intersect2(i) for i in data]
    numbs2 = [letters_to_number(i) for i in ints2]
    solution1 = np.sum(np.sum(numbs2))

    groups = [i // 3 for i in range(len(data))]

    group_items = []
    for group in np.unique(groups) :
        temp = data[groups == group]
        ints = list(set(temp[0]).intersection(set(temp[1]), set(temp[2])))
        [group_items.append(i) for i in ints]

    numbs3 = [letters_to_number(i) for i in group_items]
    solution2 = np.sum(np.sum(numbs3))

    return [solution1, solution2]


def intersect2(x) :
    n = len(x)
    m = n // 2
    a = set(x[:m])
    b = set(x[m:])
    res = a.intersection(b)
    return list(res)


LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", \
    "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", \
    "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H",\
    "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", \
    "U", "V", "W", "X", "Y", "Z"]


def do_letter_to_number(x) :
    if len(x) != 1 :
        raise ValueError("x must be a single letter")

    return [i + 1 for i,j in enumerate(LETTERS) if j == x][0]


def letters_to_number(x) :
    return [do_letter_to_number(i) for i in x]


if __name__ == "__main__" :
    results = main()
    solutions = np.loadtxt("2022/solutions/03", dtype=int)
    if np.all(results != solutions) :
        raise ValueError("Day 03 solutions are incorrect")