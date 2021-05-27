#%%
import populartimes
import pandas as pd
import json

#%%
key = "AIzaSyC49nDgrH1XV_3GWPZejjfCVizSB7wzZFY"

place = "restaurant"

btv_coords_1 = (44.489066,-73.194732)
btv_coords_2 = (44.457708,-73.228400)
chit_coords_1 = (44.52221193375655, -73.2709032675955)
chit_coords_2 = (44.43990719586817, -73.06731287993185)

#%%
times = (populartimes.get(key, [place], chit_coords_1, chit_coords_2, n_threads=5))

#%%
filename = "chit-{0}.json".format(place)
with open(filename, 'w') as fout:
    json.dump(times , fout)
