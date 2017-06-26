rm(list=ls())

# Run the Setup Gist

source("https://gist.githubusercontent.com/DragonflyStats/9ecf8db90e1002f937c228fdabd26a0b/raw/97ee5a2bfa4f30eb61fa9a900c1abc724e7bc24a/IRLOGIsetup.R")


########################################

# Load Packages

library(dplyr)
library(tidyr)
library(magrittr)

library(rgdal)
library(sp)
library(plyr)
library(maps)


library(ggplot2)
library(ggmap)
library(ggns)
library(ggthemes)

library(scales)
library(reshape2)
library(RColorBrewer)

###########################################

setwd("C://GSI//IEmapdata")




########################################

# Help Files
# Commenting


########################################

getwd()
# setwd()

# Load Data

# 1. GSI GroundWater Data
#     - MS Versions
#     - CSV Versions only
# 2. Irish Admin Data Shapefiles
#     - county points (vertices)
#     - county data   (attribute table)
# 3. Dragonfly Spotting Data
# 4. Dog Data (simple)
# 5. Midland Townlands (simple)

########################################


# Learning Basic R commands

A <- 5;
B <- 6;
A+B

mean(c(12,18,NA,21,25))

# Data Types and Data Structures
# Tail

########################################

# Working with GSI Data

# checking attributes

# names(Connacht)
# dim(Connacht)
# class(Connacht)
# mode(Connacht)
# summary(Connacht)
# str(Connacht)

# Aggregation
# Chi-Square
# Cross-Tabulation

########################################
# Transformation of Projects

# Converting from one projection to another
# putting points on a map

########################################

# how to pick out rows and columns
# dplyr
# joining two tables by ID


#######################################
### Geocoding


# colour by category
# scale bar and North Arrow

#######################################

# google map with points
# Chloropleth with pie-charts or Histograms per county

# Wells by Category - points on a map of Connacht

# Legend  
# North Arrow
# Scale Bar
# 
# OSM

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

########################################

## North Symbol and Scale Bar

# ggsn: North Symbols and Scale Bars for Maps Created with 'ggplot2' or 'ggmap'
# Adds north symbols (18 options) and scale bars in kilometers to maps in geographic or metric coordinates created with 'ggplot2' or 'ggmap'.


# ggplot(map.df, aes(long, lat, group = group, fill = var)) +
#   geom_polygon() +
#   coord_equal() +
#   geom_path() +
#   north(map.df) + 
#   scalebar(map.df, dist = 5, dd2km = TRUE, model = 'WGS84')
