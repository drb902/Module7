import os
import glob
import pandas as pd

os.chdir("/home/david/Documents/Module7/Data/DNase1/Peakfiles/peakscsv/after_blacklist/")

peakfile = pd.read_csv("peak_11_bl.csv",index_col=0, header=0)
peakfile2 = pd.read_csv("peak_12_bl.csv",index_col=0, header=0)
fulldata = pd.concat([peakfile, peakfile2])
motif_peaks = fulldata.loc[:,['abs_summit','abs_summit']]
motif_peaks.columns = ['summit-200','summit+200']
motif_peaks['summit+200'] += 200
motif_peaks['summit-200'] += -200
fulldata['start'] = motif_peaks['summit-200']
fulldata['end'] = motif_peaks['summit+200']
fulldata.to_csv("DNaseI_92.csv", encoding='utf-8-sig')
