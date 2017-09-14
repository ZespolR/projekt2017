

library(DEoptim)        #uruchomienie pakietu z wybranym algorytmem
library(data.table)     #uruchomienie pakietu z tabela przechowujaca wyniki w R
library(xlsx)           #pakiet eksportujacy tabele do MS Excel

# funkcje optymalizowane w programie, w nawiasie podane ogranicznia szukanych niewiadomych i szukanego minimum
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

zakres=c(32,4.5,2,500,1.2,512,50,10,10,100,5.12,10,5.12)#wektor ograniczen szukanych niewiadomych i szukanego minimum
min=c(0,0,3,1,0,-959,-400,0,-0.35,-1,0,0,-1) # szukane minima kolejnych funkcji

il.robali <- c(30,60,80,100,150) # liczebnosci rojow

for(k in wybor:wybor)     # optymalizacja funkcji w zaleznosci od wyboru
{
  
    xmin <- -zakres[k] 
    xmax <- zakres[k]
  
  
  x1=c()      # wektory potrzebne do przechowywania wynikow
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
  
  for(j in 1:5) # iteracja dla kazdej z liczebnosci rojow
  {
    x1=0 # zerowanie wynikow
    x2=0
    minimum=0
    czas=0
    iter=0
    blad.sk=0
    odchylenie=0
    
    
    for(i in 1:powt) # ilosc iteracji uzalezniona od liczby powtorzen
      if(i==powt && j==5) # jesli liczebnosc roju wynosi 200 i powtarzana jest ostatnia iteracja to generowane sa wykresy
      {
        lower <- c(xmin, xmin)
        upper <- -lower
        set.seed(runif(1,min=0,max=1000))
        
        ptm = proc.time() 
        czas.stracony =0
        
        outDEoptim = DEoptim(fn=funkcje[[k]], lower, upper,
                             DEoptim.control(itermax = 100,storepopfrom = 1, storepopfreq = 5, NP=il.robali[j],trace=FALSE)) #wywolanie algorytmu DE
        #czas
        wynikczasu<- proc.time() - ptm
        
        for(z in 2:(outDEoptim$optim$iter/5 - 5))
        {
          jpeg(paste("C:/Users/Konasz/Dysk Google/ETI/proj/de_",funkcje.nazwa[k],"_po_optym/",z,".jpg",sep="")) #sciezka pod jaka zapisywany bedzie wykres roju
          
          plot(outDEoptim$member$storepop[[z]],main="Populacja DE",type = "p",pch=1,col="darkblue",cex=2,xlab="x1", ylab="x2",xlim=range(xmin:xmax),ylim=range(xmin:xmax))                    #rysowanie wykresu
          dev.off()
        }
        jpeg(paste("C:/Users/Konasz/Dysk Google/ETI/proj/de_",funkcje.nazwa[k],"_po_optym/wykres.jpg",sep=""))#sciezka do wykresu zaleznosci znalezionego minimum od iteracji
        
        plot(outDEoptim$member$bestvalit, type = 'o', col = 'black',xlab="Iteracje", ylab="Wartosci minimum")    #rysowanie wykresu
        
        dev.off()
        
      }
    
    else{ # opcja bez tworzenia wykresow
      
    {
     
        lower = c(xmin, xmin)
        upper = -lower
      
        set.seed(runif(1,min=0,max=1000)) 
        
        ptm = proc.time() # czas poczatkowy
        
        outDEoptim = DEoptim(fn=funkcje[[k]], lower, upper, # wywolanie algorymu DE
                             DEoptim.control(itermax = 100,storepopfrom = 1, storepopfreq = 5, NP=il.robali[j],trace=FALSE))
        
        wynikczasu= proc.time() - ptm # czas = czas teraz- czas przed wykonaniem DE
    }
      
      x1[i] = outDEoptim$optim$bestmem[1]# znaleziona wspolrzedana x1
      x2[i] = outDEoptim$optim$bestmem[2]# x2
      minimum[i] = outDEoptim$optim$bestval # znalezione minimum funkcji
      czas[i] = wynikczasu[3]            # czas wykonania powtorzenia
      iter[i] = outDEoptim$optim$iter    # ilosc iteracji algorytmu do wyniku
      
      blad.sk[i] = (minimum[i] + min[k])^2#blad sredniokwadratowy
      
    }
    
    odchylenie[j] = sd(minimum)#odchylenie standardowe
    
    x1[powt+1] = mean(x1) #obliczanie srednich z 50 prob 
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
    
    #wprowadzanie danych z wektorow do tabeli w R data table
    tabele[[j]] <- data.table(Lp=c(1:powt,"Srednie"),Wielkosc.roju=il.robali[j],Znalezione.x1=x1,Znalezione.x2=x2, Minimum=minimum,MSE.od.minimum=blad.sk,Odchylenie.standardowe=odchylenie[j], Iteracje=iter, Czas=czas,"")
    print(tabele[[j]]) 
    
    cat("\n\n") 
  }
  cat("TABELA SREDNICH Z 1 FUNKCJI", "\n\n")
  tabela.srednich <- data.table(Nr_sredniej=c(1:5),Wielkosc.roju=il.robali,Znalezione.x1=x1.sr,Znalezione.x2=x2.sr, Minimum=minimum.sr,MSE.od.minimum=blad.sk.sr,Odchylenie.standardowe=odchylenie.sr, Iteracje=iter.sr, Czas=czas.sr)
  # tworzenie tabeli srednich wynikow
  print(tabela.srednich)
  
  write.xlsx(tabele,paste("D:/PSO/DE_",funkcje.nazwa[[k]],".xlsx")) 
  #eksport do Excela
  write.xlsx(tabela.srednich,paste("D:/PSO/sr_de_",funkcje.nazwa[[k]],".xlsx")) 
  
  rm(x1,x2,minimum,czas,iter,tabele,blad.sk,x1.sr,x2.sr,minimum.sr,czas.sr,iter.sr,blad.sk.sr,odchylenie.sr)#usuwa niepotrzebne wektory
}