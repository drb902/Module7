import os
import sys
import glob
import pandas as pd


os.chdir("")

allfiles = glob.glob('*.csv')

#loop through all files
for file in allfiles :
    df = pd.read_csv(file,sep=",")
    df = df.set_index("Unnamed: 0")
    
    #Split Peaks into Proximal promoter and Distal 
    nan_df = df[df['Distance.to.TSS'].isnull()]
    df = df.dropna(subset=['Distance.to.TSS'])
    TSS_peak = df[df["Distance.to.TSS"].between(-2000,2000,inclusive=True)]
    Distal_peak = df.drop(TSS_peak.index,axis=0)
    #TSS_peak.to_csv('92_TSSpeaks.csv',sep=",")
  #Distal_peak.to_csv('92_Distalpeaks.csv',sep=",")
    #creation of Bedfiles for HOMER
        #filter for DE Genes

  #Save Peaks into two different CSV files
    de_tss = TSS_peak[TSS_peak.Expression != 'Nc']
    de_tss.to_csv(file + '_detss.csv',sep=",")
    de_distal = Distal_peak[Distal_peak.Expression != 'Nc']
    de_distal.to_csv(file +'_dedistal.csv',sep=",")

  #Edit peaks to contain columns needed for HOMER program on BlueBear. 
    homebedfile_TSS = de_tss[['Chr','Start','End']]
    homebedfile_Distal = de_distal[['Chr','Start','End']]
    homebedfile_TSS.to_csv(file + 'tssmotif.csv',sep=",",index=False, header=False)
    homebedfile_Distal.to_csv(file + 'distalmofit.csv',sep=",",index=False, header = False)
