library(tidyverse)

dataFull <- read.csv("output/anes_trimmed.csv", header=TRUE)

data1 <- as.data.frame( cbind(dataFull$VCF0004, dataFull$VCF0110, 
                              dataFull$VCF0303) )
names(data1) <- c("year", "eduID", "partyID")
data1 <- data1[ complete.cases(data1), ]
data1 <- data1[ data1$eduID != 0, ]
data1 <- data1[ data1$partyID != 0, ]

# export to file
write.csv(data1, "output/anes_edu.csv", row.names = TRUE)
