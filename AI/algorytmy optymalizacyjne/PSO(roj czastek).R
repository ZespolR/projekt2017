psoptim <- function(FUN, n=100, max.loop=100, w=.9, c1=.2, c2=.2, xmin, xmax, vmax=c(4,4), seed=10, anim=TRUE,nazwa)
{
  ptm <- proc.time()
  czas.stracony =0
  #czas trzeba mierzyc z anim=FALSE
  #FUN - nazwa optymalizowanej funkcji, funkcja musi byc jednoargumentowa
  #co oznacza ze argumentem jest wektor
  
  # n - liczba czastek w roju
  
  # max.loop - maksymalna liczba iteracji
  
  # w - wspolczynnik bezwladnosci
  
  # c1 - wspolczynnik wlasnego "zaufania" 
  
  # c2 - wspolczynnik "zaufania" do roju
  
  # xmin - wektor okreslajacy dolne ograniczenia wartosci zmiennych
  
  # xmax - wektor okreslajacy gorne ograniczenia wartosci zmiennych
  
  # vmax - wektor ograniczen predkosci w kazdym kierunku
  
  # seed - liczba naturalna okreslajaca tzw. ziarno dla generatora liczb
  #pseudolosowych argument stosowany w celu uzyskania powtarzalnosci otrzymywanych wynikow
  
  # anim - wartosc logiczna, jesli prawda TRUE(wartosc domyslna), to animacja przebiegu
  # optymalizajci jest wlaczona
  
  g1 <- function(x,y)
  { 
    FUN(cbind(x,y))
  }
  
  d <- length(xmin)
  
  
  set.seed(seed)
  
  x <- matrix(nrow=n, ncol=d)
  for(i in 1:d)
    x[,i] <- runif(n, xmin[1],xmax[1])
  
  
  wart.f <- FUN(x)
  x.best.czastki <- x
  x.best.roju <- matrix(x[which.max(wart.f),], ncol=d)
  
  
  if((d == 2) && anim)
  {
    x_image <- matrix(c(seq(from=xmin[1],to=xmax[1],length.out=100),seq(from=xmin[2],to=xmax[2],length.out=100)), ncol=2)
    z <- outer(x_image[,1], x_image[,2], g1)
   jpeg(paste("wykresy/pso_",nazwa,"_po_optym/0.jpg",sep=""))
    image(x_image[,1], x_image[,2], z, xlab="x1", ylab="x2", main="Rój pocz¹tkowy")
    contour(x_image[,1], x_image[,2], z, nlevels=10, add=TRUE, col="grey50")
    points(x[,1], x[,2], pch=19, col="darkslateblue")
   dev.off()
  }      
  
  
  
  
  v <- matrix(runif(n*d, min=-vmax, max=vmax), ncol=d, nrow=n)
  
  g.mean <- c()
  g.best <- c()
  
  loop <- 1
  starex=0
  licznik=1
  #somePDFPath <- paste("C:/Users/Konasz/Desktop/projekt/wykresy.pdf")
  #pdf(file=somePDFPath) 
  
  while(loop <= max.loop)
  {
    wart.f <- FUN(x)
    g.mean <- rbind(g.mean, mean(wart.f))
    
    idx <- which(wart.f > FUN(x.best.czastki))
    x.best.czastki[idx,] <- x[idx,]
    
    x.best.roju.nowe <- matrix(x[which.max(FUN(x.best.czastki)),],ncol=d)
    if(FUN(x.best.roju.nowe) > FUN(x.best.roju))
      x.best.roju <- x.best.roju.nowe
    
    g.best <- rbind(g.best, FUN(x.best.roju))
    
    for(i in 1:n) 
    {
      for(j in 1:d) 
      {
        r1 <- runif(1)
        r2 <- runif(1)
        
        v[i,j] <- w*v[i,j] + c1*r1*(x.best.czastki[i,j] - x[i,j]) +  c2*r2*(x.best.roju[j]-x[i,j])
        
        if(v[i,j] > vmax[j] || v[i,j] < -vmax[j])
          v[i,j] <- vmax[j]
        
        x_prev <- x[i,j]
        
        x[i,j] <- x[i,j] + v[i,j]
        
        if(x[i,j] > xmax[j])
          x[i,j] <- x_prev
        if(x[i,j] < xmin[j])
          x[i,j] <- x_prev
        
      }
    }
    if((d==2) && anim)
    {
      czas.rysunkow = proc.time()
      
      jpeg(paste("wykresy/pso_",nazwa,"_po_optym/",loop,".jpg",sep=""))
      contour(x_image[,1], x_image[,2], z, nlevels=20, xlab="x1", ylab="x2", col="darkgray", main=paste(loop))
      points(x, xlim=c(xmin[1], xmax[1]), ylim=c(xmin[2], xmax[2]), pch=21, bg="cadetblue")
      dev.off()
      
      
      czas.rysunkow2 = proc.time()-czas.rysunkow
      czas.stracony=czas.stracony+czas.rysunkow2
      # points(x, xlim=c(xmin[1], xmax[1]), ylim=c(xmin[2], xmax[2]), pch=21, bg=densCols(x))
    }
    
    loop <- loop + 1
    if(x.best.roju[1] != starex[1] || x.best.roju[2] != starex[2])
    {
      starex[1] = x.best.roju[1]
      starex[2] = x.best.roju[2]
      licznik=1
    }
    else
      licznik = licznik + 1
    
    if(licznik == 20) break
    
  }
  
  wynikczasu<<-proc.time() - ptm-czas.stracony
  #print(wynikczasu)

  jpeg(paste("wykresy/pso_",nazwa,"_po_optym/wykres.jpg",sep=""))
  plot(-g.best, type="o", col="darkgreen", pch=19, cex=.7, ylim=c(max(-g.mean),min(-g.best)), xlab="Iteracja", ylab="Wartoœæ funkcji")
  lines(-g.mean, type="o", col="blue", cex=.7, pch=19)
  legend("bottomright", legend = c("Best", "Mean"), col = c("darkgreen", "blue"), pch = 19, lty = 1, merge = TRUE)
  colnames(x.best.roju) <- paste("x", seq(1:d), sep="")
  
  dev.off() ## do rysunkow do pdfa
  #dev.off()
  res <<- list(sol = x.best.roju, val=g.best[loop-1], loop=loop-1,gbest=-g.best)
  
  
  return(res)
}
