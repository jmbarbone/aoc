import numpy as np
import unittest


def day_08a() :
    return np.sum([len(j) in [2, 4, 3, 7] for i in outputs for j in i])


def day_08b() :
    orders = [determine_arrangement(entry) for entry in entries]
    arrangements = [rearrange_letters(i, j) for i,j in zip(outputs, orders)]
    values = []

    for a in arrangements :
        ind = [i for i,j in zip(range(len(old_numbers)), old_numbers) if a == j]
        ind = ind - 1
        value = "".join([str(i) for i in ind])
        value = int(value)
        values.append(value)

    return sum(values)

    
def rearrange_letters(x, by) :
    return None

def determine_arrangement(entry) :
    # Set up some dictionaries to store values
    numbers = {
        "zero": [],
        "one": [],
        "two": [],
        "three": [],
        "four": [],
        "five": [],
        "six": [],
        "seven": [],
        "eight": [],
        "nine": []
    }
    
    # letters will be the output.  These are the "positions" 
    letters = {
        "a": None,
        "b": None,
        "c": None,
        "d": None,
        "e": None,
        "f": None,
        "g": None
    }

    for chunk in entry :
        n = len(chunk)
        if n == 2 :
            numbers["one"] = list(chunk)
        elif n == 4 :
            numbers["four"] = list(chunk)
        elif n == 3 :
            numbers["seven"] = list(chunk)
    
    letters['a'] = list(setdiff(numbers['seven'], numbers['one']))[0]
    c_f = intersect(numbers["seven"], numbers['one'])
    a_c_f = c_f.copy()
    a_c_f.add(letters['a'])
    b_d = setdiff(numbers['four'], a_c_f)

    # 4 is inside 9 (remove a)
    # a_4 = numbers['four']
    # g_e = [setdiff(i, j) for i,j in zip(line, )]
    
    return letters


def rearrange(x, by):
    x = [i for i in x]


def which(x) :
    return [j for i,j in zip(x, range(len(x))) if i]


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
