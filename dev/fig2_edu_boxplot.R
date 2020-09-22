# packages
library(dplyr)
library(ggplot2)
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))


# import data
data1 <- read.csv("data/anes_edu.csv", header=TRUE)


# count by eduID only
dataBox <- (data1 %>% count(year, eduID))
# Make two new columns of total Dem and Rep
dataBox[, 4] <- (data1[ data1$partyID == 1, ] %>% count(year, eduID))$n
dataBox[, 5] <- (data1[ data1$partyID == 3, ] %>% count(year, eduID))$n
# input total number of dem and rep
foo5 <- (data1 %>% count(year, partyID))$n
foo6 <- as.data.frame(t(matrix(foo5, nrow=3, ncol=length(foo5)/3)))
foo6.expanded <- foo6[ rep(row.names(foo6), each=4) , c(1,3) ]
dataBox[, 6:7] <- foo6.expanded
# probability
dataBox[, 8] <- dataBox[, 4] / dataBox[, 6] * 100
dataBox[, 9] <- dataBox[, 5] / dataBox[, 7] * 100
dataBox[, 10] <- dataBox[, 8] - dataBox[, 9]



names(dataBox) <- c("year", "eduID", "tot", "dem", "rep",
                 "demTot", "repTot", "P(dem)", "P(rep)", "spread")

# plot
dataBox$eduID <- as.factor(dataBox$eduID)
p <- ggplot(dataBox, aes(x=eduID, y=spread)) + geom_boxplot()
p
