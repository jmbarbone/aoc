
import numpy as np
import unittest

x = np.loadtxt("data/day-01.txt", dtype=int)


def day_01a() :
  n = len(x)
  res = sum(x[:n - 1] < x[1:])
  return res


def day_01b() :
  # adapted from https://stackoverflow.com/a/54628145/12126576
  # need to ignore the first value
  y = np.convolve(x[1:], np.ones(3), mode="same")
  n = len(y)
  res = sum(y[:n - 1] < y[1:])
  return res


class testDay01(unittest.TestCase) :
  def test_day_01a(self) :
    self.assertEqual(day_01a(), 1696)
  
  def test_day_01b(self) :
    self.assertEqual(day_01b(), 1737)
  

if __name__ == '__main__':
  unittest.main()
