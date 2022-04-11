import numpy as np
import unittest


def day_07a(x) :
    x = None
    return x


def day_07b(x) :
    x = None
    return x


class testDay07(unittest.TestCase) :

    def test_day_07a(self) :
        self.assertEqual(day_07a(x), 356958)
  
    def test_day_07b(self) :
        self.assertEqual(day_07b(x), 105461913)
  

if __name__ == '__main__':
    x = np.loadtxt("data/day-7.txt", dtype=int, delimiter=",")
    unittest.main()
