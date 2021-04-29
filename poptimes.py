import populartimes
import pandas as pd

key = "AIzaSyC49nDgrH1XV_3GWPZejjfCVizSB7wzZFY"

# print(populartimes.get(key, ["bar"], (44.489066,-73.194732), (44.457708,-73.228400)))


times = [0] * 24


bars = pd.read_json("btv-bars.json")
# nbars = pd.json_normalize(bars)
print(bars.head())