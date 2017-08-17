
set.seed(5)  # for reproducive results

start.time <- Sys.time()
fit <- bat_optim(D = 2, NP = 40, N_Gen = 100, A = 0.5, r = 0.5,
                 Qmin = 0, Qmax = 2, Lower = -32, Upper = 32, FUN = ackley.bat)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

fit
x <- fit$best_solution
time.taken <- end.time - start.time
time.taken