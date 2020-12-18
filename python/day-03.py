import pandas as pd
import numpy as np

input = pd.read_table("data/day-03.txt", names=["x"])

# Need to split by every character
input["x"] = input["x"].apply(lambda x: [i for i in x])

nr = input.shape[0]
# nc = input.shape[1]
nc = len(input["x"][0])

out = []
y = 0

for i in range(1, nr):
    y = y + 3
    
    if y >= nc:
        y = y - nc
    
    out.append(input["x"][i][y])

assert (len(out) == nr - 1), "Length is not equal to rows"
assert (sum([i == "#" for i in out]) == 244), "Sum does not equal 244"

def slope_it_py(right=1, down=1):
    out = []
    y = 0
    for i in range(down, nr, down):
        y = y + right
        
        if y >= nc:
            y = y - nc
        
        out.append(input["x"][i][y])
  
    return(sum([i == "#" for i in out]) * 1.0)

res = [slope_it_py(x, y) for x,y in zip([1, 3, 5, 7, 1], [1, 1, 1, 1, 2])]
res # [1]  90 244  97  92  48
assert (np.prod(res) == 9406609920), "Not the correct answer"

