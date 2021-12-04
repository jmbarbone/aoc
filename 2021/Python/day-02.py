import pandas as pd
import unittest


def day_02a(DataFrame) :
    x = DataFrame.groupby("direction").sum()
    res = x["value"]["forward"] * (x["value"]["down"] - x["value"]["up"])
    return res


def day_02b(DataFrame) :
  # initialize values at 0
  aim = 0
  horizontal = 0
  depth = 0
  
  for i in range(len(DataFrame)) :
      step = DataFrame["direction"][i]
      
      if step == "down" :
          aim = aim + DataFrame["value"][i]
      elif step == "up" :
          aim = aim - DataFrame["value"][i]
      elif step == "forward" :
          horizontal = horizontal + DataFrame["value"][i]
          depth = depth + aim * DataFrame["value"][i]
      else :
          raise ValueError(f'"{step}" is not a valid step')
  
  res = horizontal * depth
  return res


class testDay02(unittest.TestCase) :

    def test_day_02a(self) :
        self.assertEqual(day_02a(df), 1459206)
  
    def test_day_02b(self) :
        self.assertEqual(day_02b(df), 1320534480)
  

if __name__ == '__main__':
    df = pd.read_table("data/day-02.txt", delimiter=" ", names=["direction", "value"])
    unittest.main()
