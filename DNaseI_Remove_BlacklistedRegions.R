  setwd("/home/david/Documents/Module7/Data/DNase1/Peakfiles/peakscsv/lowpeak_removal")
#load csv Files
  df1 <- read.csv2('peak_S_1_removal.csv', sep=',',header = TRUE)
  df2 <- read.csv2('peak_S_2_removal.csv', sep=',',header = TRUE)
  df3 <- read.csv2('peak_S_3_removal.csv', sep=',',header = TRUE)
  df4 <- read.csv2('peak_S_4_removal.csv',sep=',',header = TRUE)
  df9 <- read.csv2('peak_S_9_removal.csv',sep=',',header = TRUE)
  df10 <- read.csv2('peak_S_10_removal.csv',sep=',',header = TRUE)
  df11 <- read.csv2('peak_S_11_removal.csv', sep=',',header = TRUE)
  df12 <- read.csv2('peak_S_12_removal.csv', sep=',',header = TRUE)


#Load Blacklisted Regions 
setwd("/home/david/Documents/Module7/Data/DNase1/Peakfiles/peakscsv/blacklist/")


bl1 <- read.csv2('blacklist_1.csv',sep=',',header = FALSE)
bl2 <- read.csv2('blacklist_2.csv',sep=',',header = FALSE)
bl3 <- read.csv2('blacklist_3.csv',sep=',',header = FALSE)
bl4 <- read.csv2('blacklist_4.csv', sep=',',header = FALSE)
bl9 <- read.csv2('blacklist_9.csv', sep=',',header = FALSE)
bl10 <- read.csv2('blacklist_10.csv', sep=',',header = FALSE)
bl11 <- read.csv2('blacklist_11.csv', sep=',',header = FALSE)
bl12 <- read.csv2('blacklist_12.csv',sep=',',header = FALSE)

#Rename Headers to match patient sample 
colnames(bl1) <- c("chr","start","end","mapability","chr","start","end","name","value")


#Remove Blacklisted Regions. 
peak_1_bl <- df1[!(df1$name %in% bl1$name),]
peak_2_bl <- df2[!(df2$name %in% bl2$name),]
peak_3_bl <- df3[!(df3$name %in% bl3$name),]
peak_4_bl <- df4[!(df4$name %in% bl4$name),]
peak_9_bl <- df9[!(df9$name %in% bl9$name),]
peak_10_bl <- df10[!(df10$name %in% bl10$name),]
peak_11_bl <- df11[!(df11$name %in% bl11$name),]
peak_12_bl <- df12[!(df12$name %in% bl12$name),]

#Save Patient Files without the blacklisted regions 
write.csv(peak_1_bl,"peak_1_bl.csv")
write.csv(peak_2_bl,"peak_2_bl.csv")
write.csv(peak_3_bl,"peak_3_bl.csv")
write.csv(peak_4_bl,"peak_4_bl.csv")
write.csv(peak_9_bl,"peak_9_bl.csv")
write.csv(peak_10_bl,"peak_10_bl.csv")
write.csv(peak_11_bl,"peak_11_bl.csv")
write.csv(peak_12_bl,"peak_12_bl.csv")


