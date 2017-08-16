fun <- ackley.abc

start.time <- Sys.time()

ans0 <- abc_optim(rep(0,2), fun, lb=-32, ub=32, criter=10)
ans0[c("par", "counts", "value")]

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

# 2 raz to samo??
#ans1 <- abc_cpp(rep(0,2), fun, lb=-32, ub=32, criter=50)
#ans1[c("par", "counts", "value")] 
# 



