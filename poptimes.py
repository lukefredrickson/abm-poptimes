import populartimes
import pandas as pd
import json

key = "AIzaSyC49nDgrH1XV_3GWPZejjfCVizSB7wzZFY"

place = 'cafe'

times = (populartimes.get(key, [place], (44.489066,-73.194732), (44.457708,-73.228400)))

filename = "btv-{0}.json".format(place)
with open(filename, 'w') as fout:
    json.dump(times , fout)