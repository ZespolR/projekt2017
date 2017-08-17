library(GA)
#zwykle liczenie:

GA <- ga(type = "real-valued",
         fitness = function(x) -ackley.ga(x[1], x[2]),
         min = c(-32, -32), max = c(32, 32),
         popSize = 100, maxiter = 20, run = 100,
         pmutation = ga_pmutation)
plot(GA)
summary(GA)
####################
## 
## zaawansowane liczenie z obrazkami 3d

x1 <- x2 <- seq(-32, 32, by = 0.1)
f <- outer(x1, x2, ackley.ga)

persp3D(x1, x2, f, theta = 50, phi = 20)
filled.contour(x1, x2, f, color.palette = jet.colors)

start.time <- Sys.time()

GA <- ga(type = "real-valued", fitness = function(x) + ackley.ga(x[1], x[2]),
         min = c(-32, -32), max = c(32, 32),
         popSize = 50, maxiter = 100)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

summary(GA)
plot(GA)

