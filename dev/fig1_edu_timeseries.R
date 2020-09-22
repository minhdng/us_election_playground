# packages
library(dplyr)
library(ggplot2)
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))


# import data
data1 <- read.csv("data/anes_edu.csv", header=TRUE)


# histogram time series file to plot
frequency <- data1 %>% count(year, eduID, partyID)

# add new col number of people per party, rescale to fit frequency
partySum <- (data1 %>% count(year, partyID))
partySum.expanded <- partySum[ rep(row.names(partySum), each=4) , 2:3 ]

# sort by frequency file by partyID
frequency <- frequency[ order(frequency$year, frequency$partyID) , ]

# then add new column of partySum
frequency[, 5] <- partySum.expanded[, 2]                        

# add new col of percentage
frequency[, 6] <- frequency[, 4] / frequency[, 5] * 100

# change labels
names(frequency) <- c("year", "eduID", "partyID", 
                      "count", "partySum", "percentage" )

# change eduID labels
eduLabel <- data.frame( 
    ID = c(1,2,3,4), 
    level = c("1 Grade School", "2 Highschool", "3 Some College", "4 College")
)

frequency$eduID <- eduLabel$level[ match(frequency$eduID, eduLabel$ID) ]

# graph
ggplot( 
    data=frequency, 
    aes(
        x=year, 
        y=percentage, 
        colour=as.factor(partyID)
        )
) + 
geom_point() + 
geom_line() +
facet_wrap(frequency$eduID ~ .) + 
scale_color_manual(
    name="Party Identification",
    labels=c("Dem", "Ind", "Rep"),
    values=c("blue","brown","red")
) +
scale_x_continuous( limits=c(1948,2020) )


