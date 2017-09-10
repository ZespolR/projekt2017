source('C:/Users/Konasz/Desktop/projekt/testy/BAT zrobione funkcje.R')
source('C:/Users/Konasz/Desktop/projekt/testy/DE funkcje.R')
source('C:/Users/Konasz/Desktop/projekt/testy/GA funkcje.R')
source('C:/Users/Konasz/Desktop/projekt/testy/PSO funkcje.R')

print("Wybierz algorytm do optymalizacji wprowadzajac odpowiednia cyfre")
cat("\n")
print("1.BAT-alg.nietoperza")
print("2.DE-alg.ewolucji roznicowej")
print("3.GA-alg.genetyczny")
print("4.PSO-alg.roju czastek")

alg = readline(prompt="Wybor algorytmu: ")

if (alg==1){
  source('C:/Users/Konasz/Desktop/projekt/testy/test BAT.R')
} #BAT

if(alg==2){
  
  source('C:/Users/Konasz/Desktop/projekt/testy/test DE.R')
} #DE

if (alg==3){
  
  source('C:/Users/Konasz/Desktop/projekt/testy/test GA.R')
} #GA

if (alg==4){
  
  source('C:/Users/Konasz/Desktop/projekt/algorytmy optymalizacyjne/PSO(roj czastek).R')
  source('C:/Users/Konasz/Desktop/projekt/testy/test PSO.R')
} #PSO