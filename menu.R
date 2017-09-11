source('testy/BAT zrobione funkcje.R')
source('testy/DE funkcje.R')
source('testy/GA funkcje.R')
source('testy/PSO funkcje.R')

print("Wybierz algorytm do optymalizacji wprowadzajac odpowiednia cyfre")
cat("\n")
print("1.BAT-alg.nietoperza")
print("2.DE-alg.ewolucji roznicowej")
print("3.GA-alg.genetyczny")
print("4.PSO-alg.roju czastek")

alg = readline(prompt="Wybor algorytmu: ")

if (alg==1){
  source('testy/test BAT.R')
} #BAT

if(alg==2){
  
  source('testy/test DE.R')
} #DE

if (alg==3){
  
  source('testy/test GA.R')
} #GA

if (alg==4){
  
  source('algorytmy optymalizacyjne/PSO(roj czastek).R')
  source('testy/test PSO.R')
} #PSO