ackley=function(funkcja){
  psoptim(FUN<-funkcja, n=il.robali[j], max.loop=max.iteracji, w=w, c1=c1, c2=c2,
        xmin=xmin, xmax=xmax, vmax=vmax, seed=runif(1,min=0,max=1000), anim=FALSE)}

library(data.table)
library(xlsx)

funkcje=list("ackley.pso",
          "beale.pso",
          "goldstein.pso",
          "cross_in_tray.pso",
          "holder.table.pso",
          "bohachevsky.pso",
          "venter.pso",
          "matyas.pso",
          "drop_wave.pso",
          "easom.pso")


il.robali <- c(20,40,70,100)
max.iteracji <- 80
w <- 0.95
c1 <- 0.2
c2 <- 0.2
xmin <- c(-32, -32)
xmax <- c(32, 32)
vmax <- c(4, 4)

powt = 3

x1=c()
x2=c()
minimum=c()
czas=c()
iter=c()
tabele=list()

x1.sr=c()
x2.sr=c()
minimum.sr=c()
czas.sr=c()
iter.sr=c()

for(j in 1:4) #rozne liczebnosci rojow
{
  x1=0
  x2=0
  minimum=0
  czas=0
  iter=0
  
  
for(i in 1:powt) #ilosc powtorzen tej samej funkcji tym samym algorytmem i ta sama liczebnoscia
{
  ackley(ackley.pso)
  
  x1[i] = res$sol[1]
  x2[i] = res$sol[2]
  minimum[i] = res$val* -1
  czas[i] = wynikczasu[3]
  iter[i] = res$loop
  
}
  x1[powt+1] = mean(x1)
  x2[powt+1] = mean(x2)
  minimum[powt+1] = mean(minimum)
  czas[powt+1] = mean(czas)
  iter[powt+1] = mean(iter)
  
  x1.sr[j]=x1[powt+1]
  x2.sr[j]=x2[powt+1]
  minimum.sr[j]=minimum[powt+1]
  czas.sr[j]=czas[powt+1]
  iter.sr[j]=iter[powt+1] 
  
  
  tabele[[j]] <- data.table(Lp=c(1:powt,"Srednie"),Liczebnosc_roju=il.robali[j],Wartosc_x1=x1,Wartosc_x2=x2, Znalezione_minimum=minimum, Iteracje_do_wyniku=iter, Czas_wykonania=czas,"")
  print(tabele[[j]])
  
  cat("\n\n")
}
cat("TABELA SREDNICH Z 1 FUNKCJI", "\n\n")
tabele[[j+1]] <- data.table(Nr_sredniej=c(1:4),Liczebnosc_roju=il.robali,Wartosc_x1=x1.sr,Wartosc_x2=x2.sr, Znalezione_minimum=minimum.sr, Iteracje_do_wyniku=iter.sr, Czas_wykonania=czas.sr)
print(tabele[[j+1]])

write.xlsx(tabele,"C:/users/Konasz/Desktop/projekt/wyniki_eks.xlsx")