
Cavan2 <- read.xlsx("CoCavan.xls",2)
Cavan3 <- read.xlsx("CoCavan.xls",3)
Cavan4 <- read.xlsx("CoCavan.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Cavan2) ,nrow(Cavan3),nrow(Cavan4)))

Cavan <- rbind(Cavan2,Cavan3,Cavan4)

Cavan <- data.frame(Cavan,WellType)

rm(Cavan2);rm(Cavan3);rm(Cavan4);

###########################################################################

Donegal2 <- read.xlsx("CoDonegal.xls",2)
Donegal3 <- read.xlsx("CoDonegal.xls",3)
Donegal4 <- read.xlsx("CoDonegal.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Donegal2) ,nrow(Donegal3),nrow(Donegal4)))

Donegal <- rbind(Donegal2,Donegal3,Donegal4)

Donegal <- data.frame(Donegal,WellType)

rm(Donegal2);rm(Donegal3);rm(Donegal4);

###########################################################################

Monaghan2 <- read.xlsx("CoMonaghan.xls",2)
Monaghan3 <- read.xlsx("CoMonaghan.xls",3)
Monaghan4 <- read.xlsx("CoMonaghan.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Monaghan2) ,nrow(Monaghan3),nrow(Monaghan4)))

Monaghan <- rbind(Monaghan2,Monaghan3,Monaghan4)

Monaghan <- data.frame(Monaghan,WellType)

rm(Monaghan2);rm(Monaghan3);rm(Monaghan4);

###########################################################################

Ulster <- rbind(Cavan,Monaghan,Donegal)