
lower <- c(-32, -32)
upper <- -lower
set.seed(1234)


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
plot(outDEoptim, type = 'p')
## plot the best values
dev.new()
plot(outDEoptim, plot.type = "bestvalit", type = 'b', col = 'blue')
dev.new()
plot(outDEoptim, plot.type = "storepop")

