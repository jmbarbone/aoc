
import numpy as np
import unittest

def day_01() :
  x = np.loadtxt("data/day-01.txt", dtype=int)
  n = len(x)
  res = sum(x[range(0, n - 1)] < x[range(1, n)])
  return res


class testDay01(unittest.TestCase) :
  def test_day_01(self) :
    self.assertEqual(day_01(), 1696)
  
if __name__ == '__main__':
  unittest.main()
