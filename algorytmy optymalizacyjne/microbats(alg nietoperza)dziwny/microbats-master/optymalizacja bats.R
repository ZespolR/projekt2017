
set.seed(runif(1,min=0,max=1000))  # for reproducive results

fit <- bat_optim(D = 2, NP = 200, N_Gen = 100, A = 0.5, r = 0.5,
                 Qmin = 0, Qmax = 2, Lower = -32, Upper = 32, FUN = ackley.bat, anim=FALSE)

fit
x <- fit$best_solution
print(wynikczasu)