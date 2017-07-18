library(psoptim)
n = 50
l.iter = 250
bezwl = .5
wsp.c1 = 1.49
wsp.c2 = 1.49
zmienne.min  = c(-5.12, -5.12)
zmienne.max = c(5.12, 5.12)
ogr.predkosci = c(5,5)

g = function(x)
{
  -(20 + x[,1]^2 + x[,2]^2
    -10*(cos(2 * pi*x[,1])+cos(2*pi*x[,2])))
}

wyn = psoptim(FUN=g, n = n, max.loop=l.iter, w=bezwl,
              c1=wsp.c1, c2=wsp.c2,xmin=zmienne.min, 
              xmax=zmienne.max, vmax=ogr.predkosci, seed=5)