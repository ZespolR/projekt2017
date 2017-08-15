quad_func <- function(D, sol) {
  val = 0
  for (i in 1:D) {
    val <- val + sol[i] * sol[i] - sol[i] * 3
  }
  return(val)
}
# lub
ackley.bat = function(D, sol)
{
  a=20 
  b=0.2 
  c=2*pi
  xx = sol
  sum1 <- sum(xx^2)
  sum2 <- sum(cos(c*xx))
  
  term1 <- -a * exp(-b*sqrt(sum1/D))
  term2 <- -exp(sum2/D)
  
  y <- term1 + term2 + a + exp(1)
  return(y)
}

# run a simulation using the standard bat algorithm
set.seed(5)  # for reproducive results

start.time <- Sys.time()
fit <- bat_optim(D = 2, NP = 40, N_Gen = 100, A = 0.5, r = 0.5,
                 Qmin = 0, Qmax = 2, Lower = -32, Upper = 32, FUN = ackley.bat)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

fit
x <- fit$best_solution