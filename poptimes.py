import populartimes
import pandas as pd
import json

key = "AIzaSyC49nDgrH1XV_3GWPZejjfCVizSB7wzZFY"

place = "supermarket"

btv_coords_1 = (44.489066,-73.194732)
btv_coords_2 = (44.457708,-73.228400)
chit_coords_1 = (44.256506809080285, -73.28162933966465)
chit_coords_2 = (44.623410204320024, -72.91209477752432)

times = (populartimes.get(key, [place], chit_coords_1, chit_coords_2))

filename = "chit-{0}.json".format(place)
with open(filename, 'w') as fout:
    json.dump(times , fout)