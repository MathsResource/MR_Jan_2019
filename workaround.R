myFilenames <- list.files()
numFiles <- length(myFilenames)


for(i in 1:numFiles){
getname <- list.files()[i]

getname <- gsub("Co","",getname)
getname <- gsub(".xls","",getname)



 for (j in 2:4){
 newname <- paste(getname,j,sep="")
 cat("\n")
 cat(newname)

 }

}