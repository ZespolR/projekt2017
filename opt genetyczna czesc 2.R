library(GA)

fp = function(x1,x2)
{
  return((3*x1^2 + x2) * exp(-x1^2-x2^2))
}

x1 = seq(-2, 2, by = .05)
x2 = seq(-2.2, 2.2, by = .05)

z = outer(x1,x2,fp)
persp(x1, x2, z, theta = 30, phi = 30, expand = 0.5, col=7)

image(x1, x2, z, col = terrain.colors(50))
contour(x1, x2, z, add=T, col = "grey50", nlevels = 50)

fm = function(obj)
{
  contour(x1,x2, z, col="darkgray", nlevels=50,
          main = paste("iteration =", obj@iter))
  points(obj@population, pch=20)
}

wyniki = ga(type = "real-valued",
            min = c(-2,-2.2), max = c(2,2.2),
            fitness = function(x) - f.opt(x[1], x[2]),
            monitor = f.mon, popSize =20,
            pcrossover=0.85, pmutation=0.05,
            elitism=5, maxiter = 60, seed = 10)

plot(wyniki.ga)
summary(wyniki.ga)