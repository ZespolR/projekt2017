library(GA)
#zwykle liczenie:

ptm <<- proc.time()
czas.stracony <<-0

GA <- ga(type = "real-valued",
         fitness = function(x) -ackley.ga(x[1], x[2]),
         min = c(-32, -32), max = c(32, 32),
         popSize = 200, maxiter = 100, run = 50,
         pmutation = ga_pmutation, anim = FALSE, maxFitness = 0,funkcje.nazwa = "ackley.ga")

wynikczasu<<-proc.time() - ptm-czas.stracony

plot(GA)
summary(GA)

print(wynikczasu)
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

