setwd("")
library(dplyr)
library(ggplot2)
library(tidyverse)


#load file
peakfile <- read.table("sample334_up_DAVID.csv", header= TRUE, sep=',')

#filter out any p-value go terms above 0.05
peaktest <- peakfile[peakfile$PValue <= 0.05,]
peaktest2 <- peaktest[order(peaktest$Count, decreasing = TRUE),]
write.csv(peaktest,"334_up_filted.csv")

#-log transform for PValues
PValuelog <-  -log10(peaktest2$PValue)
peaktest2[,5] <- PValuelog

#Round Values for visualisation 
roundfold <- round(peaktest2$Fold.Enrichment,2)
roundpvalue <- round(peaktest2$PValue,2)
peaktest2[,10] <-  roundfold
peaktest2[,5] <- roundpvalue 

#Remove GO number
peaktest3 <- sub('.*\\~', '', peaktest2$Term)
peaktest2[,2] <- peaktest3


#Merge GO Terms with Gene count for Graphical output
GO_count <-  paste0(peaktest2$Term, "(", peaktest2$Fold.Enrichment,")")
peaktest2[,2] <- GO_count
peaktest2[,2] <- str_to_title(peaktest2$Term)
#Produce Horisontal graph on Go Terms Based on Enrichment Score
peaktest2 %>%
  slice(1:10) %>%
  ggplot(., aes(x = Count, y= reorder(Term,Count))) + 
  geom_bar(stat='identity') + scale_x_continuous(position = "top") + 
  labs(title = "Sample 334: GO Analysis (350)", subtitle = "Up Differentally Expressed Genes, => 2 foldchange") + xlab("Gene Count ( -log10[Pvalue])") +ylab("Biological Terms (Enrichment Score)")+ theme(plot.title.position = "plot") + geom_text(aes(label = PValue), size = 3, position=position_stack(vjust = 0.5), color = 'white')



