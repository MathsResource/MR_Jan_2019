#######################################

#  1. Some useful commands to begin with
getwd()

# what version of R?
sessionInfo()

# another useful command is "history()"
history()

# useful for debugging
ls()

# Also discus
# - Help Files
# - Commenting
# - apropos()
# - list.files()

# Installing Packages
install.packages("maptools")
library(maptools)

install.packages("proj4")
library(proj4)

# Learning Basic R commands

A <- 5;
B <- 6;
A+B

# "=" is also a valid assignment operator  

# Characters
ConnachtCounties <-c("Galway","Mayo","Sligo","Leitrim","Roscommon")  

# Booleans / Logicals
Logicals <- c(1,0,1,0,1,1,1,1)
as.logical(Logicals)
mean(Logicals)
sum(Logicals)

# Missing Values

mean(c(12,18,NA,21,25))

# Data Types and Data Structures

#######################################

# 2. Reset the working area and run the Setup Gist

rm(list=ls())

source("https://gist.githubusercontent.com/DragonflyStats/9ecf8db90e1002f937c228fdabd26a0b/raw/97ee5a2bfa4f30eb61fa9a900c1abc724e7bc24a/IRLOGIsetup.R")

########################################

# 3. Load Packages

# Data Management Packages
library(dplyr)
library(tidyr)
library(magrittr)


# GIS packages

# Using maptools 
# found it easiest to install rgeos, and ensure that it was attached prior to attaching maptools

library(ggplot2)
library(rgeos)
library(maptools)
###############
library(rgdal)
library(sp)
library(plyr)
library(maps)
library(mapproj)

# Data Viz Packages
library(ggplot2)
library(ggmap)
library(ggns)
library(ggthemes)

# Some other useful packages
library(scales)
library(reshape2)
library(RColorBrewer)

###########################################

# 4. Working Directories

# Assume all Data is stored in "C:/GSI"

# setwd("C://GSI//IEmapdata")

setwd("C://GSI") 

# If You are using a USB Key replace this with "E:/GSI"
# Lets check do we have our files

list.files()


######################################

# 5A: Read in files (Microsoft)

install.packages("xlsx")
library(xlsx)

# 1. GSI GroundWater Data
#     - MS Versions
#     - CSV Versions only
# Lets pick county Mayo


### WATCH OUT
# Mayo <- read.xlsx("CoMayo.xls")
# Error in read.xlsx("CoMayo.xls") : 
# Please provide a sheet name OR a sheet index.

# Need to supply a page number

Mayo1 <- read.xlsx("CoMayo.xls",1)

# First Page is Meta Data 
# Best to Ignore it
# Try the other pages

Mayo2 <- read.xlsx("CoMayo.xls",2)
Mayo3 <- read.xlsx("CoMayo.xls",3)
Mayo4 <- read.xlsx("CoMayo.xls",4)
######################################

# 5B: Read in files (CSV)

# Exercise for now
Mayo2 <- read.csv("CoMayo.csv")
Mayo3 <- read.csv("CoMayo.csv")
Mayo4 <- read.csv("CoMayo.csv")

# For Later
Connacht <- read.csv("Connacht.csv")

########################################

# 6: Check the data

# KOB Computer Only
 Mayo2 <- read.csv("Mayo2.csv")
 Mayo3 <- read.csv("Mayo3.csv")
 Mayo4 <- read.csv("Mayo4.csv")

# Before we continue, lets get a look at the dimensions of each data set.
# Important for Later

head(Mayo2)
tail(Mayo3)
dim(Mayo4)

# More Useful Commands

class(Mayo2)
mode(Mayo3)
summary(Mayo4)

# names(Connacht)
# dim(Connacht)
# class(Connacht)
# mode(Connacht)
# summary(Connacht)
# str(Connacht)

########################################

# 7: Can we combine the three files into one?

# Three different files
# Can we combine them?
# Lets Check do they have the same variables



names(Mayo2)
names(Mayo3)
names(Mayo4)

# Seems to be manageable here, but other cases could have hundreds.


# Let's use some set theory to check 
# Set Theory is ALWAYS handy.
# Union and Intersection can help here, but we dont need it

names(Mayo2) == names(Mayo3)

 # output should be a series of TRUES and FALSES

mean( names(Mayo2) == names(Mayo4) )

 # If the answer is 1, then both sets are the same.
 # Check that it is the same for Mayo 4
 # It should be the case!


########################################

# 8: Retaining the Well Type Information

# The data was divided into three spreadsheets for a reason.
# We dont want to lose that information. 
# The "rep" function can come in useful here.
# Lets look at some handy commands also

nrow(Mayo2)
ncol(Mayo3)

rep(2,4) 		# Repeat the number 2 four times
rep("GSI",3) 		# Repeat the piece of text "GSI" three times
1:5			# Sequence of Integers 1 to 5
rep(1:5,3)              # Repeat the sequence of integers three times - see order!!
rep(1:5, each =3)       # Similar, but an important difference

rep(c("A","B","C"),4)
rep(c("A","B","C"),each=4)

# Suppose we want a different number of replicates for A,B and C

rep(c("A","B","C"),c(3,6,2))


# What does this do?

c( nrow(Mayo2) , nrow(Mayo3), nrow(Mayo4))

# Can we do this?
# Why would this be useful? 

rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4)))

# Let's Save this as a variable that we can use later

WellType <- rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4)))

length(WellType)

###########################################

# 9: combining Data Frames

# The command we will use here is "rbind()"
# You could verbalise that as "row-bind"
# There is also a "cbind()" command, i.e. column bind

# Lets combine all three as "Mayo"

Mayo <- rbind(Mayo2,Mayo3,Mayo4)

# Can Get Error Messages. Dont Worry about them yet.
# Use some of the commands from Part to see how we got on.

# Optional Housekeeping
# We are not going to use Mayo2, Mayo3 and Mayo4 anymore
# To delete them type "rm(Mayo2)" etc
# Let's retain them until we KNOW we dont need them anymore

###########################################

# 10: Lets put in the well type data

Mayo <- data.frame(Mayo,WellType)

# Remark: Can change the order to put "WellType" First

# Remark : We will use "Connact" from now on

                 
                 



###########################################

# 11 : Lets rearrange the variables

# For this exercise, we would need the "dplyr" R Package

#  Demonstration of "dplyr"
                 
library(dplyr)

# The first command that we will use is "glimpse"
# The variable are either "numeric" or "doubles","logical" or "factors"

# There are some variables that are just for comments: "GenComms" and "DrillComms"
# Lets delete these two variables.
# All of them have "Com" in their name.

Connacht <- select(Connacht, -contains("Com") )


############################################

# 12:  Cross Tabulations and Chi Square Test

# Simple Tabulation commands

table(Connacht$Type)
table(Connacht$Type,Connacht$WellType)
addmargins(table(Connacht$Type,Connacht$WellType))

# Using Magrittr's pipe operator

Connacht$Type %>% table()
Connacht$Type %>% table(Connacht$WellType)
Connacht$Type %>% table(Connacht$WellType) %>% addmargins

# Chi Square Test for Categorical Variables
# Probably would be better with more data, as the sample size is very small.
# Syntax is ok though

chisq.test(Connacht$Type,Connacht$WellType)

# Using Pipe Operator:
# Connacht$Type %>% chisq.test(Connacht$WellType)

##################################
# 12B : Turn "depth" into a categorical variable
# Similar to "WellType" but more explanation of how we derive it 

# Some Clever Maths - Floor and Ceiling functions are very useful.
Connacht <- mutate(Connacht, DepthCat = 20*ceiling(Depth_m/20) )

# Lets combine the very deeps (>100m) into one category
Connacht$DepthCat[Connacht$DepthCat>100] = 100

# Put new variable beside the original variable

Connacht <- select(Connacht, 1:Depth_m, DepthCat,everything())
                 
#########################################
# 13: Year of Drilling

# For this exercise: we will use the lubridate package

# install.packages("lubridate")
library(lubridate)

summary(Connacht$DrillDate)

ymd(Connacht$DrillDate)

year(Connacht$DrillDate)
month(Connacht$DrillDate)
day(Connacht$DrillDate)

# lets add Drill Year to the data set

Connacht <- mutate(Connacht, DrillYear = year(DrillDate) ) 

# Other Time Periods Are Possible

DrillDecade <- (Connacht$DrillYear %/% 10) * 10
DrillPeriod <- (Connacht$DrillYear %/% 5) * 5

########################################
# 14:  Transformation of Projects

                 
# Converting from one projection to another putting points on a map
# using a predfinited function
                 
library(proj4)
proj4string <- "+proj=tmerc +lat_0=53.5 +lon_0=-8 +k=0.99982 +x_0=600000 +y_0=750000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

# Source data
xy <- data.frame(x=715830, y=734697)

# Transformed data
pj <- project(xy, proj4string, inverse=TRUE)
latlon <- data.frame(lat=pj$y, lon=pj$x)
print(latlon)                 
                
# Transformed data

xy <- data.frame(x = Connacht$Easting, y = Connacht$Northing)

# http://spatialreference.org/ref/epsg/29902/proj4js/
proj4string2 <- "+proj=tmerc +lat_0=53.5 +lon_0=-8 +k=1.000035 +x_0=200000 +y_0=250000 +a=6377340.189 +b=6356034.447938534 +units=m +no_defs"

Connacht <- select(Connacht,1:WellType)
xy <- data.frame(x = Connacht$Easting, y = Connacht$Northing)
pj <- project(xy, proj4string2, inverse=TRUE)
latlon <- data.frame(lat=pj$y, lon=pj$x)
print(latlon)  

# Add GPS co-ordinates to Groundwater Data
Connacht <- data.frame(Connacht,latlon)

# House Keeping
rm(latlon);rm(xy)
Connacht <- select(Connacht,1:lon)
detach("package:proj4", unload=TRUE)
                 
########################################
# 15: Geocoding

# requires "ggmap"
geocode("Tuam")

ConnachtTowns <- data.frame(Towns = c("Tuam","Sligo","Castlebar" ),stringsAsFactors = FALSE)
geocode(ConnachtTowns$Towns)
           

# 22. google map with points

geocode("Tuam")
get_map("Tuam") %>% ggmap                 

# Check what is happening with OSM     

#######################################                 

# 16: Reading in the shapefile                  

setwd("C://GSI//IEmapdata")

county = readOGR(dsn=".", layer="IRL_adm1")

county@data$id = rownames(county@data)
county.points <- fortify(county, region='id')
county.df = join(county.points, county@data, by="id")

# READY

# This is useful also
countynames=sort(unique(county$NAME_1))

##############################################
# 17: Make Simple Connacht Map
                 
# Part A:  Use Filter commands to subset to Connacht Counties only

ConnachtCounties <-c("Galway","Mayo","Sligo","Leitrim","Roscommon")                 

county.df %>% filter( NAME_1 %in% ConnachtCounties) -> ConnachtMap
dim(ConnachtMap)                 
                 
ggplot(ConnachtMap,aes(x=long,y=lat,group=group)) + geom_polygon()

#Let's See The Individual Counties
ggplot(ConnachtMap,aes(x=long,y=lat,group=group)) + geom_polygon(fill="white",colour="Black")
 

##############################################                 
                 
# 18.  - North Symbol and Scale Bar

# ggsn: North Symbols and Scale Bars for Maps Created with 'ggplot2' or 'ggmap'
# Adds north symbols (18 options) and scale bars in kilometers to maps in geographic or metric coordinates created with 'ggplot2' or 'ggmap'.

# Syntax:
#                 
# ggplot(map.df, aes(long, lat, group = group, fill = var)) +
#   geom_polygon() +
#   coord_equal() +
#   geom_path() +
#   north(map.df) + 
#   scalebar(map.df, dist = 5, dd2km = TRUE, model = 'WGS84')
                 
library(ggsn)                 
             
ggplot(ConnachtMap,aes(x=long,y=lat,group=group)) + geom_polygon(fill="white",colour="Black") + north(ConnachtMap) 
ggplot(ConnachtMap,aes(x=long,y=lat,group=group)) + geom_polygon(fill="white",colour="Black") +  scalebar(ConnachtMap, dist = 25, dd2km = TRUE, model = 'WGS84')

# Working!
# Add in some more variations                 

# for later (section 21)                 
p <- ggplot(ConnachtMap,aes(x=long,y=lat,group=group)) + geom_polygon(fill="white",colour="Black") + north(ConnachtMap) 

##############################################
# 19: Create Water Quality

# Artificial Data Set to use in Chloropleth
                 
set.seed(1234);WaterQuality <- USArrests[sample(1:50,26),]

WaterQuality = data.frame(County=countynames,WaterQuality)
rownames(WaterQuality) = 1:26
names(WaterQuality) = c("County","Quality","Taste","Insects","Pollution")

# Working!
# Exercise: Subject to Connacht          
# Call this data set "ConnachtWQ"
                 
#############################################
# 20. Chloropleth
                 
# All Ireland                  
WaterQualityMap <- merge(county.df,WaterQuality,by.x="NAME_1",by.y="County")
# WaterQualityMap <- arrange(WaterQualityMap,group,id)

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Insects)) + geom_polygon()

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Pollution)) + geom_polygon() + geom_path(color="white") + coord_equal() + scale_fill_gradient(name="Percent", limits=c(30,100), low="white", high="red")

# ggplot(ConnachtWQ,aes(x=long,y=lat,group=group,fill=Pollution)) + geom_polygon() + geom_path(color="white") + coord_equal() + scale_fill_gradient(name="Percent", limits=c(30,100), low="white", high="red")
                 
##############################################                 
# 21. Locations of Wells in Connacht                 
# colour by category

# Since every layer inherits the default aes mapping, you need to 
# nullify the shape aes in geom_point when you use different dataset:


p + geom_point(data=Connacht,aes(shape=NULL, x=Connacht$lon,y = Connacht$lat),inherit.aes=FALSE) 

p + geom_point(data=Connacht,aes(shape=NULL, x=Connacht$lon,y = Connacht$lat,colour=factor(WellType)),inherit.aes=FALSE) 

p + geom_point(data=Connacht,aes(shape=NULL, x=Connacht$lon,y = Connacht$lat,colour=factor(WellType)),inherit.aes=FALSE) + scale_colour_manual(values=cbPalette)



# inlcude scale bar and North Arrow
# Wells by Category - points on a map of Connacht
                 
# p + geom_point(aes(colour = factor(WellType)), size = 4) +
#   geom_point(colour = "grey90", size = 1.5)

# p + geom_point(colour = "black", size = 4.5) +
#     geom_point(colour = "pink", size = 4) +
#     geom_point(aes(shape = factor(WellType)))
                 
#######################################
# 22. Pallettes and Themese

# - http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
  scale_fill_manual(values=cbPalette)

# To use for line and point colors, add
  scale_colour_manual(values=cbPalette)

            

#######################################
# Future Projects  
# - geofacetting   (geofacet R package)                 
                 



