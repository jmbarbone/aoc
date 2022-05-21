import numpy as np
import unittest


def day_08a() :
    return np.sum([len(j) in [2, 4, 3, 7] for i in outputs for j in i])


def day_08b(x) :
    return None


def iterative_cumsum(n) :
    return (n**2 + n) / 2


class testDay07(unittest.TestCase) :

    def test_day_08a(self) :
        self.assertEqual(day_08a(), 470)

    # def test_day_08b(self) :
    #     self.assertEqual(day_08b(), 989396)


if __name__ == '__main__':
    x = np.loadtxt("data/day-08.txt", dtype=str, delimiter=" ")
    entries = [i[:10] for i in x]
    outputs = [i[11:] for i in x]
    unittest.main()
