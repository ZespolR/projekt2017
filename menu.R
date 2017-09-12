source('testy/BAT zrobione funkcje.R')
source('testy/DE funkcje.R')
source('testy/GA funkcje.R')
source('testy/PSO funkcje.R')
source('testy/wybory.R')


print("Wybierz algorytm do optymalizacji")
print("1.BAT - alg.nietoperza")
print("2.DE - alg.ewolucji roznicowej")
print("3.GA - alg.genetyczny")
print("4.PSO - alg.roju czastek")

#Wywolanie funkcji wyboru algorytmu
algorytmy()

cat("\n")
print("Lista dostepnych funkcji")
print("1. Ackley")
print("2. Beale")
print("3. Goldstein")
print("4. Bartels-Conn")
print("5. Leon")
print("6. Eggholder")
print("7. Venter")
print("8. Matyas")
print("9. Zirilli")
print("10. Easom")
print("11. Rastrigin")
print("12. Levin13")
print("13. Drop Wave")


#Wywolanie funkcji wyboru ilosci powtorzen i funkcji
wybor_funkcji()
powtorzenia()

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