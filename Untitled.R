df <- data.frame(x = rep(1:6, rep(c(1, 2, 3), 2)), year = 1993:2004, month = c(1, 1:11))

library(dplyr)
count(df, year, month)
#piping
df %>% count(year, month)


df %>% 
    group_by(year, month) %>%
    summarise(number = n())

df %>% 
    group_by(year, month) %>%
    tally()