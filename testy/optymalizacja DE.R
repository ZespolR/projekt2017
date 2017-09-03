library(DEoptim)
lower <- c(-32, -32)
upper <- -lower
set.seed(runif(1,min=0,max=1000))

ptm <- proc.time() 
czas.stracony =0

outDEoptim <- DEoptim(ackley.de, lower, upper,
                      DEoptim.control(itermax = 100,
                                      storepopfrom = 1, storepopfreq = 2, NP=200,trace=FALSE))
summary(outDEoptim)
#czas
wynikczasu<- proc.time() - ptm
print(wynikczasu)

for(i in 1:99)
{
  plot(outDEoptim$member$storepop[[i]],main="Populacja DE",type = "p",pch=1,col="darkblue",cex=2,xlab="x1", ylab="x2",xlim=range(-32:32),ylim=range(-32:32))
}

plot(outDEoptim$member$bestvalit, type = 'o', col = 'black',xlab="Iteracje", ylab="Wartosc minimum")