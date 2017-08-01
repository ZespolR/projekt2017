ackley.de = function(x) #[-32.786,32.768] min 0
{
  x1 <- x[1]
  x2 <- x[2]
  a =-20*exp(-0.2*sqrt(0.5*(x1^2+x2^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2))) + exp(1) + 20
  return(a)
}  

lower <- c(-32, -32)
upper <- -lower
set.seed(1234)
outDEoptim <- DEoptim(ackley.de, lower, upper)
## print output information
summary(outDEoptim)
## plot the best members
plot(outDEoptim, type = 'b')
## plot the best values
dev.new()
plot(outDEoptim, plot.type = "bestvalit", type = 'b', col = 'blue')
## rerun the optimization, and store intermediate populations

start.time <- Sys.time()
#czas
outDEoptim <- DEoptim(ackley.de, lower, upper,
                      DEoptim.control(itermax = 500,
                                      storepopfrom = 1, storepopfreq = 2))
summary(outDEoptim)
#czas
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
## plot intermediate populations
dev.new()
plot(outDEoptim, plot.type = "storepop")

