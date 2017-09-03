fcja=function(funkcja){
  psoptim(FUN<-funkcja, n=il.robali[j], max.loop=max.iteracji, w=w, c1=c1, c2=c2,
          xmin=xmin, xmax=xmax, vmax=vmax, seed=runif(1,min=0,max=1000), anim=FALSE)}

library(data.table)
library(xlsx)


funkcje=list(ackley.pso,#[-32,32] min 0 at(0,0)
             cross_in_tray.pso, # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
             drop_wave.pso, # [-5.12,5.12] min -1 at (0,0)
             beale.pso,#[-4.5,4.5] min 0 at (3,0.5)
             eggholder.pso,# [-512,512] min -959 at (512,404)
             holder.table.pso, #x[-10,10] min -19 at (8.05,9.66 i z minusami)
             matyas.pso,# [-10,10] min 0 at (0,0)
             easom.pso,# [-100,100] min -1 at (3.14,3.14)
             rastrigin.pso,# x[-5.12,5.12] min 0 at (0,0)
             schaffer.pso, # [-100,100] min 0 at (0,0)
             six.hump.camel.pso, #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
             three.hump.camel.pso,# [-5,5] min 0 at (0,0)
             levin13.pso# [-10,10] min 0 at (1,1)
)

funkcje.nazwa=list("ackley.pso",#[-32,32] min 0 at(0,0)
                  "cross_in_tray.pso", # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
                   "drop_wave.pso", # [-5.12,5.12] min -1 at (0,0)
                   "beale.pso",#[-4.5,4.5] min 0 at (3,0.5)
                   "eggholder.pso",# [-512,512] min -959 at (512,404)
                   "holder.table.pso", #x[-10,10] min -19 at (8.05,9.66 i z minusami)
                  "matyas.pso",# [-10,10] min 0 at (0,0)
                   "easom.pso",# [-100,100] min -1 at (3.14,3.14)
                  "rastrigin.pso",# x[-5.12,5.12] min 0 at (0,0)
                   "schaffer.pso", # [-100,100] min 0 at (0,0)
                  "six.hump.camel.pso", #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
                   "three.hump.camel.pso",# [-5,5] min 0 at (0,0)
                  "levin13.pso"# [-10,10] min 0 at (1,1)
              
)

zakres=c(32,10,5.12,4.5,512,10,10,100,5.12,100,3,5,10)
min=c(0,-2.06,-1,0,-959,-19,0,-1,0,0,-1.03,0,0)

il.robali <- c(30,60,80,100,150)
max.iteracji <- 100
w <- 0.95
c1 <- 0.2
c2 <- 0.2
vmax <- c(4, 4)

powt = 50


for(k in 1:13) #dla wszystkich funkcji
{
  if(k==11)
  {
    xmin <- c(-3, -2)
    xmax <- c(3, 2)
  }
  else
  {
  xmin <- c(-zakres[k], -zakres[k])
  xmax <- c(zakres[k], zakres[k])
  }
  
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
    
    tabele[[j]] <- data.table(Lp=c(1:powt,"Srednie"),Wielkosc.roju=il.robali[j],Znalezione.x1=x1,Znalezione.x2=x2, Minimum=minimum,MSE.od.minimum=blad.sk,Odchylenie.standardowe=odchylenie[j], Iteracje=iter, Czas=czas,"")
    print(tabele[[j]])
    
    cat("\n\n")
  }
  cat("TABELA SREDNICH Z 1 FUNKCJI", "\n\n")
  tabela.srednich <- data.table(Nr_sredniej=c(1:5),Wielkosc.roju=il.robali,Znalezione.x1=x1.sr,Znalezione.x2=x2.sr, Minimum=minimum.sr,MSE.od.minimum=blad.sk.sr,Odchylenie.standardowe=odchylenie.sr, Iteracje=iter.sr, Czas=czas.sr)
  print(tabela.srednich)
  
  
  write.xlsx(tabele,paste("F:/praca_magisterska/PSO/pso_",funkcje.nazwa[[k]],".xlsx"))
  write.xlsx(tabela.srednich,paste("F:/praca_magisterska/PSO/sr_",funkcje.nazwa[[k]],".xlsx"))
  
  rm(x1,x2,minimum,czas,iter,tabele,blad.sk,x1.sr,x2.sr,minimum.sr,czas.sr,iter.sr,blad.sk.sr,odchylenie.sr)
}