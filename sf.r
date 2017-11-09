# - 

###########################################

# install.packages('sf')


library(sf)

###########################################

# Using "geom_sf" ---- 
# Need to install Rtools

# Development Version of ggplot2
# Tricky to install
#
# Easiest way (for me) is just to re-install R from scratch
# -  I do this frequently anyway

# install.packages("devtools")
# library(devtools)
# devtools::install_github("tidyverse/ggplot2")
# require(ggplot2)

##########################################

# "ls()" and "objects()" return a vector of character strings giving 
# the names of the objects in the specified environment. 

library(ggplot2)

ls("package:ggplot2")[1:50]
ls("package:ggplot2")[125]
##########################################


# Tidyverse Packages 
# - can load all of them with "library(tidyverse)"
# - We wont in this instance. 

library(dplyr)
library(tidyr)
library(magrittr)

#########################################

# GIS packages

# Using maptools 
# found it easiest to install rgeos, and ensure that it was attached prior to attaching maptools

library(ggplot2)
library(rgeos)
library(maptools)

library(rgdal)
library(sp)
library(plyr)
library(maps)
library(mapproj)

##########################################

# Other packages

# Data Viz Packages
library(ggplot2)
library(ggmap)
library(ggns)
library(ggthemes)

# Some other useful packages
library(scales)
library(reshape2)
library(RColorBrewer)
library(viridis)

##########################################

# North Carolina dataset and shapefile. 
# installed with "rgdal" package.

# Description of the dataset, see vignette in package spdep:
# https://cran.r-project.org/web/packages/spdep/vignettes/sids.pdf

nc <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)

# limit to first 2 counties
nc <- nc[1:2,]



#######################################

# "sf" objects 
# -  The resulting sf object is essentially just a data.frame with 
# -  an extra column for the spatial information.

class(nc)

glimpse(nc)

as_tibble(nc)

# The good thing about this is that everyone knows how to work with data frames in R, 
# so these sf objects are easy to inspect and play around with. 
# Furthermore, this keeps the geometry and attribute data together in one place, 
# i.e. they’re in the same row of the data frame. 

#######################################

# Contrast this to sp, which stores these data in an S4 object of class 
# "SpatialPolygonsDataFrame" 

# convert to SpatialPolygonsDataFrame

nc_sp <- as(nc, "Spatial")

class(nc_sp)

str(nc_sp)

##########################################

# Traditional Import Method : readOGR()

filename = system.file("shape/nc.shp", package = "sf")

nc0 = readOGR(filename)

nc0

# Messy Looking!
# No Idea what is going on!

rm(nc0)  #  get rid of it

###########################################

# Irish County Data

setwd("~/SF/IRL_adm/")

county = readOGR(dsn=".", layer="IRL_adm1")

county@data$id = rownames(county@data)
county.points <- fortify(county, region='id')
county.df = join(county.points, county@data, by="id")

# READY

# This is useful also

countynames=sort(unique(county$NAME_1))

setwd("~/SF")



##########################################

# North Carolina dataset and shapefile 
# - installed with "sf" package
# - Lets go into more detail

filename = system.file("shape/nc.shp", package = "sf")
nc = read_sf(filename)

class(nc)

print(nc, n = 3)

dim(nc)

glimpse(nc)

nc$geometry

class(nc$geometry)

# [1] "sfc_MULTIPOLYGON" "sfc" 
# plot(nc)

##########################################

# Geometries

# The geometry list-column of an sf object is an object of class sfc 
# and an additional class corresponding to the geometry type, in this case sfc_MULTIPOLYGON.
# It can be accessed with st_geometry(). Additional information about the features, such
# as the coordinate reference system, is stored as attributes:

(nc_geom <- st_geometry(nc))

st_geometry(nc) %>% class()

attributes(nc_geom)

##########################################

# library(ggplot2)

# Make a Chloropleth

ggplot(nc) + geom_sf(aes(fill = SID79))

# What did we just do?

##########################################

# Something a bit more advanced
# Using more "ggplot2" funtionality

ggplot(nc) +
  geom_sf(aes(fill = AREA)) +
  scale_fill_viridis("Area") +
  ggtitle("Area of counties in North Carolina") +
  theme_bw()

##########################################

# multiple plot with facet_grid:

# Add in a row id column

nc$row = 1:100

nc.g <- nc %>% select(SID74, SID79, row) %>% gather(VAR, SID, -row, -geometry)

ggplot(nc.g) + geom_sf(aes(fill = SID)) + facet_grid(. ~ VAR)

ggplot(nc.g) + geom_sf(aes(fill = SID)) + facet_grid(VAR ~ .)

############################################

# coord_sf
# Albers equal area projection.

ggplot(nc) +
  geom_sf(aes(fill = AREA)) +
  scale_fill_viridis("Area") +
  coord_sf(crs = st_crs(102003)) +
  ggtitle("Area of counties in North Carolina (Albers)") +
  theme_bw()



###########################################

# Lets *try* this for Irish admin data


filename = system.file("~/SF/IRL_adm/IRL_adm1.shp", package = "sf")

ie = read_sf(filename)

# Did we mess up the filename?

file.exists("~/SF/IRL_adm/IRL_adm1.shp")

# Try again

county<- st_read(system.file("~/SF/IRL_adm/IRL_adm1.shp", package="sf"), quiet = TRUE)

# Still Doesnt Work Yet

# Still a few bugs to be worked out


# In the mean time : st_as_sf
# Convert Foreign Object To An Sf Object

county_sf <- sf::st_as_sf(county)

ggplot(county_sf) +
  geom_sf()

# Well that works!!!
###########################################

# Computing Polygon Areas
# Ashe County
# CRSs are American

(a1 = st_area(nc[1,]))                      # area, using geosphere::areaPolygon
(a2 = st_area(st_transform(nc[1,], 32119))) # NC state plane, m
(a3 = st_area(st_transform(nc[1,], 2264)))  # NC state plane, US foot

units::set_units(a1, km^2)
units::set_units(a2, km^2)
units::set_units(a3, km^2)

##########################################

# How big is country Westmeath?

# EPSG:2157. IRENET95 / Irish Transverse Mercator 
# EPSG:2264. NAD83 / North Carolina

(county1 = st_area(county_sf[24,]))                      # area, using geosphere::areaPolygon
(county2 = st_area(st_transform(county_sf[24,], 2157)))  # county_sf ITM
(county3 = st_area(st_transform(county_sf[24,], 2264)))  # county_sf state plane, US foot

units::set_units(county1, km^2)
units::set_units(county2, km^2)
units::set_units(county3, km^2)


##########################################

# Using dplyr

nc %>% 
  
  mutate(area_km2 = AREA * 10000) %>%   # calulate area in km^2
                                        # select desired columns, 
                                        # note geometry column not explicitly selected
  select(name = NAME, area_km2) %>% 
  filter(area_km2 > 2000) %>%           # filter to counties over 1,000 km^2
  arrange(desc(area_km2)) %>%           # arrange in descending order of area
  slice(1:3)                            # select first three rows

##########################################

# transmute drops all variables other than the new one

nc %>%   
  transmute(area_km2 = AREA * 10000) %>%    # calulate area in km^2
  rename(geom = geometry) %>%               # rename the geometry column
  names()


nc %>% 
  mutate(area_m2 = st_area(geometry)) %>% 
  select(name = NAME, area_m2, area = AREA) %>% 
  head() %>% 
  as_tibble()

###############################################

# Group Operations

# add an arbitrary grouping variable
nc_groups <- nc %>% 
  mutate(group = sample(LETTERS[1:3], nrow(.), replace = TRUE))

# average area by group
nc_mean_area <- nc_groups %>% 
  group_by(group) %>% 
  summarise(area_mean = mean(AREA))

# plot
ggplot(nc_mean_area) +
  geom_sf(aes(fill = area_mean)) +
  scale_fill_distiller("Area", palette = "Greens") +
  ggtitle("Mean area by group") +
  theme_bw()


##############################################

set.seed(1234);WaterQuality <- USArrests[sample(1:50,26),]

WaterQuality = data.frame(County=countynames,WaterQuality)
rownames(WaterQuality) = 1:26
names(WaterQuality) = c("County","Quality","Taste","Insects","Pollution")

#############################################

WaterQualityMap <- merge(county.df,WaterQuality,by.x="NAME_1",by.y="County")

# WaterQualityMap <- arrange(WaterQualityMap,group,id)

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Taste)) + geom_polygon()

ggplot(WaterQualityMap,aes(x=long,y=lat,group=group,fill=Taste)) + geom_polygon() + geom_path(color="white") + coord_equal() + scale_fill_gradient(name="Percent", limits=c(30,100), low="white", high="red")

############################################


WaterQualityMap2 <- merge(county_sf,WaterQuality,by.x="NAME_1",by.y="County")
# WaterQualityMap2 <- arrange(WaterQualityMap2,group,id)

ggplot(WaterQualityMap2) +
  geom_sf(aes(fill = Taste)) 

ggplot(WaterQualityMap2) +
  geom_sf(aes(fill = Taste)) + coord_sf() + scale_fill_gradient(name="Percent", limits=c(30,100), low="white", high="red")


############################################
# MAYBE COVER THIS
# Web Scraping
# scraping some county-level population data from Wikipedia.
# This stuff is VERY tricky

library(rvest) 
pop <- "https://en.wikipedia.org/wiki/List_of_counties_in_North_Carolina" %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/table[2]') %>% 
  html_table() %>% 
  `[[`(1) %>% 
  select(County, starts_with("Population")) %>% 
  set_names(c("county", "population")) %>% 
  mutate(county = gsub(" County", "", county),
         population = gsub("(^[0-9]*)|,", "", population) %>% parse_integer())

# Now we’ll join this population data to our spatial data and plot it.

nc %>% 
  transmute(county = as.character(NAME)) %>% 
  inner_join(pop, by = "county") %>%
  ggplot() +
    geom_sf(aes(fill = population)) +
    scale_fill_viridis("Population", labels = scales::comma) +
    ggtitle("County-level population in North Carolina") +
    theme_bw()

###########################################

# Simple Geometries

(pt = st_point(c(2,4)))

(pt_bin = st_as_binary(pt))

st_as_sfc(list(pt_bin))[[1]]

st_dimension(pt)

st_intersects(pt, pt, sparse = FALSE)



###########################################
# Co-ordinate Reference Systems

# https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf

st_crs("+proj=longlat +datum=WGS84")  # "Proj.4 string"
st_crs(3857)                          # EPSG code
st_crs(3857)$units                    # reveal units
st_crs(NA)                            # unknown (assumed planar/Cartesian)

st_crs(28992)


###########################################

# Geometric Set Operations

nc1 = nc[1:5,]
st_intersects(nc1, nc1)
st_intersects(nc1, nc1, sparse = FALSE)


###########################################

# package `sf` uses simple R structures to store geometries:

str(pt)
str(st_linestring(rbind(c(0,0), c(0,1), c(1,1))))
str(st_polygon(list(rbind(c(0,0), c(0,1), c(1,1), c(0,0)))))

###########################################

# Warning Messages

opar = par(mfrow = c(1,2))
ncg = st_geometry(nc[1:3,])
plot(ncg, col = sf.colors(3, categorical = TRUE))
u = st_union(ncg)
plot(u, lwd = 2)
plot(st_intersection(ncg[1], ncg[2]), col = 'red', add = TRUE)
plot(st_buffer(u, 10000), border = 'blue', add = TRUE)
# st_buffer(u, units::set_unit(10, km)) # with sf devel
plot(st_buffer(u, -5000), border = 'green', add = TRUE)
par(opar)

##########################################

g = st_make_grid(nc, n = c(20,10))
a1 = st_interpolate_aw(nc["BIR74"], g, extensive = FALSE)
sum(a1$BIR74) / sum(nc$BIR74) # not close to one: property is assumed spatially intensive
a2 = st_interpolate_aw(nc["BIR74"], g, extensive = TRUE)
sum(a2$BIR74) / sum(nc$BIR74)
#a1$intensive = a1$BIR74
#a1$extensive = a2$BIR74
#plot(a1[c("intensive", "extensive")])
a1$what = "intensive"
a2$what = "extensive"

###########################################

library(ggplot2)
l = st_cast(nc, "LINESTRING")
ggplot() + geom_sf(data = rbind(a1,a2), aes(fill = BIR74)) + 
	geom_sf(data = l, col = 'lightgray')    
    + facet_grid(what~.) +
    scale_fill_gradientn(colors = sf.colors(10))
