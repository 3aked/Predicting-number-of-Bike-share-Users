#install.packages("osrm") 
#install.packages("cartography") 
#install.packages("rgeos") 
#install.packages("OSRM") 
#install.packages("rgdal", repos = "http://cran.us.r-project.org", type = "source")

setwd("/home/lisic/Bureau/calais")


require(osrm)
require(rgeos)
require(cartography)
library(osrm)
library(rgeos)
library(cartography)

df <- read.csv("/home/lisic/Bureau/stations.csv")
colnames(df)<-c("id","nom","x","y","capacité")
head(df)


df.dist <- data.frame(df$id,df[["x"]],df[["y"]])
colnames(df.dist)<-c("name","lat","lon")
head(df.dist)


# création d'une matrice distances routières
m<-osrmTable(df.dist, src = NULL, dst = NULL, gepaf = TRUE)
head(m$duration)

#sauvgarder la matrice 
submit <- data.frame(m$duration)
write.csv(submit, file = "duration.csv")
