setwd("")
library(dplyr)


#Load csv file
seqdata <-read.csv2(file = 'rnaFPKM.csv',row.names=1, header = TRUE,sep = ",",dec =".")
View(seqdata)

#Any empty cells are filled with 0
seqdata[seqdata==""] <-  0
View(seqdata)
  
#Any cells containing NA is replaced with 0
seqdata[is.na(seqdata)] <- 0
View(seqdata)
  
#Order the Columns into alphabetical order
seqdata <-  seqdata[, order(names(seqdata))]
View(seqdata)
  
#Removes any genes which does not have a FPKM value of at least 1 in one column 
seqdata <- seqdata[apply(seqdata[1:12] >= 1, 1, any),]
View(seqdata)
write.csv(seqdata,"cleandata.csv")
  
#Convert dataframe to matrix for normalisation. 
seq_pre = as.matrix(seqdata, row.names=1, header=TRUE)
View(seq_pre)
write.csv(seq_pre,"preUQ.csv")

  
#Carry out quantile normalisation to count using preprocessCore. 
seq_norm <- apply(seq_pre, 2, function(x){quantile(x,0.75)})
seq_med <- median(seq_norm)
seq_norm_1 <- seq_norm/seq_med
seq_norm_2 <- t(t(seq_pre)/seq_norm_1)
View(seq_norm_2)
write.csv(seq_norm_2,"UQseq.csv")

#Log2 on data set.
seqlog_norm <- log2(seq_norm_2 + 1)
write.csv(seqlog_norm,"UQlogseq.csv")





     