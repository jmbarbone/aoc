
import numpy as np
import unittest


def day_03a(data) :
    gamma = []
    epsilon = []

    for i in range(data.shape[1]) :
        if data[:,i].mean() >= 0.5 :
            gamma.append(1)
            epsilon.append(0)
        else :
            gamma.append(0)
            epsilon.append(1)

    gamma = int("".join([str(i) for i in gamma]), 2)
    epsilon = int("".join([str(i) for i in epsilon]), 2)
    res = gamma * epsilon
    return res


def day_03b(data) :
    gamma = find_gamma(data)
    epsilon = find_epsilon(data)
    res = gamma * epsilon
    return res


def find_gamma(data) :
    gamma = data.copy()
    i = 0
    while gamma.shape[0] > 1 :
        if gamma[:,i].mean() >= 0.5 :
            val = 1
        else :
            val = 0

        gamma = gamma[gamma[:,i] == val]
        i = i + 1

    gamma = int("".join([str(i) for i in gamma[0].tolist()]), 2)
    return gamma


def find_epsilon(data) :
    epsilon = data.copy()
    i = 0
    while epsilon.shape[0] > 1 :
        if epsilon[:,i].mean() >= 0.5 :
            val = 0
        else :
            val = 1

        epsilon = epsilon[epsilon[:,i] == val]
        i = i + 1

    epsilon = int("".join([str(i) for i in epsilon[0].tolist()]), 2)
    return epsilon


class testDay03(unittest.TestCase) :

    def test_day_03a(self) :
        self.assertEqual(day_03a(data), 2724524)

    def test_day_03b(self) :
        self.assertEqual(day_03b(data), 2775870)


if __name__ == "__main__" :
    data = np.loadtxt("data/day-03.txt", dtype=str)
    data = [[j for j in i] for i in data]
    data = np.array(data, dtype=int)
    unittest.main()
