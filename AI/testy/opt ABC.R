fun <- goldstein.abc

ans0 <- abc_optim(rep(0,2), fun, lb=-32, ub=32, criter=10)
ans0[c("par", "counts", "value")]

print(wynikczasu)
#end.time <- Sys.time()
#time.taken <- end.time - start.time
#time.taken




