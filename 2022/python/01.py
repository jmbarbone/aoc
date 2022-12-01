
import numpy as np
import unittest


def prep() :
  x = data.split("\n\n")
  splits = [i.split() for i in x]
  return [sum([int(e) for e in i]) for i in splits]
  
  
def day_01a() :
    x = prep()
    res = max(x)
    return res


def day_01b() :
    x = prep()
    x.sort()
    res = sum(x[-3:])
    return res


class testDay01(unittest.TestCase) :

    def test_day_01a(self) :
      self.assertEqual(day_01a(), solutions[0])

    def test_day_01b(self) :
      self.assertEqual(day_01b(), solutions[1])


if __name__ == '__main__':
    solutions = np.loadtxt("2022/solutions/01")
    with open("2022/data/01") as f:
      data = f.read().rstrip()
    
    unittest.main()
