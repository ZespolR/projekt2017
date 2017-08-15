library(psoptim)
n <- 50
m.l <- 50
w <- 0.95
c1 <- 0.2
c2 <- 0.2
xmin <- c(-5.12, -5.12)
xmax <- c(5.12, 5.12)
vmax <- c(4, 4)


g = function(x)
{
  -(20 + x[,1]^2 + x[,2]^2
    -10*(cos(2 * pi*x[,1])+cos(2*pi*x[,2])))
}

wyn = psoptim(FUN=g, n = n, max.loop=l.iter, w=bezwl,
              c1=wsp.c1, c2=wsp.c2,xmin=zmienne.min, 
              xmax=zmienne.max, vmax=ogr.predkosci, seed=5, anim = FALSE)