setwd("/home/lisic/Bureau/fichierR/Rscript")

df<-read.csv2("/home/lisic/Bureau/fichierR/DemandeGlobal .csv")
head(df,5)

df <- df %>% select( FlowSortant,FlowEntrant) 

#centrage reduction des donnée 
df.cr<-scale(df,center=T,scale=T)

#k-means avec les données centrées et réduites
#center = 2 - nombre de groupes demandés
#nstart = 5 - nombre d'essais avec différents individus de départ
#parce que les résultats sont dépendants de l’initialisation
groupes.kmeans <- kmeans(df.cr,centers=2,nstart=5)
#affichage des résultats
print(groupes.kmeans)
#correspondance avec les groupes de la CAH
print(table(groupes.kmeans$cluster))

#(1)évaluer la proportion d'inertie expliquée
inertie.expl <- rep(0,times=10)
for (k in 2:10){
clus <- kmeans(df.cr,centers=k,nstart=5)
inertie.expl[k] <- clus$betweenss/clus$totss
}
#graphique
plot(1:10,inertie.expl,type="b",xlab="Nb. de groupes",ylab="% inertie expliquée")
#(2) indice de Calinski Harabasz - utilisation du package fpc
library(fpc)
#évaluation des solutions
sol.kmeans <- kmeansruns(df.cr,krange=2:10,criterion="ch")
#graphique
plot(1:10,sol.kmeans$crit,type="b",xlab="Nb. de groupes",ylab="Silhouette")

R<-data.frame(df,groupes.kmeans$cluster)
write.csv(R, file = "kmeansk3", row.names = FALSE)

