
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

###########################################

# Part 7: Lets rearrange the variables

# For this exercise, we would need the "dplyr" R Package

library(dplyr)

# The first command that we will use is "glimpse"
# The variable are either "numeric" or "doubles","logical" or "factors"

# There are some variables that are just for comments: "GenComms" and "DrillComms"
# Lets delete these two variables.
# All of them have "Com" in their name.

Mayo <- select(Mayo, -contains("Com") )


############################################

# Part 8: Cross Tabulations and Chi Square Test

# Simple Tabulation commands

table(Mayo$Type)
table(Mayo$Type,Mayo$WellType)
addmargins(table(Mayo$Type,Mayo$WellType))

# Using Magrittr's pipe operator

Mayo$Type %>% table()
Mayo$Type %>% table(Mayo$WellType)
Mayo$Type %>% table(Mayo$WellType) %>% addmargins

# Chi Square Test for Categorical Variables
# Probably would be better with more data, as the sample size is very small.
# Syntax is ok though

chisq.test(Mayo$Type,Mayo$WellType)

# Using Pipe Operator:
# Mayo$Type %>% chisq.test(Mayo$WellType)


#########################################
# Part 9: Year of Drilling

# For this exercise: we will use the lubridate package

# install.packages("lubridate")
library(lubridate)

summary(Mayo$DrillDate)

ymd(Mayo$DrillDate)

year(Mayo$DrillDate)
month(Mayo$DrillDate)
day(Mayo$DrillDate)

# lets add Drill Year to the data set

Mayo <- mutate(Mayo, DrillYear = year(DrillDate) ) 

# Other Time Periods Are Possible

DrillDecade <- (Mayo$DrillYear %/% 10) * 10
DrillPeriod <- (Mayo$DrillYear %/% 5) * 5

########################################
