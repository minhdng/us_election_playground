file <- "data/anes_timeseries_cdf_rawdata.txt"
data <- read.table( file , header = TRUE, sep = ",", dec = ".")


years <- unique( data$VCF0004 )


# subset by year

foo <- data[ data$VCF0004 == 1948,  ]
