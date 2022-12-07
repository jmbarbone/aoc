#! /usr/bin/env python3

import numpy as np
import pandas as pd


def main() :
    with open("2022/data/05") as f:
        input = f.read().splitlines()

    lines = input[0:8]

    # split string into chunks of 4 length strings
    chunks = lambda x, n: [x[i:i+n] for i in range(0, len(x), n)]
    chunky = [chunks(i, 4) for i in lines]
    stacks = np.stack([chunks(i, 4) for i in lines])
    stacks = np.transpose(stacks)

    boxes = {i: stacks[i] for i in range(len(stacks))}
    boxes = {i: [j.replace("[", "").replace("]", "") for j in boxes[i]] for i in boxes}
    boxes = {i: [j.strip() for j in boxes[i]] for i in boxes}
    # remove all empty strings
    boxes = {i: [j for j in boxes[i] if j != ""] for i in boxes}
    # keep only second character
    # boxes = {i: [j[1] for j in boxes[i]] for i in boxes}

    steps = input[10:]
    steps = [i.replace("move", "").replace("from", "").replace("to", "").strip() for i in steps]
    steps = [[int(j) for j in i.split("  ")] for i in steps]

    for i in range(len(steps)) :
        steps[i][1] = steps[i][1] - 1
        steps[i][2] = steps[i][2] - 1

    pos1 = boxes.copy()
    pos2 = boxes.copy()

    for step in steps :
        # [0]: n_elements
        # [1]: from_stack
        # [2]: to_stack
        # move n_elements from from_stack to to_stack
        pos1[step[2]] = pos1[step[1]][:step[0]][::-1] + pos1[step[2]]
        pos1[step[1]] = pos1[step[1]][step[0]:]   

        pos2[step[2]] = pos2[step[1]][:step[0]] + pos2[step[2]]
        pos2[step[1]] = pos2[step[1]][step[0]:]   

    # get first element on positions1  
    solution1 = "".join([pos1[i][0] for i in pos1])
    solution2 = "".join([pos2[i][0] for i in pos2])
    return [solution1, solution2]


if __name__ == "__main__" :
    results = main()
    solutions = np.loadtxt("2022/solutions/05", dtype=str)

    if np.all(results != solutions) :
        raise ValueError("solutions are incorrect")

