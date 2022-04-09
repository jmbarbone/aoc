import numpy as np
import unittest


def day_06a(x) :
    return do_solution(x, days=80)


def day_06b(x) :
    return do_solution(x, days=256)


def do_solution(x, days=1) :
    counter = {
        "zero" : 0.0,
        "one" : np.sum(x == 1),
        "two" : np.sum(x == 2),
        "three" : np.sum(x == 3),
        "four" : np.sum(x == 4),
        "five" : np.sum(x == 5),
        "six" : 0.0,
        "seven" : 0.0,
        "eight" : 0.0
    }

    ckeys = list(counter.keys())

    for i in range(days) :
        reference = counter.copy()
        
        # reduce the counter for 1 through 8
        for j in range(0, 8) :
            counter[ckeys[j]] = reference[ckeys[j + 1]]
        
        # at 0 create eight and move back to six
        counter["eight"] = reference["zero"]
        counter["six"] = counter["six"] + reference["zero"]
    
    res = np.sum([i for i in counter.values()])
    return res


class testDay06(unittest.TestCase) :

    def test_day_06a(self) :
        self.assertEqual(day_06a(x), 388739)
  
    def test_day_06b(self) :
        self.assertEqual(day_06b(x), 1741362314973)
  

if __name__ == '__main__':
    x = np.loadtxt("data/day-06.txt", dtype=int, delimiter=",")
    unittest.main()
