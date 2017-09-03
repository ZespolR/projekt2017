source('C:/Users/Konasz/Desktop/projekt/testy/nazwy_do_wykresow_zbiorczych.R')
#PSO


n <- 200
max.loop <- 100
w <- 0.95
c1 <- 0.2
c2 <- 0.2
xmin <- c(-zakres[k], -zakres[k])
xmax <- c(zakres[k], zakres[k])
vmax <- c(4, 4)

psoptim(FUN=funkcje.pso[[k]], n, max.loop, w, c1, c2,
        xmin, xmax, vmax, seed=runif(1,min=0,max=1000),anim=FALSE)

#res$gbest
#######################################################
#BAT
library(microbats)
set.seed(runif(1,min=0,max=1000))  # for reproducive results

fit <- bat_optim(D = 2, NP = 200, N_Gen = 100, A = 0.5, r = 0.5,
                 Qmin = 0, Qmax = 2, Lower = -zakres[k], Upper = zakres[k], FUN = funkcje.bat[[k]], anim=FALSE)

fit
x <- fit$best_solution

#####################################################
library(GA)
#zwykle liczenie:

ptm <<- proc.time()
czas.stracony <<-0

GA <- ga(type = "real-valued",
         fitness = function(x) -funkcje.ga[[k]](x[1], x[2]),
         min = c(-zakres[k], -zakres[k]), max = c(zakres[k], zakres[k]),
         popSize = 200, maxiter = 100, run = 50,
         pmutation = ga_pmutation, anim = FALSE, maxFitness = 0,funkcje.nazwa = "ackley.ga")

wynikczasu<<-proc.time() - ptm-czas.stracony

#fit$fitness
####################################################

library(DEoptim)
lower <- c(-zakres[k], -zakres[k])
upper <- -lower
set.seed(runif(1,min=0,max=1000))

ptm <- proc.time() 
czas.stracony =0

outDEoptim <- DEoptim(funkcje.de[[k]], lower, upper,
                      DEoptim.control(itermax = 100,
                                      storepopfrom = 1, storepopfreq = 2, NP=200,trace=FALSE))

######################################################

plot(res$gbest,type = "o", col="darkblue",  xlab="Iteracje",ylim=c(-1,-0.5), ylab="Znalezione minimum funkcji",lwd=2)
lines(fit$fitness, type = "o", col="darkred",lwd=2)
lines(tank, type = "o", col="darkgreen",lwd=2)
lines(outDEoptim$member$bestvalit, type = 'o', col = "black",lwd=2)
legend('topright', legend=c("PSO", "BAT","GA","DE"),lwd=3,
       col=c("darkblue", "darkred", "darkgreen","black"), lty=1, cex=0.8)

#wprowadz k!!!!!!!!!!!!!!!!!!!!!!!!!!