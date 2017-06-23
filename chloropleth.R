rm(list=ls())

library(rgdal)
library(sp)
library(plyr)
library(maps)
library(dplyr)
library(ggplot2)
library(scales)
library(reshape2)
library(RColorBrewer)

###########################################

setwd("C://GSI//IEmapdata")



county = readOGR(dsn=".", layer="IRL_adm1")

###########################################

countynames=sort(unique(county$NAME_1))

###########################################

county@data$id = rownames(county@data)
county.points <- fortify(county, region='id')
county.df = join(county.points, county@data, by="id")

# county@data <- select(county@data,ID_1,NAME_1)

# names(county@data) <- c("id","County")
# county@data$id = as.character(county@data$id)
# county@data$County = as.character(county@data$County)

# county.df <- full_join(county.points, county@data)

##############################################

set.seed(1234);WaterQuality <- USArrests[sample(1:50,26),]

WaterQuality = data.frame(County=countynames,WaterQuality)
rownames(WaterQuality) = 1:26
names(WaterQuality) = c("County","Quality","Taste","Insects","Pollution")

#############################################

WaterQualityMap <- merge(county.df,WaterQuality,by.x="NAME_1",by.y="County")
# WaterQualityMap <- arrange(WaterQualityMap,group,id)

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Boops)) + geom_polygon()

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Boops)) + geom_polygon() + geom_path(color="white") + coord_equal() + scale_fill_gradient(name="Percent", limits=c(30,100), low="white", high="red")
