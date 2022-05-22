import numpy as np
import unittest
from functools import reduce
import operator

""""
Count 1, 4, 7, and 8.
Count the number of segments

(these are nubmers 0 through 9; just squint a bit)

  0:      1:      2:      3:      4:
 aaaa    ....    aaaa    aaaa    ....
b    c  .    c  .    c  .    c  b    c
b    c  .    c  .    c  .    c  b    c
 ....    ....    dddd    dddd    dddd
e    f  .    f  e    .  .    f  .    f
e    f  .    f  e    .  .    f  .    f
 gggg    ....    gggg    gggg    ....

  5:      6:      7:      8:      9:
 aaaa    aaaa    aaaa    aaaa    aaaa
b    .  b    .  .    c  b    c  b    c
b    .  b    .  .    c  b    c  b    c
 dddd    dddd    ....    dddd    dddd
.    f  e    f  .    f  e    f  .    f
.    f  e    f  .    f  e    f  .    f
 gggg    gggg    ....    gggg    gggg
"""

def day_08a() :
    """
    Only determine the unique numbers (1, 4, 7, and 8)
    """
    return np.sum([len(j) in [2, 4, 3, 7] for i in outputs for j in i])


def day_08b() :
    """
    Need to determine new configurations for all lines.

    Possible new configuaration:
         dddd
        e    a
        e    a
         ffff
        g    b
        g    b
         cccc
    """
    configs = [get_config(entry) for entry in entries]
    new_outputs = [rearrange_letters(output, config) for output,config in zip(outputs, configs)]
    results = [make_number(new) for new in new_outputs]
    return sum(results)

    
def rearrange_letters(output, config) :
    return ["".join(match_letters(list(out), config)) for out in output]


def match_letters(out, config) :
    """Config is ordered abcdefg, so find the index and replace"""
    res = []

    for o in out :
        # reset found
        found = False

        for c,l in zip(config, letters) :
            if o == c :
                # when found, append to result
                found = True
                res.append(l)
            if found:
                # check found, skip to next
                next
        # when none are found, just append a None
        if not found:
            res.append(None) 

    return sorted(res)

letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g']

def get_config(entry) :
    """
    Returns a list of congiguration letters
    """
    for chunk in entry :
        n = len(chunk)
        if n == 2 :
            one = chunk
        elif n == 4 :
            four = chunk
        elif n == 3 :
            seven = chunk
    
    a = list(setdiff(seven, one))[0]
    c_f = intersect(seven, one)
    a_c_f = c_f.copy()
    a_c_f.add(a)
    b_d = setdiff(four, a_c_f)

    # 4 is inside 9 (remove a)
    a_4 = a
    a_4 = a_4.join(four)
    g_e = [setdiff(i, a_4) for i in entry]
    g = list([i for i in g_e if len(i) == 1][0])[0]
    g_e = reduce(operator.or_, g_e)
    e = list(setdiff(g_e, g))[0]

    # d has all 
    d = reduce(operator.and_, [set(chunk) for chunk in entry if len(chunk) == 5])
    d = list(setdiff(d, [a, g]))[0]
    b = list(setdiff(b_d, d))[0]

    f = reduce(operator.and_, [set(chunk) for chunk in entry if len(chunk) == 6])
    f = list(setdiff(f, [a, b, d, g, e]))[0]
    c = list(setdiff(c_f, f))[0]

    res = [a, b, c, d, e, f, g]
    return res


def make_number(new) :
    numbers = [old_numbers[n] for n in new]
    value = "".join([str(i) for i in numbers])
    value = int(value)
    return(value)


def setdiff(x, y) :
    return set(x).difference(set(y))


def intersect(x, y) :
    return set(x).intersection(set(y))


old = ["a", "b", "c", "d", "e", "f", "g"]
old_numbers = {
    "abcefg": 1,
    "cf": 2,
    "acdeg": 3,
    "acdfg": 4,
    "bcdf": 5,
    "abdfg": 6,
    "abdefg": 7,
    "acf": 8,
    "abcdefg": 9,
    "abcdfg": 10 
}

class testDay07(unittest.TestCase) :

    def test_day_08a(self) :
        self.assertEqual(day_08a(), 470)

    def test_day_08b(self) :
        self.assertEqual(day_08b(), 989396)


if __name__ == '__main__':
    data = np.loadtxt("data/day-08.txt", dtype=str, delimiter=" ")
    entries = [i[:10] for i in data]
    outputs = [i[11:] for i in data]
    unittest.main()
