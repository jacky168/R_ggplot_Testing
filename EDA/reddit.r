getwd()
setwd('/home/jacky/EDA/')

reddit <- read.csv('reddit.csv')
names(reddit)
install.packages('ggplot2', dependencies = T)
library(ggplot2)


level(reddit$age.range)

reddit$age.range <- ordered(reddit$age.range, levels = c( "Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))

qplot(data = reddit, x = age.range)
qplot(data = reddit, x = income.range)