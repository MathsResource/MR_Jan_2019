# Connacht

###########################################################################

Galway2 <- read.csv("Galway2.csv")
Galway3 <- read.csv("Galway3.csv")
Galway4 <- read.csv("Galway4.csv")

WellType <- rep(c("A","B","C"),c(nrow(Galway2) ,nrow(Galway3),nrow(Galway4)))

Galway <- rbind(Galway2,Galway3,Galway4)

Galway <- data.frame(Galway,WellType)

rm(Galway2);rm(Galway3);rm(Galway4);


###########################################################################

Leitrim2 <- read.csv("Leitrim2.csv")
Leitrim3 <- read.csv("Leitrim3.csv")
Leitrim4 <- read.csv("Leitrim4.csv")

WellType <- rep(c("A","B","C"),c(nrow(Leitrim2) ,nrow(Leitrim3),nrow(Leitrim4)))

Leitrim <- rbind(Leitrim2,Leitrim3,Leitrim4)

Leitrim <- data.frame(Leitrim,WellType)

rm(Leitrim2);rm(Leitrim3);rm(Leitrim4);

###########################################################################


Mayo2 <- read.csv("Mayo2.csv")
Mayo3 <- read.csv("Mayo3.csv")
Mayo4 <- read.csv("Mayo4.csv")

WellType <- rep(c("A","B","C"),c(nrow(Mayo2) ,nrow(Mayo3),nrow(Mayo4) ))

Mayo <- rbind(Mayo2,Mayo3,Mayo4)

Mayo <- data.frame(Mayo,WellType)

rm(Mayo2);rm(Mayo3);rm(Mayo4);

###########################################################################

Roscommon2 <- read.csv("Roscommon2.csv")
Roscommon3 <- read.csv("Roscommon3.csv")
Roscommon4 <- read.csv("Roscommon4.csv")

WellType <- rep(c("A","B","C"),c(nrow(Roscommon2) ,nrow(Roscommon3),nrow(Roscommon4)))

Roscommon <- rbind(Roscommon2,Roscommon3,Roscommon4)

Roscommon <- data.frame(Roscommon,WellType)

rm(Roscommon2);rm(Roscommon3);rm(Roscommon4);

###########################################################################
Sligo2 <- read.csv("Sligo2.csv")
Sligo3 <- read.csv("Sligo3.csv")
Sligo4 <- read.csv("Sligo4.csv")

WellType <- rep(c("A","B","C"),c(nrow(Sligo2) ,nrow(Sligo3),nrow(Sligo4)))

Sligo <- rbind(Sligo2,Sligo3,Sligo4)

Sligo <- data.frame(Sligo,WellType)

rm(Sligo2);rm(Sligo3);rm(Sligo4);

###########################################################################

Connacht <- rbind(Mayo,Sligo,Roscommon,Galway,Leitrim)