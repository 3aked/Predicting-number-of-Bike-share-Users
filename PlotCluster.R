rental <-read.csv("/home/lisic/Bureau/calais/rental_cluster.csv")
return <-read.csv("/home/lisic/Bureau/calais/return_cluster.csv")
 head(rental)
 head(return)
 
 plot(return[["heure"]],return[["g1"]],type="l",col="red",xaxt="n",yaxt="n",main="cluster d'activités de location",xlab="heure de la journée",ylab="% location journalière ")
 lines(return[["heure"]], return[["g2"]],sub=" groupe1 : rouge",sub=" groupe1 : noire" )
axis(1, at = seq(0,23, by = 1), las=2)
axis(2, at = seq(0,max(max(return[["g1"]]),max(return[["g2"]])), by =0.5), las=2)
grid(NA, 18, lwd = 2) # grid only in y-direction

