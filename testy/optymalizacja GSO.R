#Algorytm domyœlnie liczy maksimum funkcji wiec trzeba funkcje pomnozyc *-1
funkcja = ackley.gso #przykladowo
zakres <- c(-32,32) # zakres
para <- c(100,50,0.25,0.20,1) #no_firefly,N_iteration,alpha, betamin, gamma

start.time <- Sys.time()

firefly_algo(no_firefly,N_iteration,alpha, betamin, gamma,rng=zakres,FunA=funkcja)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken