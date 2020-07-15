setwd("")
library("ggplot2")
library("dplyr")

#Load CSV
S092 = read.csv("sample_092.csv",header = TRUE, row.names = 1, sep = ",")
S120 = read.csv("sample_120.csv",header = TRUE, row.names = 1, sep = ",")
S094 = read.csv("sample_094.csv",header = TRUE, row.names = 1, sep = ",")
S150 = read.csv("sample_150.csv",header = TRUE, row.names = 1, sep = ",")
S100 = read.csv("sample_100.csv",header = TRUE, row.names = 1, sep = ",")
S334 = read.csv("sample_334.csv",header = TRUE, row.names = 1, sep = ",")

#Calculate foldchange 
foldchange_092 <- (S092$X.X17003. - S092$X.X17004.)
foldchange_120 <- (S120$X.X17005. - S120$X.X17006.)
foldchange_094 <- (S094$X.X17007. - S094$X.X17008.)
foldchange_150 <- (S150$X.X17009. - S150$X.X17010.)
foldchange_100 <- (S100$X.X17011. - S100$X.X17012.)
foldchange_334 <- (S334$X.X17013. - S334$X.X17014.)


#Add  foldchange to column 
S092_results = cbind(S092,foldchange_092)
S120_results = cbind(S120,foldchange_120)
S094_results = cbind(S094,foldchange_094)
S150_results = cbind(S150,foldchange_150)
S100_results = cbind(S100,foldchange_100)
S334_results = cbind(S334,foldchange_334)

S092_results = as.data.frame(S092_results)
S120_results = as.data.frame(S120_results)
S094_results = as.data.frame(S094_results)
S150_results = as.data.frame(S150_results)
S100_results = as.data.frame(S100_results)
S334_results = as.data.frame(S334_results)

#Workingout Expression differences subclone 1 Vs Subclone 2. 
S092_results <- S092_results %>% 
  mutate(Expression = ifelse((foldchange_092) > 1, "up", ifelse(abs(foldchange_092) < 1, "NC","down")))

S120_results <- S120_results %>% 
  mutate(Expression = ifelse((foldchange_120) > 1, "up", ifelse(abs(foldchange_120) < 1, "NC","down")))

S094_results <- S094_results %>% 
  mutate(Expression = ifelse((foldchange_094) > 1, "up", ifelse(abs(foldchange_094) < 1, "NC","down")))

S150_results <- S150_results %>% 
  mutate(Expression = ifelse((foldchange_150) > 1, "up", ifelse(abs(foldchange_150) < 1, "NC","down")))

S100_results <-S100_results %>% 
  mutate(Expression = ifelse((foldchange_100) > 1, "up", ifelse(abs(foldchange_100) < 1, "NC","down")))

S334_results <- S334_results %>% 
  mutate(Expression = ifelse((foldchange_334) > 1, "up", ifelse(abs(foldchange_334) < 1, "NC","down")))

#Update Rownames 
rowresults <- rownames(S092)
rownames(S092_results) <- rowresults
rownames(S120_results) <- rowresults
rownames(S094_results) <- rowresults
rownames(S150_results) <- rowresults
rownames(S100_results) <- rowresults
rownames(S334_results) <- rowresults

#Update Column sample name
names(S092_results)[1] <- "S17003"
names(S092_results)[2] <- "S17004"

names(S120_results)[1] <- "S17005"
names(S120_results)[2] <- "S17006"

names(S094_results)[1] <- "S17007"
names(S094_results)[2] <- "S17008"

names(S150_results)[1] <- "S17009"
names(S150_results)[2] <- "S17010"

names(S100_results)[1] <- "S17011"
names(S100_results)[2] <- "S17012"

names(S334_results)[1] <- "S17013"
names(S334_results)[2] <- "S17014"



#Calculate expression of each gene 
S092_results$mean <- rowMeans(S092_results[,c("S17003","S17004")])
S120_results$mean <- rowMeans(S120_results[,c("S17005","S17006")])
S094_results$mean <- rowMeans(S094_results[,c("S17007","S17008")])
S150_results$mean <- rowMeans(S150_results[,c("S17009","S17010")])
S100_results$mean <- rowMeans(S100_results[,c("S17011","S17012")])
S334_results$mean <- rowMeans(S334_results[,c("S17013","S17014")])
View(S092_results)

#Creat Dataframes only including Up and Down Regulated Genes
upReg <- c("up")
downReg <- c("down")


up_de_092 <- S092_results %>% filter( Expression %in% upReg)
up_de_120 <- S120_results %>% filter( Expression %in% upReg)
up_de_094 <- S094_results %>% filter( Expression %in% upReg)
up_de_150 <- S150_results %>% filter( Expression %in% upReg)
up_de_100 <- S100_results %>% filter( Expression %in% upReg)
up_de_334 <- S334_results %>% filter( Expression %in% upReg)

down_de_092 <- S092_results %>% filter( Expression %in% downReg)
down_de_120 <- S120_results %>% filter( Expression %in% downReg)
down_de_094 <- S094_results %>% filter( Expression %in% downReg)
down_de_150 <- S150_results %>% filter( Expression %in% downReg)
down_de_100 <- S100_results %>% filter( Expression %in% downReg)
down_de_334 <- S334_results %>% filter( Expression %in% downReg)





#PLot MAplots
plot092 <- ggplot(data = S092_results, aes(x = mean, y = foldchange_092, colour = Expression)) +
  geom_point()
plot092 + ggtitle("samples 092 MAPlot") + xlab("Mean") + ylab("log2 foldchange")


plot120 <- ggplot(data = S120_results, aes(x = mean, y = foldchange_120, colour = Expression)) +
  geom_point()
plot120 + ggtitle("samples 120 MAPlot") + xlab("Mean") + ylab("log2 foldchange")


plot094 <- ggplot(data = S094_results, aes(x = mean, y = foldchange_094, colour = Expression)) +
  geom_point()
plot094 + ggtitle("samples 094 MAPlot") + xlab("Mean") + ylab("log2 foldchange")


plot150 <- ggplot(data = S150_results, aes(x = mean, y = foldchange_150, colour = Expression)) +
  geom_point()
plot150 + ggtitle("samples 150 MAPlot") + xlab("Mean") + ylab("log2 foldchange")


plot100 <- ggplot(data = S100_results, aes(x = mean, y = foldchange_100, colour = Expression)) +
  geom_point()
plot100 + ggtitle("samples 100 MAPlot") + xlab("Mean") + ylab("log2 foldchange")


plot334 <- ggplot(data = S334_results, aes(x = mean, y = foldchange_334, colour = Expression)) +
  geom_point()
plot334 + ggtitle("samples 334 MAPlot") + xlab("Mean") + ylab("log2 foldchange")



#Save changes in a CSV file 

write.csv(S092_results,"logfold_sample092.csv")
write.csv(S094_results,"logfold_sample094.csv")
write.csv(S100_results,"logfold_sample100.csv")
write.csv(S120_results,"logfold_sample120.csv")
write.csv(S150_results,"logfold_sample150.csv")
write.csv(S334_results,"logfold_sample334.csv")

write.csv(up_de_092,"up_de_sample092.csv")
write.csv(up_de_094,"up_de_sample094.csv")
write.csv(up_de_100,"up_de_sample100.csv")
write.csv(up_de_120,"up_de_sample120.csv")
write.csv(up_de_150,"up_de_sample150.csv")
write.csv(up_de_334,"up_de_sample334.csv")

write.csv(down_de_092,"down_de_sample092.csv")
write.csv(down_de_094,"down_de_sample094.csv")
write.csv(down_de_100,"down_de_sample100.csv")
write.csv(down_de_120,"down_de_sample120.csv")
write.csv(down_de_150,"down_de_sample150.csv")
write.csv(down_de_334,"down_de_sample334.csv")
  