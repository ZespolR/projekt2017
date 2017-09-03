# for reproducive results
#fcja=function(funkcja){
#fit <- bat_optim(D = 2, NP = il.robali[j], N_Gen = 100, A = 0.5, r = 0.5,
#      Qmin = 0, Qmax = 2, Lower = xmin, Upper = xmax, FUN = funkcja, anim=FALSE,set.seed(runif(1,min=0,max=1000)))}

library(DEoptim)
library(data.table)
library(xlsx)


funkcje=list(ackley.de,#[-32,32] min 0 at(0,0) 
             #lista- rodzaj pojemnika na dane, potrzebne żeby jak sie wywołuje algorytm de  to żeby nie trzeba było wpisywać nazwy funkcji tylko żeby sie to robiło automatycznie, patrz tam niżej po for(i in 1:powt) w wywoluaniu DE, tam jest funkcje[[k]], czyli kiedy np. k=2 to będzie poszukiwanie min funkjci cross in try
             cross_in_tray.de, # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
             drop_wave.de, # [-5.12,5.12] min -1 at (0,0)
             beale.de,#[-4.5,4.5] min 0 at (3,0.5)
             eggholder.de,# [-512,512] min -959 at (512,404)
             holder.table.de, #x[-10,10] min -19 at (8.05,9.66 i z minusami)
             matyas.de,# [-10,10] min 0 at (0,0)
             easom.de,# [-100,100] min -1 at (3.14,3.14)
             rastrigin.de,# x[-5.12,5.12] min 0 at (0,0)
             schaffer.de, # [-100,100] min 0 at (0,0)
             six.hump.camel.de, #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
             three.hump.camel.de,# [-5,5] min 0 at (0,0)
             levin13.de# [-10,10] min 0 at (1,1) 
)

funkcje.nazwa=list("ackley.de",#[-32,32] min 0 at(0,0)
                   #tutaj jest lista z nazwami, potrzebne do nazywania plików excela , na samym dole. np. jak k=13 to funkcje.nazwa[[k]] będzie oznaczało nazwe"levin13.de"
                   "cross_in_tray.de", # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
                   "drop_wave.de", # [-5.12,5.12] min -1 at (0,0)
                   "beale.de",#[-4.5,4.5] min 0 at (3,0.5)
                   "eggholder.de",# [-512,512] min -959 at (512,404)
                   "holder.table.de", #x[-10,10] min -19 at (8.05,9.66 i z minusami)
                   "matyas.de",# [-10,10] min 0 at (0,0)
                   "easom.de",# [-100,100] min -1 at (3.14,3.14)
                   "rastrigin.de",# x[-5.12,5.12] min 0 at (0,0)
                   "schaffer.de", # [-100,100] min 0 at (0,0)
                   "six.hump.camel.de", #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
                   "three.hump.camel.de",# [-5,5] min 0 at (0,0)
                   "levin13.de"# [-10,10] min 0 at (1,1)
)

zakres=c(32,10,5.12,4.5,512,10,10,100,5.12,100,3,5,10) # wektor czyli pojemnik innego rodzaju zawierający zakres poszukiwania,tak jak np. dla ackley(32,32), teraz jak wpiszemy zakres[3] to wyskoczy 5.12
min=c(0,2.06,1,0,959,19,0,1,0,0,1.03,0,0)# wektor z minimami ktore mają wyjsc chyba nie sa uzywane teraz w programie do niczego

il.robali <- c(30,60,80,100,150) #wektor z il robali

powt = 50 #ile razy ma powtrzyc 

for(k in 1:13) #najpierw k =1, robi caly kod objety tymi klamrami { } kiedy zrobi, zwieksza k o 1 znowu robi i tak az do 13
{
  
  
    xmin <- -zakres[k] # kiedy np. k=3, to -zakres[k] = -5.12 i taka wartosc ma teraz xmin
    xmax <- zakres[k]
  
  
  x1=c()    # wektory potrzebne do trzymania wynikow
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
  
  for(j in 1:5) #jest 5 liczebnosci rojow i dla kazdego beda powtorzenia
  {
    x1=0 # zerowanie czyli usuwanie starych danych z wektorow po kazdej petli
    x2=0
    minimum=0
    czas=0
    iter=0
    blad.sk=0
    odchylenie=0
    
    
    for(i in 1:powt) #powt jest rowne 50 wiec bedzie robic 50 razy od i=1 do i=50
    {
      
      if(k==11) # akurat k=11 to six humpcamel, on ma 2 rozne zakresy, wiec trzeba inaczej postapic z lower iupper jesli k =11 to robi to co jest w klamrach{ }
      {
        lower = c(-3, -2)
        upper = -lower
      }
      else# jesli k nie rowna sie 11 to robi normalnie, to co jest ponizej w klamrach
      {
        lower = c(xmin, xmin)
        upper = -lower
      }
        set.seed(runif(1,min=0,max=1000)) 
        
        ptm = proc.time() # do liczenia czasu, czas poczatkowy
        
        outDEoptim = DEoptim(fn=funkcje[[k]], lower, upper,# to jest wywolanie algorymu DE, tu trzeba zmienic jak bedziesz chcial firefly
                             DEoptim.control(itermax = 100,storepopfrom = 1, storepopfreq = 5, NP=il.robali[j],trace=FALSE))
        #czas
        wynikczasu= proc.time() - ptm#wynik czasu = czas teraz- czas przed wykonaniem DE
        
      
      
      x1[i] = outDEoptim$optim$bestmem[1]# znaleziona wspolrzedana x1, to trzeba znalezc w algorytmie samemu summaryDE podsumowuje ci wszystkie wyniki a zeby dobrac sie do tego konkretnego trzeba kombinowac
      x2[i] = outDEoptim$optim$bestmem[2]# x2
      minimum[i] = outDEoptim$optim$bestval  ## UWAGA TU W ZALEZNOSCI OD ALGORYTMU -1 ALBO NIE !!!!!!! to jest minimum
      czas[i] = wynikczasu[3]
      iter[i] = outDEoptim$optim$iter #iteracje
      #blad sredniokwadratowy
      blad.sk[i] = (minimum[i] + min[k])^2## UWAGA TU W ZALEZNOSCI OD ALGORYTMU + ALBO NIE !!!!!!!
      
    }#koniec petli z i
    #odchylenie standardowe
    odchylenie[j] = sd(minimum)
    
    x1[powt+1] = mean(x1) #obliczanie srednich z 50 prob mean to srednia
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
    print(tabele[[j]]) #wrzucanie danych z wektorow do tabeli w R np. jesli Iteracje=iter to znaczy ze kolumna o nazwie Iteracje bedzie teraz miala dane z wektora iter, print wyswietla ta tabele 
    
    cat("\n\n") #odstep miedzy liniami
  }#koniec petli z j czyli wykona sie 50 powtorzen z i i potem zostanie zmieniony roj na wiekszy 
  cat("TABELA SREDNICH Z 1 FUNKCJI", "\n\n")
  tabela.srednich <- data.table(Nr_sredniej=c(1:5),Wielkosc.roju=il.robali,Znalezione.x1=x1.sr,Znalezione.x2=x2.sr, Minimum=minimum.sr,MSE.od.minimum=blad.sk.sr,Odchylenie.standardowe=odchylenie.sr, Iteracje=iter.sr, Czas=czas.sr)# to samo co wyzej tylko z tabela ze srednimi
  print(tabela.srednich)
  
  write.xlsx(tabele,paste("D:/PSO/DE_",funkcje.nazwa[[k]],".xlsx")) #wrzuca tabele ktore sa "data tablami" o nazwie tabele do excela
  write.xlsx(tabela.srednich,paste("D:/PSO/sr_de_",funkcje.nazwa[[k]],".xlsx")) # tu wrzuca tabele srednich
  
  
  rm(x1,x2,minimum,czas,iter,tabele,blad.sk,x1.sr,x2.sr,minimum.sr,czas.sr,iter.sr,blad.sk.sr,odchylenie.sr)#usuwa niepotrzebne wektory(niekonieczne)
}