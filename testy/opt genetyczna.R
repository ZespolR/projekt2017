library(GA)
fp = ackley

curve(fp, from=-7, to=7)

wyniki.ga = ga(type = "real-valued", fitness = fp, min = -7, max = 7)

fm = function(obj)
{
  curve(fp, -7, 7, main=paste("iteration =", obj@iter))
  points(obj@population, obj@fitness, pch=20, col = "red")
}

wyniki.ga = ga(type = "real-valued", fitness = fp, min = -7, max =7, monitor = fm)

summary(wyniki.ga)