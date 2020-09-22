# packages
library(dplyr)
library(ggplot2)
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))
library(gridExtra)




# import data
dataFull <- read.csv("data/anes_trimmed.csv", header=TRUE)


data3 <- as.data.frame( 
    cbind(dataFull$VCF0004,  dataFull$VCF0218, dataFull$VCF0110)
)

# clean NA and invalid entries and non valid temperatures
data3 <- data3[ complete.cases(data3), ]
data3 <- data3[(data3$V2 != 98) & (data3$V2 != 99), ]
data3 <- data3[data3$V3 != 0, ]


# year extract
data4 <- data3[ data3$V1 == 2016, ]


data3$V3 <- as.factor(data3$V3)
data4$V3 <- as.factor(data4$V3)
p1 <- ggplot(data3, aes(x=V3, y=V2)) + geom_boxplot()  
p2 <- ggplot(data4, aes(x=V3, y=V2)) + geom_boxplot()

grid.arrange(p1, p2, ncol=2)

