# packages
library(dplyr)

# import data
dataFull <- read.table("data/anes_timeseries_cdf_rawdata.txt", 
                       header=TRUE, sep=",", dec=".")

years <- unique( dataFull$VCF0004)


########################################################################
# sample subset
# take 2016 data
data2016 <- dataFull[ dataFull$VCF0004 == 2016, ]
# take only relevant columns
# interested in 
#   VCF0110 education - 4 categories
#   VCF0301 political identification - 7 categories
#   VCF0306 father's political identification 
#   VCF0307 mother's political identification 

data2016sub <- as.data.frame( 
    cbind(data2016$VCF0110, data2016$VCF0301) 
)

# clean NA entries
data2016sub <- data2016sub[complete.cases(data2016sub), ]

# clean 0 entries
data2016sub <- data2016sub[data2016sub$V1 != 0, ]

# separate into parties and plot using table
# separate into political parties
dem = data2016sub[ data2016sub$V2 %in% c(1,2,3), ]
ind = data2016sub[ data2016sub$V2 == 4, ]
rep = data2016sub[ data2016sub$V2 %in% c(5,6,7), ]

dem_freq = as.data.frame( table(dem$V1) )
ind_freq = as.data.frame( table(ind$V1) )
rep_freq = as.data.frame( table(rep$V1) )

foo <- rbind(dem_freq, ind_freq, rep_freq)$Freq
# fail in for loop
dem_freq$Freq / dim(dem)[1] * 100
ind_freq$Freq / dim(ind)[1] * 100
rep_freq$Freq / dim(rep)[1] * 100


# using aggregate
data1 <- as.data.frame( 
    cbind(dataFull$VCF0004, dataFull$VCF0110, dataFull$VCF0303) 
)

# clean NA entries
data1 <- data1[ complete.cases(data1), ]

# clean 0 entries
data1 <- data1[data1$V2 != 0, ]
data1 <- data1[data1$V3 != 0, ]

# require dplyr
foo <- data1 %>% count(V1, V2, V3)

foo2 <- (data1 %>% count(V1, V2))
foo2.expanded <- foo2[ rep(row.names(foo2), each=3), 2:3 ]



foo3 <- (data1 %>% count(V1, V3))
foo3.expanded <- foo3[ rep(row.names(foo3), each=4), 2:3 ]



foo[, 5] <- foo2.expanded[, 2]
foo[, 6] <- foo[,4] / foo[,5]

foo<- foo[order(foo$V1, foo$V3),]

foo[, 7] <- foo3.expanded[, 2]
foo[, 8] <- foo[,4] / foo[,7]

names(foo) <- c("year", "eduIDl", "partyID", "count", "eduSum", 
                "countPerEdu", "partySum", "countPerParty" )

########################################################################
# Do the same thing, loop over year 
df <- data.frame(matrix(ncol = 12, nrow = 0))

for (y in years) {
    # attract th year
    dataYear <- dataFull[ dataFull$VCF0004 == y, ]
    
    # subset containing education & political id
    dataYearSub <- as.data.frame( 
        cbind(dataYear$VCF0110, dataYear$VCF0301) 
    )

    # remove NA
    dataYearSub <- dataYearSub[complete.cases(dataYearSub), ]   
    
    # remove 0 
    dataYearSub <- dataYearSub[dataYearSub$V1 != 0, ]

    # calculate number per political id
    dem <- dataYearSub[ dataYearSub$V2 %in% c(1,2,3), ]
    ind <- dataYearSub[ dataYearSub$V2 == 4, ]
    rep <- dataYearSub[ dataYearSub$V2 %in% c(5,6,7), ]
    
    dem_freq = as.data.frame( table(dem$V1) )
    ind_freq = as.data.frame( table(ind$V1) )
    rep_freq = as.data.frame( table(rep$V1) )
    
    df[nrow(df) + 1,] <- rbind(dem_freq, ind_freq, rep_freq)$Freq
}

df


    

    
    dem_freq = as.data.frame( table(dem$V1) )
    ind_freq = as.data.frame( table(ind$V1) )
    rep_freq = as.data.frame( table(rep$V1) )
    
    dem_freq$Freq / dim(dem)[1] * 100
    ind_freq$Freq / dim(ind)[1] * 100
    rep_freq$Freq / dim(rep)[1] * 100
    
    # ... make some data
    
    output <- data.frame(t(c(dem_freq$Freq / dim(dem)[1] * 100, 
                           ind_freq$Freq / dim(ind)[1] * 100,
                           rep_freq$Freq / dim(rep)[1] * 100
                           )))

    output$y <- y  # maybe you want to keep track of which iteration produced it?
    datalist[[y]] <- output # add it to your list
}


datalist = list()

for (i in years) {
    # ... make some data
    dat <- data.frame(x = rnorm(10), y = runif(10))
    dat$i <- i  # maybe you want to keep track of which iteration produced it?
    datalist[[i]] <- dat # add it to your list
}

df <- data.frame(matrix(ncol = 3, nrow = 0))

for (i in years) {
    df[nrow(df) + 1,] = c(i, rnorm(10), runif(10))
}

big_data = do.call(rbind, datalist)


big_data = do.call(rbind, datalist)
big_data
output <- data.frame(c(dem_freq$Freq / dim(dem)[1] * 100, 
                       ind_freq$Freq / dim(ind)[1] * 100,
                       rep_freq$Freq / dim(rep)[1] * 100
))

output

