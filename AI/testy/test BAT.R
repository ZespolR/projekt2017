  # for reproducive results
#fcja=function(funkcja){
#fit <- bat_optim(D = 2, NP = il.robali[j], N_Gen = 100, A = 0.5, r = 0.5,
           #      Qmin = 0, Qmax = 2, Lower = xmin, Upper = xmax, FUN = funkcja, anim=FALSE,set.seed(runif(1,min=0,max=1000)))}

library(microbats)
library(data.table)
library(xlsx)


funkcje=list(ackley.bat,#[-32,32] min 0 at(0,0)
             beale.bat,#[-4.5,4.5] min 0 at (3,0.5)
             goldstein.bat,# [-2,2] min 3 at (0,-1)
             bartels.conn.bat,# [-500,500] min 1 at (0,0)
             leon.bat,# [-1.2,1.2] min 0 at (1,1)
             eggholder.bat,# [-512,512] min -959 at (512,404)
             venter.bat,# [-50,50] min -400 at (0,0)
             matyas.bat,# [-10,10] min 0 at (0,0)
             zirilli.bat,#[-10,10] min -0.35 at (-1.04,0)
             easom.bat,# [-100,100] min -1 at (3.14,3.14)
             rastrigin.bat,# x[-5.12,5.12] min 0 at (0,0)
             levin13.bat,# [-10,10] min 0 at (1,1)
             drop_wave.bat# [-5.12,5.12] min -1 at (0,0)
             )

funkcje.nazwa=list("ackley.bat",#[-32,32] min 0 at(0,0)
                   "beale.bat",#[-4.5,4.5] min 0 at (3,0.5)
                   "goldstein.bat",# [-2,2] min 3 at (0,-1)
                   "bartels.conn.bat",# [-500,500] min 1 at (0,0)
                   "leon.bat",# [-1.2,1.2] min 0 at (1,1)
                   "eggholder.bat",# [-512,512] min -959 at (512,404)
                   "venter.bat",# [-50,50] min -400 at (0,0)
                   "matyas.bat",# [-10,10] min 0 at (0,0)
                   "zirilli.bat",#[-10,10] min -0.35 at (-1.04,0)
                   "easom.bat",# [-100,100] min -1 at (3.14,3.14)
                   "rastrigin.bat",# x[-5.12,5.12] min 0 at (0,0)
                   "levin13.bat",# [-10,10] min 0 at (1,1)
                   "drop_wave.bat"# [-5.12,5.12] min -1 at (0,0)
                   )

zakres=c(32,4.5,2,500,1.2,512,50,10,10,100,5.12,10,5.12)
min=c(0,0,3,1,0,-959,-400,0,-0.35,-1,0,0,-1)

il.robali <- c(20,40,70,100,200)

for(k in wybor:wybor) #dla wszystkich funkcji
{
  
  xmin <- -zakres[k]
  xmax <- zakres[k]
  
  
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
      set.seed=(runif(1,min=0,max=1000))
      if(i==powt && j==5)
      {
        unlink(paste("wykresy/bat_",funkcje.nazwa[k],"_po_optym/*",sep=""))
        fit <- bat_optim(D = 2, NP = il.robali[j], N_Gen = 100, A = 0.5, r = 0.5,
                         Qmin = 0, Qmax = 2, Lower = xmin, Upper = xmax, FUN = funkcje[[k]], anim=TRUE, funkcje.nazwa=funkcje.nazwa[k])
      }
      
      else{
      fit <- bat_optim(D = 2, NP = il.robali[j], N_Gen = 100, A = 0.5, r = 0.5,
                       Qmin = 0, Qmax = 2, Lower = xmin, Upper = xmax, FUN = funkcje[[k]], anim=FALSE)
      }
      
      x1[i] = fit$best_solution[1]
      x2[i] = fit$best_solution[2]
      minimum[i] = fit$min_fitness ## UWAGA TU W ZALEZNOSCI OD ALGORYTMU -1 ALBO NIE !!!!!!!
      czas[i] = wynikczasu[3]
      iter[i] = fit$iter
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
  
  
  write.xlsx(tabele,paste("wyniki_BAT/",funkcje.nazwa[[k]],".xlsx"))
  write.xlsx(tabela.srednich,paste("wyniki_BAT/sr",funkcje.nazwa[[k]],".xlsx"))
  
  rm(x1,x2,minimum,czas,iter,tabele,blad.sk,x1.sr,x2.sr,minimum.sr,czas.sr,iter.sr,blad.sk.sr,odchylenie.sr)
}