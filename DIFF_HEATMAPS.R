setwd("")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

library("pheatmap")
library("RColorBrewer")

file <- read.csv("sample_334.csv",header=TRUE, row.names=1)

names(file)[1] <- c("CD34-ALCAM+")
names(file)[2] <- c("CD34-ALCAM-")

file[is.na(file)] <- 0

filetest <- file[!(apply(file,1,function(y) any(y == 0))),]
mycolor <-  colorRampPalette(c("blue","white","firebrick"))(500)

pheatmap(filetest,color = mycolor, show_rownames = FALSE,cluster_cols = FALSE, scale="column",legend = FALSE,angle_col = 45,filename = "sample_334.pdf")
