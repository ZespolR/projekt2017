n <- 200
max.loop <- 100
w <- 0.95
c1 <- 0.2
c2 <- 0.2
xmin <- c(-32, -32)
xmax <- c(32, 32)
vmax <- c(4, 4)

psoptim(FUN=ackley.pso, n, max.loop, w, c1, c2,
        xmin, xmax, vmax, seed=runif(1,min=0,max=1000),anim=TRUE)