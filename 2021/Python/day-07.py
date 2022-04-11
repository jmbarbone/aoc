import numpy as np
import unittest


def day_07a(x) :
    m = np.median(x)
    return sum([abs(i - m) for i in x])


def day_07b(x) :
    unique = np.unique(x)
    ans = np.inf

    for u in unique :
        diffs = [abs(i - u) for i in x]
        res = [iterative_cumsum(i) for i in diffs]
        res = sum(res)

        if res < ans :
            ans = res

    return ans


def iterative_cumsum(n) :
    return (n**2 + n) / 2


class testDay07(unittest.TestCase) :

    def test_day_07a(self) :
        self.assertEqual(day_07a(x), 356958)
  
    def test_day_07b(self) :
        self.assertEqual(day_07b(x), 105461913)
  

if __name__ == '__main__':
    x = np.loadtxt("data/day-07.txt", dtype=int, delimiter=",")
    unittest.main()
