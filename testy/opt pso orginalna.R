
n <- 50
m.l <- 50
w <- 0.95
c1 <- 0.2
c2 <- 0.2
xmin <- c(-32, -32)
xmax <- c(32, 32)
vmax <- c(4, 4)


start.time <- Sys.time()#czas trzeba mierzyc z anim=FALSE

psoptim(FUN=ackleypso, n=n, max.loop=m.l, w=w, c1=c1, c2=c2,
        xmin=xmin, xmax=xmax, vmax=vmax, seed=5)

endtime <- Sys.time()
time.taken <- endtime - start.time
time.taken