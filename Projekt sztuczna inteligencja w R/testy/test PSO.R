fcja=function(funkcja){
  psoptim(FUN<-funkcja, n=il.robali[j], max.loop=max.iteracji, w=w, c1=c1, c2=c2,
        xmin=xmin, xmax=xmax, vmax=vmax, seed=runif(1,min=0,max=1000), anim=FALSE,nazwa=funkcje.nazwa[[k]])}

fcja2=function(funkcja){
  psoptim(FUN<-funkcja, n=il.robali[j], max.loop=max.iteracji, w=w, c1=c1, c2=c2,
          xmin=xmin, xmax=xmax, vmax=vmax, seed=runif(1,min=0,max=1000), anim=TRUE,nazwa=funkcje.nazwa[[k]])}

library(data.table)
library(xlsx)


funkcje=list(ackley.pso,#[-32,32] min 0 at(0,0)
          beale.pso,#[-4.5,4.5] min 0 at (3,0.5)
          goldstein.pso,# [-2,2] min 3 at (0,-1)
          bartels.conn.pso,# [-500,500] min 1 at (0,0)
          leon.pso,# [-1.2,1.2] min 0 at (1,1)
          eggholder.pso,# [-512,512] min -959 at (512,404)
          venter.pso,# [-50,50] min -400 at (0,0)
          matyas.pso,# [-10,10] min 0 at (0,0)
          zirilli.pso,#[-10,10] min -0.35 at (-1.04,0)
          easom.pso,# [-100,100] min -1 at (3.14,3.14)
          rastrigin.pso,# x[-5.12,5.12] min 0 at (0,0)
          levin13.pso,# [-10,10] min 0 at (1,1)
          drop_wave.pso# [-5.12,5.12] min -1 at (0,0)
          )

funkcje.nazwa=list("ackley.pso",#[-32,32] min 0 at(0,0)
             "beale.pso",#[-4.5,4.5] min 0 at (3,0.5)
             "goldstein.pso",# [-2,2] min 3 at (0,-1)
             "bartels.conn.pso",# [-500,500] min 1 at (0,0)
             "leon.pso",# [-1.2,1.2] min 0 at (1,1)
             "eggholder.pso",# [-512,512] min -959 at (512,404)
             "venter.pso",# [-50,50] min -400 at (0,0)
             "matyas.pso",# [-10,10] min 0 at (0,0)
             "zirilli.pso",#[-10,10] min -0.35 at (-1.04,0)
             "easom.pso",# [-100,100] min -1 at (3.14,3.14)
             "rastrigin.pso",# x[-5.12,5.12] min 0 at (0,0)
             "levin13.pso",# [-10,10] min 0 at (1,1)
             "drop_wave.pso"# [-5.12,5.12] min -1 at (0,0)
             )

zakres=c(32,4.5,2,500,1.2,512,50,10,10,100,5.12,10,5.12)
min=c(0,0,3,1,0,-959,-400,0,-0.35,-1,0,0,-1)

il.robali <- c(20,40,70,100,200)
max.iteracji <- 100
w <- 0.95
c1 <- 0.2
c2 <- 0.2
vmax <- c(4, 4)

for(k in wybor:wybor) #dla wszystkich funkcji
{
  
xmin <- c(-zakres[k], -zakres[k])
xmax <- c(zakres[k], zakres[k])


x1=c()
x2=c()
minimum=c()
czas=c()
iter=c()
tabele=list()
blad.sk=c()
odchlenie=c()

x1.sr=c()
x2.sr=c()
minimum.sr=c()
czas.sr=c()
iter.sr=c()
blad.sk.sr=c()
odchylenie.sr=c()

for(j in 1:5) #rozne liczebnosci rojow
{
  x1=0
  x2=0
  minimum=0
  czas=0
  iter=0
  blad.sk=0
  odchylenie=0
  
  
for(i in 1:powt) #ilosc powtorzen tej samej funkcji tym samym algorytmem i ta sama liczebnoscia
{
  if(i == powt && j == 5)
  {
    unlink(paste("wykresy/pso_",funkcje.nazwa[k],"_po_optym/*",sep=""))
    fcja2(funkcje[[k]])
  }
  
  else
    fcja(funkcje[[k]])
  
  x1[i] = res$sol[1]
  x2[i] = res$sol[2]
  minimum[i] = res$val* -1 ## UWAGA TU W ZALEZNOSCI OD ALGORYTMU -1 ALBO NIE !!!!!!!
  czas[i] = wynikczasu[3]
  iter[i] = res$loop
  #blad sredniokwadratowy
  blad.sk[i] = (minimum[i]-min[k])^2
  
}
  #odchylenie standardowe
  odchylenie[j] = sd(minimum)
  
  x1[powt+1] = mean(x1)
  x2[powt+1] = mean(x2)
  minimum[powt+1] = mean(minimum)
  czas[powt+1] = mean(czas)
  iter[powt+1] = mean(iter)
  blad.sk[powt+1] = mean(blad.sk)
  
  x1.sr[j]=x1[powt+1]
  x2.sr[j]=x2[powt+1]
  minimum.sr[j]=minimum[powt+1]
  czas.sr[j]=czas[powt+1]
  iter.sr[j]=iter[powt+1] 
  blad.sk.sr[j]=blad.sk[powt+1]
  
  odchylenie.sr[j]=odchylenie[j]
  
  tabele[[j]] <- data.table(Lp=c(1:powt,"Srednie"),Liczebnosc_roju=il.robali[j],Wartosc_x1=x1,Wartosc_x2=x2, Znalezione_minimum=minimum,MSE_minimum=blad.sk,Odchylenie_standardowe=odchylenie[j], Iteracje_do_wyniku=iter, Czas_wykonania=czas,"")
  print(tabele[[j]])
  
  cat("\n\n")
}
cat("TABELA SREDNICH Z 1 FUNKCJI", "\n\n")
tabela.srednich <- data.table(Nr_sredniej=c(1:5),Liczebnosc_roju=il.robali,Wartosc_x1=x1.sr,Wartosc_x2=x2.sr, Znalezione_minimum=minimum.sr,MSE_minimum=blad.sk.sr,Odchylenie_standardowe=odchylenie.sr, Iteracje_do_wyniku=iter.sr, Czas_wykonania=czas.sr)
print(tabela.srednich)


write.xlsx(tabele,paste("wyniki_PSO/",funkcje.nazwa[[k]],".xlsx"))
write.xlsx(tabela.srednich,paste("wyniki_PSO/sr",funkcje.nazwa[[k]],".xlsx"))

rm(x1,x2,minimum,czas,iter,tabele,blad.sk,x1.sr,x2.sr,minimum.sr,czas.sr,iter.sr,blad.sk.sr,odchylenie.sr)
}