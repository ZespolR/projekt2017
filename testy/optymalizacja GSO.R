#Algorytm domyœlnie liczy maksimum funkcji wiec trzeba funkcje pomnozyc *-1
funkcja = goldstein.gso #przykladowo
zakres <- c(-2,2) # zakres
para <- c(100,20,0.25,0.20,1) #no_firefly,N_iteration,alpha, betamin, gamma

firefly_algo(no_firefly,N_iteration,alpha, betamin, gamma,rng=zakres,FunA=funkcja)

wynikczasu


