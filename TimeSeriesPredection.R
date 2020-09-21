#
# Project: Predict Bike Sharing Demand using R
# Author : boubaker ahmed 
# Date   : 2018
#

setwd("/home/lisic/Bureau/Rscript")


#install bib 

#install.packages("stringr", dependencies=TRUE)
#install.packages("dplyr", dependencies = TRUE)
#install.packages("lubridate") 
#install.packages('randomForest')

#include bib
library(stringr)
#library(forecast)
#library(lubridate)
library(dplyr)
library(tibble)
library(tidyr)
library(readr)

table <-read.csv("/home/lisic/Bureau/Rscript/data_brute.csv")
data_0 <-read.csv("/home/lisic/Bureau/Rscript/data_brute.csv") 


#matrices 
m <- matrix ("numeric",nrow = 6, ncol = 6)
#vector contenant les station 
stationId = vector( "numeric", length =6)
stationId <- c(2017,3002,2023,2022,2021,2012)

for(i in 1:6) 
{
for (j in 1:6) 
{
#select.list
table <- data_0 %>% filter( data_0$X20 == 0,data_0$X2017 == stationId[i],data_0$X3002 == stationId[j]) 
table <- table %>% select(X0)
table 

#convertire en liste times series 
timeseries <- ts(table)
#extraire la format de predection  
fileforecasts <- stats:: HoltWinters(timeseries, beta=FALSE, gamma=FALSE)
#extraire la predection 
p = predict(fileforecasts)
#ajouter à la matrice 
m[i,j] <- ceiling(p)  
j
}
}
submit <- data.frame(m)
names(submit)<-c("1","2","3","4","5","6")

for(h in 1:23)
{
for(i in 1:6) 
{
for (j in 1:6) 
{
#select.list
table <- data_0 %>% filter( data_0$X20 == h,data_0$X2017 == stationId[i],data_0$X3002 == stationId[j]) 
table <- table %>% select(X0)
table 

#convertire en liste times series 
timeseries <- ts(table)
#extraire la format de predection  
fileforecasts <- stats:: HoltWinters(timeseries, beta=FALSE, gamma=FALSE)
#extraire la predection 
p = predict(fileforecasts)
#ajouter à la matrice 
m[i,j] <- ceiling(p)  

}
}
#engregistrer les outputs
submitt <- data.frame(m)
names(submitt)<-c("1","2","3","4","5","6")
submit <- rbind(submit,submitt)
}
write.csv(submit, file = "6station.csv", row.names = FALSE)
submit
