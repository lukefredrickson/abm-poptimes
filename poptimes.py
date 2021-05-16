import populartimes
import pandas as pd
import json

key = "AIzaSyC49nDgrH1XV_3GWPZejjfCVizSB7wzZFY"

place = "supermarket"

btv_coords_1 = (44.489066,-73.194732)
btv_coords_2 = (44.457708,-73.228400)
catamount = (44.44749398413277, -73.04836752811984)

times = (populartimes.get(key, [place], btv_coords_1, btv_coords_2))

filename = "btv-{0}.json".format(place)
with open(filename, 'w') as fout:
    json.dump(times , fout)