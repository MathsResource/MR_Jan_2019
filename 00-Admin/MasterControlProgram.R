# Run the Setup Gist

source("https://gist.githubusercontent.com/DragonflyStats/9ecf8db90e1002f937c228fdabd26a0b/raw/97ee5a2bfa4f30eb61fa9a900c1abc724e7bc24a/IRLOGIsetup.R")


########################################

# Load Packages

library(dplyr)
library(tidyr)
library(magrittr)

library(sp)
library(rgdal)

library(ggmap)
library(ggns)
library(ggthemes)

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

# names(Mayo)
# dim(Mayo)
# class(Mayo)
# mode(Mayo)
# summary(Mayo)

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
##################################################
########################################
