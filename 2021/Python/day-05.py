import numpy as np
import unittest
import pyjordan
# pip install git+https://github.com/jmbarbone/pyjordan


def day_05a(x) :
    # filter out only for the horizontals
    y = [i for i in x if is_hv(i)]
    res = do_solution(y)
    return res


# for i,j in make_lines([[1, 4], [1, 5]]):
# # for i,j in make_lines(x[0]):
#     print(f"{i},{j}")

  

def day_05b(x) :
    res = do_solution(x)
    return res


def clean_data(x) :
    # this is so easy to understand
    res = [[[int(k) for k in j.replace("\n", "").split(",")] for j in i.split(" -> ")] for i in x]
    return res


def is_hv(x) :
    """Is x horizontal or vertical?"""
    return (x[0][0] == x[1][0]) or (x[0][1] == x[1][1])


def make_lines(x) :
    # Really if it's a square board it doesn't matter
    rx = do_make_lines(x[0][0], x[1][0])
    ry = do_make_lines(x[0][1], x[1][1])
    
    if len(rx) == 1 :
        rx = list(rx)[0]
        rx = iter([rx for i in ry])
    elif len(ry) == 1 :
        ry = list(ry)[0]
        ry = iter([ry for i in rx])
    elif len(rx) != len(ry) :
        raise Exception("coordinates are not equal")
    
    res = zip(rx, ry)
    return res


def do_make_lines(x1, x2) :
    x = [x1, x2]
    res = range(min(x), max(x) + 1)
    return res


def do_solution(x) :
    m = max_recursive(x)
    board = np.full([m, m], 0)
    
    for i in x :
        for j,k in make_lines(i) :
            if j > m or k > m :
                raise Exception("What?")
            board[j,k] = board[j,k] + 1

    res = (board >= 2).sum()
    return res


def max_recursive(x) :
    return max(pyjordan.unnest(x)) + 1

class testDay04(unittest.TestCase) :

    def test_day_05a(self) :
        self.assertEqual(day_05a(x), 8622)
  
    def test_day_05b(self) :
        self.assertEqual(day_05b(x), 22037)
  

if __name__ == '__main__':
    with open("data/day-05.txt") as f :
        x = f.readlines()

    x = clean_data(x)
    unittest.main()
