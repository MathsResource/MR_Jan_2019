
# Connacht

###########################################################################

Galway2 <- read.xlsx("CoGalway.xls",2)
Galway3 <- read.xlsx("CoGalway.xls",3)
Galway4 <- read.xlsx("CoGalway.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Galway2) ,nrow(Galway3),nrow(Galway4)))

Galway <- rbind(Galway2,Galway3,Galway4)

Galway <- data.frame(Galway,WellType)

rm(Galway2);rm(Galway3);rm(Galway4);


###########################################################################

Leitrim2 <- read.xlsx("CoLeitrim.xls",2)
Leitrim3 <- read.xlsx("CoLeitrim.xls",3)
Leitrim4 <- read.xlsx("CoLeitrim.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Leitrim2) ,nrow(Leitrim3),nrow(Leitrim4)))

Leitrim <- rbind(Leitrim2,Leitrim3,Leitrim4)

Leitrim <- data.frame(Leitrim,WellType)

rm(Leitrim2);rm(Leitrim3);rm(Leitrim4);

###########################################################################


Mayo2 <- read.xlsx("CoMayo.xls",2)
Mayo3 <- read.xlsx("CoMayo.xls",3)
Mayo4 <- read.xlsx("CoMayo.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4)))

Mayo <- rbind(Mayo2,Mayo3,Mayo4)

Mayo <- data.frame(Mayo,WellType)

rm(Mayo2);rm(Mayo3);rm(Mayo4);

###########################################################################

Roscommon2 <- read.xlsx("CoRoscommon.xls",2)
Roscommon3 <- read.xlsx("CoRoscommon.xls",3)
Roscommon4 <- read.xlsx("CoRoscommon.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Roscommon2) ,nrow(Roscommon3),nrow(Roscommon4)))

Roscommon <- rbind(Roscommon2,Roscommon3,Roscommon4)

Roscommon <- data.frame(Roscommon,WellType)

rm(Roscommon2);rm(Roscommon3);rm(Roscommon4);

###########################################################################
Sligo2 <- read.xlsx("CoSligo.xls",2)
Sligo3 <- read.xlsx("CoSligo.xls",3)
Sligo4 <- read.xlsx("CoSligo.xls",4)

WellType <- rep(c("A","B","C"),c(nrow(Sligo2) ,nrow(Sligo3),nrow(Sligo4)))

Sligo <- rbind(Sligo2,Sligo3,Sligo4)

Sligo <- data.frame(Sligo,WellType)

rm(Sligo2);rm(Sligo3);rm(Sligo4);

###########################################################################

Connacht <- rbind(Mayo,Sligo,Roscommon,Galway,Leitrim)
