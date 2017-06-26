rm(list=ls())

# Run the Setup Gist

source("https://gist.githubusercontent.com/DragonflyStats/9ecf8db90e1002f937c228fdabd26a0b/raw/97ee5a2bfa4f30eb61fa9a900c1abc724e7bc24a/IRLOGIsetup.R")

########################################
sessionInfo()

# another useful command is "history()"
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

# Working Directories
setwd("C://GSI//IEmapdata")




########################################

# Help Files
# Commenting

# Assume all Data is stored in "C:/GSI"

setwd("C://GSI") 

# If You are using a USB Key replace this with "E:/GSI"

######################################

# Lets check do we have our files

list.files()


######################################

# Part 1: Read in files

# Lets pick county Mayo

install.packages("xlsx")
library(xlsx)

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

########################################

# Part 2: Check the data

# Before we continue, lets get a look at the dimensions of each data set.
# Important for Later

head(Mayo2)
tail(Mayo3)
dim(Mayo4)

# More Useful Commands

class(Mayo2)
mode(Mayo3)
summary(Mayo4)


########################################

# Part 3: Can we combine the three files into one?

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


# Part 4: Retaining the Well Type Information

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

c(nrow(Mayo2) ,c(nrow(Mayo3),c(nrow(Mayo4))

# Can we do this?
# Why would this be useful? 

rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4)))

# Let's Save this as a variable that we can use later

WellType <- rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4)))

length(WellType)

###########################################

# Part 5: combining Data Frames

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

# Part 6: Lets put in the well type data

Mayo <- data.frame(Mayo,WellType)

# Remark: Can change the order to put "WellType" First


                 
                 
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


###########################################

# Part 7: Lets rearrange the variables

# For this exercise, we would need the "dplyr" R Package

library(dplyr)

# The first command that we will use is "glimpse"
# The variable are either "numeric" or "doubles","logical" or "factors"

# There are some variables that are just for comments: "GenComms" and "DrillComms"
# Lets delete these two variables.
# All of them have "Com" in their name.

Connacht <- select(Connacht, -contains("Com") )


############################################

# Part 8: Cross Tabulations and Chi Square Test

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


#########################################
# Part 9: Year of Drilling

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
