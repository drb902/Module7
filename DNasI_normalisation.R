setwd("/home/david/Documents/Module7/Data/DNase1/Peakfiles/peakscsv/Sample Analysis/Homerfiles/Output files/")
library(edgeR)
library(dplyr)
library(ggplot2)
filenames <- list.files(pattern = ".csv")

for (i in filenames){
  file <- read.csv(i,header = TRUE, row.names = NULL, sep = '\t')
  file$PeakID <- NULL
  View(file)
  file$PeakID <- paste(file$Chr,"-",file$Start)
  View(file)
  file <- file %>%
    select(PeakID, everything())
  row.names(file) <- file$PeakID
  file = subset(file,select =-c(PeakID))
  View(file)
  norm <- file[,c(19,20)]
  View(norm)
  norm[norm==""] <-  0
  norm[is.na(norm)] <- 0
  
  #Normalisation of CPM and Log Transformation 
  cpm <- apply(norm,2, function(x)(x/sum(x)*1000000))
  log_cpm <- log2(cpm + 1)
  foldchange <- (log_cpm[,1] - log_cpm[,2])
  log_cpm = cbind(log_cpm,foldchange)
  log_cpm = as.data.frame(log_cpm)
  
  #Identifying Foldchanges to determin differental open chromatin  activity. 
  log_cpm <- log_cpm %>% 
    mutate(Expression = ifelse((foldchange) > 1, "Up", ifelse(abs(foldchange) < 1, "Nc","Down")))
  View(log_cpm)
  merged1 <- full_join(file,log_cpm)
  file[,19] <- log_cpm[,1]
  file[,20] <- log_cpm[,2]
  file[,21] <- log_cpm[,3]
  file[,22] <- log_cpm[,4]
  colnames(file)[21] <- "Foldchange"
  colnames(file)[22] <- "Expression"
  
  write.csv(file, paste0(i,"_2.csv", sep='\t'))
}

  

  





