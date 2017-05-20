setwd("C:\\Users\\kevin.obrien\\Documents\\GitHub\\IRLOGI-GSI")


install.packages("tidyr")
library(tidyr)

towns <- read.csv("irishtowns.csv",header=T)
towns <- unite_(towns, "Address", c("Town","County","Country"),sep=",",remove=TRUE)

install.packages("ggmap")
library(ggmap)


coords <- geocode(towns$Address)
