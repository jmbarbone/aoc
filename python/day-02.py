import pandas as pd

input = pd.read_table("data/day-02.txt", delimiter=" ", names=["range", "letter", "password"])
input['letter'] = input['letter'].str.replace(":", "")
input['range'] = input['range'].str.split("-")
input['password'] = [list(x) for x in input['password']]


def is_valid_password(p, let, r):
    r = [pd.to_numeric(i) for i in r]
    s = sum([let in i for i in p])
    res = s >= r[0] and s <= r[1]
    return res


input.apply(lambda row: is_valid_password(row['password'], row['letter'], row["range"]),
            axis=1).sum()

def is_valid_password2(p, let, r):
    r = [pd.to_numeric(i) for i in r]
    r1 = r[0] - 1
    r2 = r[1] - 1
    
    is_either = p[r1] == let or p[r2] == let
    is_both = p[r1] == let and p[r2] == let
    return is_either and not is_both

input.apply(lambda row: is_valid_password2(row['password'], row['letter'], row["range"]),
            axis=1).sum()
