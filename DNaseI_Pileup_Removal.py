import os
import sys
import glob
import pandas as pd
from pathlib import Path
os.chdir("/home/david/Documents/Module7/Data/DNase1/Peakfiles/peakscsv/Originalfiles/")
allfiles = glob.glob('*.csv')

for file in allfiles:
    df = pd.read_csv(file, sep=",",index_col= 0)
    print(file)
    print(df.shape[0])
    test = len(df[df['pileup'] <= 10])
    print(test)
    df = df[df['pileup'] > 10]
    print(df.shape[0])
    df.to_csv(file + "removal.csv")
