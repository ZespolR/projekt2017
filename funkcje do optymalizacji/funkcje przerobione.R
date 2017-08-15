PSO:
  #ujemny (trzeba koncowy wynik pomno?y? *-1)
ackley.pso = function(x)
{
  a =-(-20*exp(-0.2*sqrt(0.5*(x[,1]^2+x[,2]^2)))-exp(0.5*(cos(2*pi*x[,1])+cos(2*pi*x[,2]))) + exp(1) + 20)
  return(a)
}

#dodatni
ackley.pso = function(x)
{
  a =-20*exp(-0.2*sqrt(0.5*(x[,1]^2+x[,2]^2)))-exp(0.5*(cos(2*pi*x[,1])+cos(2*pi*x[,2]))) + exp(1) + 20
  return(a)
}
x = matrix(0,,2)
x[1,1] = 5
x[1,2] = 4
ackley.pso(x)

rastrigin.pso <- function(x) # x[-5.12,5.12] min 0 at (0,0)
  -(20 + x[,1]^2 + x[,2]^2 - 10*(cos(2*pi*x[,1]) + cos(2*pi*x[,2])))

beale.pso = function(x) # [-4.5,4.5] min 0 at (3,0.5)
  -((1.5-x[,1]+x[,1]*x[,2])^2 + (2.25-x[,1]+x[,1]*x[,2]^2)^2 +(2.625-x[,1]+x[,1]*x[,2]^3)^2)

goldstein.pso = function(x) # [-2,2] min 3 at (0,-1)
  -((1+(x[,1]+x[,2]+1)^2 * (19-14*x[,1]+3*x[,1]^2 - 14*x[,2]+6*x[,1]*x[,2]+3*x[,2]^2))*(30+(2*x[,1]-3*x[,2])^2 * (18-32*x[,1]+12*x[,1]^2 + 48*x[,2]-36*x[,1]*x[,2]+27*x[,2]^2)))

booth.pso = function(x) # [-10,10] min 0 at (1,3)
  -((x[,1]+ 2*x[,2]-7)^2 + (2*x[,1]+x[,2]-5)^2)

bukin.pso = function(x) # x1[-15,-5] x2[-3,3] min 0 at (-10,1)
  -(100*sqrt(abs(x[,2]-0.01*x[,1]^2))+0.01*abs(x[,1]+10))

matyas.pso = function(x) # [-10,10] min 0 at (0,0)
  -(0.26*(x[,1]^2+x[,2]^2)-0.48*x[,1]*x[,2])

levin13.pso = function(x) # [-10,10] min 0 at (1,1)
  -(sin(3*pi*x[,1])^2+(x[,1]-1)^2 * (1+sin(3*pi*x[,2])^2)+(x[,2]-1)^2 * (1+sin(2*pi*x[,2])^2))

three.hump.camel.pso = function(x) # [-5,5] min 0 at (0,0)
  -(2*x[,1]^2 - 1.05*x[,1]^4 + (x[,1]^6)/6 + x[,1]*x[,2] + x[,2]^2)

easom.pso = function(x) # [-100,100] min -1 at (3.14,3.14)
  -(-cos(x[,1])*cos(x[,2])*exp(-((x[,1]-pi)^2 + (x[,2]-pi)^2)))

schaffer.pso = function(x) # [-100,100] min 0 at (0,0)
  -(0.5+(sin(x[,1]^2 - x[,2]^2)^2 - 0.5)/(1+0.001*(x[,1]^2 + x[,2]^2))^2)

eggholder.pso = function(x) # [-512,512] min -959 at (512,404)
  -(-(x[,2]+47)*sin(sqrt(abs(x[,2]+x[,1]/2+47)))-x[,1]*sin(sqrt(abs(x[,1]-(x[,2]+47)))))

six.hump.camel.pso <- function(x) #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
  -((4-2.1*x[,1]^2+(x[,1]^4)/3)*x[,1]^2+x[,1]*x[,2]+(-4+4*x[,2]^2)*x[,2]^2)

gramacy_lee.pso = function(x) ## 1 wymiarowe [0.5,2.5]
  -((((sin(10*pi*x[,1]))/(2*x[,1]))+(x[,1]-1)^4))

drop_wave.pso = function(x)# [-5.12,5.12] min -1 at (0,0)
  -((-(1+cos(12*sqrt(x[,1]^2+x[,2]^2)))/(0.5*(x[,1]^2+x[,2]^2)+2)))

mccormick.pso = function(x) # x1[-1.5,4] x2[-3,4] min -1.91 at (-0.54,-1.54)
  -(sin(x[,1]+x[,2])+(x[,1]-x[,2])^2-(1.5*x[,1])+(2.5*x[,2])+1)

holder.table.pso <- function(x) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
  -(-abs(sin(x[,1])*cos(x[,2])*exp(abs(1 - sqrt(x[,1]^2+x[,2]^2)/pi))))

cross_in_tray.pso = function(x) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
  -(-0.0001*(abs(sin(x[,1])*sin(x[,2])*exp(abs(100-((sqrt(x[,1]^2+x[,2]^2))/pi))))+1)^0.1)

test_tube_1.pso = function(x) ## nie ze strony
  -(-4*abs(sin(x[,1])*cos(x[,2])*exp(1)^abs(cos(((x[,1]^2)+(x[,2]^2))/200))))

adjiman.pso = function(x) # x1[-1,2] x2[-1,1] min -2.02 at (2,0.1)
  -(cos(x[,1])*sin(x[,2]) - (x[,1])/(x[,2]^2 +1))

bartels.conn.pso = function(x) # [-500,500] min 1 at (0,0)
  -(abs(x[,1]^2 + x[,2]^2 + x[,1]*x[,2])+abs(sin(x[,1]))+abs(cos(x[,2])))

bohachevsky.pso = function(x) # [-100,100] min 0 at (0,0)
  -(x[,1]^2 + 2*x[,2]^2 - 0.3*cos(3*pi*x[,1]) - 0.4*cos(4*pi*x[,2])+0.7)

brent.pso = function(x) #[-10,10] min 0 at (0,0) ale wychodzi 201
  -((x[,1]+10)^2 + (x[,2]+10)^2 + exp(1)^(-x[,1]^2 -x[,2]^2))

leon.pso = function(x) # [-1.2,1.2] min 0 at (1,1)
  -(100*(x[,2]-x[,1]^2)^2 + (1-x[,1])^2)

venter.pso = function(x) # [-50,50] min -400 at (0,0)
  -(x[,1]^2 - 100*cos(x[,1])^2-100*cos(x[,1]^2/30)+x[,2]^2-100*cos(x[,2])^2-100*cos(x[,2]^2/30))

zirilli.pso = function(x) #[-10,10] min -0.35 at (-1.04,0)
  -(0.25*x[,1]^4 - 0.5*x[,1]^2 + 0.1*x[,1] + 0.5*x[,2]^2)


GA #algorytm jest ustawiony na maksymalna wartosc funkcji:
  ackley.ga = function(x1,x2) #[-32.786,32.768] min 0
  {
    a =-20*exp(-0.2*sqrt(0.5*(x1^2+x2^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2))) + exp(1) + 20
    return(a)
  }  
  
  rastrigin.ga <- function(x1, x2) # x[-5.12,5.12] min 0
    20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
  
  beale.ga = function(x1,x2) # [-4.5,4.5] min 0 at (3,0.5)
    (1.5-x1+x1*x2)^2 + (2.25-x1+x1*x2^2)^2 +(2.625-x1+x1*x2^3)^2
  
  goldstein.ga = function(x1,x2) # [-2,2] min 3 at (0,-1)
    (1+(x1+x2+1)^2 * (19-14*x1+3*x1^2 - 14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2 * (18-32*x1+12*x1^2 + 48*x2-36*x1*x2+27*x2^2))
  
  booth.ga = function(x1,x2) # [-10,10] min 0 at (1,3)
    (x1+ 2*x2-7)^2 + (2*x1+x2-5)^2
  
  bukin.ga = function(x1,x2) # x1[-15,-5] x2[-3,3] min 0 at (-10,1)
    100*sqrt(abs(x2-0.01*x1^2))+0.01*abs(x1+10)
  
  matyas.ga = function(x1,x2) # [-10,10] min 0 at (0,0)
    0.26*(x1^2+x2^2)-0.48*x1*x2
  
  levin13.ga = function(x1,x2) # [-10,10] min 0 at (1,1)
    sin(3*pi*x1)^2+(x1-1)^2 * (1+sin(3*pi*x2)^2)+(x2-1)^2 * (1+sin(2*pi*x2)^2)
  
  three.hump.camel.ga = function(x1,x2) # [-5,5] min 0 at (0,0)
    2*x1^2 - 1.05*x1^4 + (x1^6)/6 + x1*x2 + x2^2
  
  easom.ga = function(x1,x2) # [-100,100] min -1 at (3.14,3.14)
    -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
  
  schaffer.ga = function(x1,x2) # [-100,100] min 0 at (0,0)
    0.5+(sin(x1^2 - x2^2)^2 - 0.5)/(1+0.001*(x1^2 + x2^2))^2
  
  eggholder.ga = function(x1,x2) # [-512,512] min -959 at (512,404)
    -(x2+47)*sin(sqrt(abs(x2+x1/2+47)))-x1*sin(sqrt(abs(x1-(x2+47))))
  
  six.hump.camel.ga <- function(x1,x2) #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
    (4-2.1*x1^2+(x1^4)/3)*x1^2+x1*x2+(-4+4*x2^2)*x2^2
  
  gramacy_lee.ga = function(x1,x2) ## 1 wymiarowe [0.5,2.5]
    (((sin(10*pi*x1))/(2*x1))+(x1-1)^4)
  
  drop_wave.ga = function(x1,x2)# [-5.12,5.12] min -1 at (0,0)
    (-(1+cos(12*sqrt(x1^2+x2^2)))/(0.5*(x1^2+x2^2)+2))
  
  mccormick.ga = function(x1,x2) # x1[-1.5,4] x2[-3,4] min -1.91 at (-0.54,-1.54)
    sin(x1+x2)+(x1-x2)^2-(1.5*x1)+(2.5*x2)+1
  
  holder.table.ga <- function(x1,x2) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
    -abs(sin(x1)*cos(x2)*exp(abs(1 - sqrt(x1^2+x2^2)/pi)))
  
  cross_in_tray.ga = function(x1,x2) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
    -0.0001*(abs(sin(x1)*sin(x2)*exp(abs(100-((sqrt(x1^2+x2^2))/pi))))+1)^0.1
  
  test_tube_1.ga = function(x1,x2) ## nie ze strony
    -4*abs(sin(x1)*cos(x2)*exp(1)^abs(cos(((x1^2)+(x2^2))/200)))
  
  adjiman.ga = function(x1,x2) # x1[-1,2] x2[-1,1] min -2.02 at (2,0.1)
    cos(x1)*sin(x2) - (x1)/(x2^2 +1)
  
  bartels.conn.ga = function(x1,x2) # [-500,500] min 1 at (0,0)
    abs(x1^2 + x2^2 + x1*x2)+abs(sin(x1))+abs(cos(x2))
  
  bohachevsky.ga = function(x1,x2) # [-100,100] min 0 at (0,0)
    x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2)+0.7
  
  brent.ga = function(x1,x2) #[-10,10] min 0 at (0,0) ale wychodzi 201
    (x1+10)^2 + (x2+10)^2 + exp(1)^(-x1^2 -x2^2)
  
  leon.ga = function(x1,x2) # [-1.2,1.2] min 0 at (1,1)
    100*(x2-x1^2)^2 + (1-x1)^2
  
  
ABC:
  #ujemny
  ackley.abc = function(x)
  {
    a =-(-20*exp(-0.2*sqrt(0.5*(x[1]^2+x[2]^2)))-exp(0.5*(cos(2*pi*x[1])+cos(2*pi*x[2]))) + exp(1) + 20)
    return(a)
  }  

  #dodatni
  ackley.abc = function(x)
  {
    a =-20*exp(-0.2*sqrt(0.5*(x[1]^2+x[2]^2)))-exp(0.5*(cos(2*pi*x[1])+cos(2*pi*x[2]))) + exp(1) + 20
    return(a)
  }  
  
  rastrigin.abc <- function(x) # x[-5.12,5.12] min 0
    20 + x[1]^2 + x[2]^2 - 10*(cos(2*pi*x[1]) + cos(2*pi*x[2]))
  
  beale.abc = function(x) # [-4.5,4.5] min 0 at (3,0.5)
    (1.5-x[1]+x[1]*x[2])^2 + (2.25-x[1]+x[1]*x[2]^2)^2 +(2.625-x[1]+x[1]*x[2]^3)^2
  
  goldstein.abc = function(x) # [-2,2] min 3 at (0,-1)
    (1+(x[1]+x[2]+1)^2 * (19-14*x[1]+3*x[1]^2 - 14*x[2]+6*x[1]*x[2]+3*x[2]^2))*(30+(2*x[1]-3*x[2])^2 * (18-32*x[1]+12*x[1]^2 + 48*x[2]-36*x[1]*x[2]+27*x[2]^2))
  
  booth.abc = function(x) # [-10,10] min 0 at (1,3)
    (x[1]+ 2*x[2]-7)^2 + (2*x[1]+x[2]-5)^2
  
  bukin.abc = function(x) # x[1][-15,-5] x[2][-3,3] min 0 at (-10,1)
    100*sqrt(abs(x[2]-0.01*x[1]^2))+0.01*abs(x[1]+10)
  
  matyas.abc = function(x) # [-10,10] min 0 at (0,0)
    0.26*(x[1]^2+x[2]^2)-0.48*x[1]*x[2]
  
  levin13.abc = function(x) # [-10,10] min 0 at (1,1)
    sin(3*pi*x[1])^2+(x[1]-1)^2 * (1+sin(3*pi*x[2])^2)+(x[2]-1)^2 * (1+sin(2*pi*x[2])^2)
  
  three.hump.camel.abc = function(x) # [-5,5] min 0 at (0,0)
    2*x[1]^2 - 1.05*x[1]^4 + (x[1]^6)/6 + x[1]*x[2] + x[2]^2
  
  easom.abc = function(x) # [-100,100] min -1 at (3.14,3.14)
    -cos(x[1])*cos(x[2])*exp(-((x[1]-pi)^2 + (x[2]-pi)^2))
  
  schaffer.abc = function(x) # [-100,100] min 0 at (0,0)
    0.5+(sin(x[1]^2 - x[2]^2)^2 - 0.5)/(1+0.001*(x[1]^2 + x[2]^2))^2
  
  eggholder.abc = function(x) # [-512,512] min -959 at (512,404)
    -(x[2]+47)*sin(sqrt(abs(x[2]+x[1]/2+47)))-x[1]*sin(sqrt(abs(x[1]-(x[2]+47))))
  
  six.hump.camel.abc <- function(x) #x[1][-3,3] x[2][-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
    (4-2.1*x[1]^2+(x[1]^4)/3)*x[1]^2+x[1]*x[2]+(-4+4*x[2]^2)*x[2]^2
  
  gramacy_lee.abc = function(x) ## 1 wymiarowe [0.5,2.5]
    (((sin(10*pi*x[1]))/(2*x[1]))+(x[1]-1)^4)
  
  drop_wave.abc = function(x)# [-5.12,5.12] min -1 at (0,0)
    (-(1+cos(12*sqrt(x[1]^2+x[2]^2)))/(0.5*(x[1]^2+x[2]^2)+2))
  
  mccormick.abc = function(x) # x[1][-1.5,4] x[2][-3,4] min -1.91 at (-0.54,-1.54)
    sin(x[1]+x[2])+(x[1]-x[2])^2-(1.5*x[1])+(2.5*x[2])+1
  
  holder.table.abc <- function(x) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
    -abs(sin(x[1])*cos(x[2])*exp(abs(1 - sqrt(x[1]^2+x[2]^2)/pi)))
  
  cross_in_tray.abc = function(x) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
    -0.0001*(abs(sin(x[1])*sin(x[2])*exp(abs(100-((sqrt(x[1]^2+x[2]^2))/pi))))+1)^0.1
  
  test_tube_1.abc = function(x) ## nie ze strony
    -4*abs(sin(x[1])*cos(x[2])*exp(1)^abs(cos(((x[1]^2)+(x[2]^2))/200)))
  
  adjiman.abc = function(x) # x[1][-1,2] x[2][-1,1] min -2.02 at (2,0.1)
    cos(x[1])*sin(x[2]) - (x[1])/(x[2]^2 +1)
  
  bartels.conn.abc = function(x) # [-500,500] min 1 at (0,0)
    abs(x[1]^2 + x[2]^2 + x[1]*x[2])+abs(sin(x[1]))+abs(cos(x[2]))
  
  bohachevsky.abc = function(x) # [-100,100] min 0 at (0,0)
    x[1]^2 + 2*x[2]^2 - 0.3*cos(3*pi*x[1]) - 0.4*cos(4*pi*x[2])+0.7
  
  brent.abc = function(x) #[-10,10] min 0 at (0,0) ale wychodzi 201
    (x[1]+10)^2 + (x[2]+10)^2 + exp(1)^(-x[1]^2 -x[2]^2)
  
  leon.abc = function(x) # [-1.2,1.2] min 0 at (1,1)
    100*(x[2]-x[1]^2)^2 + (1-x[1])^2
  
  venter.abc = function(x) # [-50,50] min -400 at (0,0)
    x[1]^2 - 100*cos(x[1])^2-100*cos(x[1]^2/30)+x[2]^2-100*cos(x[2])^2-100*cos(x[2]^2/30)
  
  zirilli.abc= function(x) #[-10,10] min -0.35 at (-1.04,0)
    0.25*x[1]^4 - 0.5*x[1]^2 + 0.1*x[1] + 0.5*x[2]^2
    
DE:
    
    ackley.de = function(x) #[-32.786,32.768] min 0
    {
      x1 <- x[1]
      x2 <- x[2]
      a =-20*exp(-0.2*sqrt(0.5*(x1^2+x2^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2))) + exp(1) + 20
      return(a)
    }  
  
  rastrigin.de <- function(x) # x[-5.12,5.12] min 0
  {
    x1 <- x[1]
    x2 <- x[2]
    20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
  }
  
  beale.de = function(x) # [-4.5,4.5] min 0 at (3,0.5)
  {
    x1 <- x[1]
    x2 <- x[2]
    (1.5-x1+x1*x2)^2 + (2.25-x1+x1*x2^2)^2 +(2.625-x1+x1*x2^3)^2
  }
  
  goldstein.de = function(x) # [-2,2] min 3 at (0,-1)
  {
    x1 <- x[1]
    x2 <- x[2]
    (1+(x1+x2+1)^2 * (19-14*x1+3*x1^2 - 14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2 * (18-32*x1+12*x1^2 + 48*x2-36*x1*x2+27*x2^2))
  }
  
  booth.de = function(x) # [-10,10] min 0 at (1,3)
  {
    x1 <- x[1]
    x2 <- x[2]
    (x1+ 2*x2-7)^2 + (2*x1+x2-5)^2
  }
  
  bukin.de = function(x) # x1[-15,-5] x2[-3,3] min 0 at (-10,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    100*sqrt(abs(x2-0.01*x1^2))+0.01*abs(x1+10)
  }
  
  matyas.de = function(x) # [-10,10] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.26*(x1^2+x2^2)-0.48*x1*x2
  }
  
  levin13.de = function(x) # [-10,10] min 0 at (1,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    sin(3*pi*x1)^2+(x1-1)^2 * (1+sin(3*pi*x2)^2)+(x2-1)^2 * (1+sin(2*pi*x2)^2)
  }
  
  three.hump.camel.de = function(x) # [-5,5] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    2*x1^2 - 1.05*x1^4 + (x1^6)/6 + x1*x2 + x2^2
  }
  
  easom.de = function(x) # [-100,100] min -1 at (3.14,3.14)
  {
    x1 <- x[1]
    x2 <- x[2]
    -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
  }
  
  schaffer.de = function(x) # [-100,100] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.5+(sin(x1^2 - x2^2)^2 - 0.5)/(1+0.001*(x1^2 + x2^2))^2
  }
  
  eggholder.de = function(x) # [-512,512] min -959 at (512,404)
  {
    x1 <- x[1]
    x2 <- x[2]
    -(x2+47)*sin(sqrt(abs(x2+x1/2+47)))-x1*sin(sqrt(abs(x1-(x2+47))))
  }
  
  six.hump.camel.de <- function(x) #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
  {
    x1 <- x[1]
    x2 <- x[2]
    (4-2.1*x1^2+(x1^4)/3)*x1^2+x1*x2+(-4+4*x2^2)*x2^2
  }
  
  gramacy_lee.de = function(x) ## 1 wymiarowe [0.5,2.5]
  {
    x1 <- x[1]
    x2 <- x[2]
    (((sin(10*pi*x1))/(2*x1))+(x1-1)^4)
  }
  
  drop_wave.de = function(x)# [-5.12,5.12] min -1 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    (-(1+cos(12*sqrt(x1^2+x2^2)))/(0.5*(x1^2+x2^2)+2))
  }
  
  mccormick.de = function(x) # x1[-1.5,4] x2[-3,4] min -1.91 at (-0.54,-1.54)
  {
    x1 <- x[1]
    x2 <- x[2]
    sin(x1+x2)+(x1-x2)^2-(1.5*x1)+(2.5*x2)+1
  }
  
  holder.table.de <- function(x) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
  {
    x1 <- x[1]
    x2 <- x[2]
    -abs(sin(x1)*cos(x2)*exp(abs(1 - sqrt(x1^2+x2^2)/pi)))
  }
  
  cross_in_tray.de = function(x) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
  {
    x1 <- x[1]
    x2 <- x[2]
    -0.0001*(abs(sin(x1)*sin(x2)*exp(abs(100-((sqrt(x1^2+x2^2))/pi))))+1)^0.1
  }
  
  test_tube_1.de = function(x) ## nie ze strony
  {
    x1 <- x[1]
    x2 <- x[2]
    -4*abs(sin(x1)*cos(x2)*exp(1)^abs(cos(((x1^2)+(x2^2))/200)))
  }
  
  adjiman.de = function(x) # x1[-1,2] x2[-1,1] min -2.02 at (2,0.1)
  {
    x1 <- x[1]
    x2 <- x[2]
    cos(x1)*sin(x2) - (x1)/(x2^2 +1)
  }
  
  bartels.conn.de = function(x) # [-500,500] min 1 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    abs(x1^2 + x2^2 + x1*x2)+abs(sin(x1))+abs(cos(x2))
  }
  
  bohachevsky.de = function(x) # [-100,100] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2)+0.7
  }
  
  brent.de = function(x) #[-10,10] min 0 at (0,0) ale wychodzi 201
  {
    x1 <- x[1]
    x2 <- x[2]
    (x1+10)^2 + (x2+10)^2 + exp(1)^(-x1^2 -x2^2)
  }
  
  leon.de = function(x) # [-1.2,1.2] min 0 at (1,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    100*(x2-x1^2)^2 + (1-x1)^2
  }
  
  venter.de = function(x) # [-50,50] min -400 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    x1^2 - 100*cos(x1)^2-100*cos(x1^2/30)+x2^2-100*cos(x2)^2-100*cos(x2^2/30)
  }
  
  zirilli.de = function(x) #[-10,10] min -0.35 at (-1.04,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.25*x1^4 - 0.5*x1^2 + 0.1*x1 + 0.5*x2^2
  }
  
  
GSO:
   
    ackley.gso = function(x,y)
    {
      a =-(-20*exp(-0.2*sqrt(0.5*(x^2+y^2)))-exp(0.5*(cos(2*pi*x)+cos(2*pi*y))) + exp(1) + 20)
      return(a)
    }
    
  rastrigin.gso <- function(x,y) # x[-5.12,5.12] min 0 at (0,0)
    20 + x^2 + y^2 - 10*(cos(2*pi*x) + cos(2*pi*y))
  
  beale.gso = function(x,y) # [-4.5,4.5] min 0 at (3,0.5)
    (1.5-x+x*y)^2 + (2.25-x+x*y^2)^2 +(2.625-x+x*y^3)^2
  
  goldstein.gso = function(x,y) # [-2,2] min 3 at (0,-1)
    (1+(x+y+1)^2 * (19-14*x+3*x^2 - 14*y+6*x*y+3*y^2))*(30+(2*x-3*y)^2 * (18-32*x+12*x^2 + 48*y-36*x*y+27*y^2))
  
  booth.gso = function(x,y) # [-10,10] min 0 at (1,3)
    (x+ 2*y-7)^2 + (2*x+y-5)^2
  
  bukin.gso = function(x,y) # x1[-15,-5] x2[-3,3] min 0 at (-10,1)
    100*sqrt(abs(y-0.01*x^2))+0.01*abs(x+10)
  
  matyas.gso = function(x,y) # [-10,10] min 0 at (0,0)
    0.26*(x^2+y^2)-0.48*x*y
  
  levin13.gso = function(x,y) # [-10,10] min 0 at (1,1)
    sin(3*pi*x)^2+(x-1)^2 * (1+sin(3*pi*y)^2)+(y-1)^2 * (1+sin(2*pi*y)^2)
  
  three.hump.camel.gso = function(x,y) # [-5,5] min 0 at (0,0)
    2*x^2 - 1.05*x^4 + (x^6)/6 + x*y + y^2
  
  easom.gso = function(x,y) # [-100,100] min -1 at (3.14,3.14)
    -cos(x)*cos(y)*exp(-((x-pi)^2 + (y-pi)^2))
  
  schaffer.gso = function(x,y) # [-100,100] min 0 at (0,0)
    0.5+(sin(x^2 - y^2)^2 - 0.5)/(1+0.001*(x^2 + y^2))^2
  
  eggholder.gso = function(x,y) # [-512,512] min -959 at (512,404)
    -(y+47)*sin(sqrt(abs(y+x/2+47)))-x*sin(sqrt(abs(x-(y+47))))
  
  six.hump.camel.gso <- function(x,y) #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
    (4-2.1*x^2+(x^4)/3)*x^2+x*y+(-4+4*y^2)*y^2
  
  gramacy_lee.gso = function(x,y) ## 1 wymiarowe [0.5,2.5]
    (((sin(10*pi*x))/(2*x))+(x-1)^4)
  
  drop_wave.gso = function(x,y)# [-5.12,5.12] min -1 at (0,0)
    (-(1+cos(12*sqrt(x^2+y^2)))/(0.5*(x^2+y^2)+2))
  
  mccormick.gso = function(x,y) # x1[-1.5,4] x2[-3,4] min -1.91 at (-0.54,-1.54)
    sin(x+y)+(x-y)^2-(1.5*x)+(2.5*y)+1
  
  holder.table.gso <- function(x,y) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
    -abs(sin(x)*cos(y)*exp(abs(1 - sqrt(x^2+y^2)/pi)))
  
  cross_in_tray.gso = function(x,y) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
    -0.0001*(abs(sin(x)*sin(y)*exp(abs(100-((sqrt(x^2+y^2))/pi))))+1)^0.1
  
  test_tube_1.gso = function(x,y) ## nie ze strony
    -4*abs(sin(x)*cos(y)*exp(1)^abs(cos(((x^2)+(y^2))/200)))
  
  adjiman.gso = function(x,y) # x1[-1,2] x2[-1,1] min -2.02 at (2,0.1)
    cos(x)*sin(y) - (x)/(y^2 +1)
  
  bartels.conn.gso = function(x,y) # [-500,500] min 1 at (0,0)
    abs(x^2 + y^2 + x*y)+abs(sin(x))+abs(cos(y))
  
  bohachevsky.gso = function(x,y) # [-100,100] min 0 at (0,0)
    x^2 + 2*y^2 - 0.3*cos(3*pi*x) - 0.4*cos(4*pi*y)+0.7
  
  brent.gso = function(x,y) #[-10,10] min 0 at (0,0) ale wychodzi 201
    (x+10)^2 + (y+10)^2 + exp(1)^(-x^2 -y^2)
  
  leon.gso = function(x,y) # [-1.2,1.2] min 0 at (1,1)
    100*(y-x^2)^2 + (1-x)^2
  
  venter.gso = function(x,y) # [-50,50] min -400 at (0,0)
    x^2 - 100*cos(x)^2-100*cos(x^2/30)+y^2-100*cos(y)^2-100*cos(y^2/30)
  
  zirilli.gso = function(x,y) #[-10,10] min -0.35 at (-1.04,0)
    0.25*x^4 - 0.5*x^2 + 0.1*x + 0.5*y^2
  
  
Bat:
  
    ackley.bat = function(D, sol)
    {
      a=20 
      b=0.2 
      c=2*pi
      xx = sol
      sum1 <- sum(xx^2)
      sum2 <- sum(cos(c*xx))
      
      term1 <- -a * exp(-b*sqrt(sum1/D))
      term2 <- -exp(sum2/D)
      
      y <- term1 + term2 + a + exp(1)
      return(y)
    }
  
  rastrigin.bat <- function(D,x) # x[-5.12,5.12] min 0
  {
    x1 <- x[1]
    x2 <- x[2]
    20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
  }
  
  beale.bat = function(D,x) # [-4.5,4.5] min 0 at (3,0.5)
  {
    x1 <- x[1]
    x2 <- x[2]
    (1.5-x1+x1*x2)^2 + (2.25-x1+x1*x2^2)^2 +(2.625-x1+x1*x2^3)^2
  }
  
  goldstein.bat = function(D,x) # [-2,2] min 3 at (0,-1)
  {
    x1 <- x[1]
    x2 <- x[2]
    (1+(x1+x2+1)^2 * (19-14*x1+3*x1^2 - 14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2 * (18-32*x1+12*x1^2 + 48*x2-36*x1*x2+27*x2^2))
  }
  
  booth.bat = function(D,x) # [-10,10] min 0 at (1,3)
  {
    x1 <- x[1]
    x2 <- x[2]
    (x1+ 2*x2-7)^2 + (2*x1+x2-5)^2
  }
  
  bukin.bat = function(D,x) # x1[-15,-5] x2[-3,3] min 0 at (-10,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    100*sqrt(abs(x2-0.01*x1^2))+0.01*abs(x1+10)
  }
  
  matyas.bat = function(D,x) # [-10,10] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.26*(x1^2+x2^2)-0.48*x1*x2
  }
  
  levin13.bat = function(D,x) # [-10,10] min 0 at (1,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    sin(3*pi*x1)^2+(x1-1)^2 * (1+sin(3*pi*x2)^2)+(x2-1)^2 * (1+sin(2*pi*x2)^2)
  }
  
  three.hump.camel.bat = function(D,x) # [-5,5] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    2*x1^2 - 1.05*x1^4 + (x1^6)/6 + x1*x2 + x2^2
  }
  
  easom.bat = function(D,x) # [-100,100] min -1 at (3.14,3.14)
  {
    x1 <- x[1]
    x2 <- x[2]
    -cos(x1)*cos(x2)*exp(-((x1-pi)^2 + (x2-pi)^2))
  }
  
  schaffer.bat = function(D,x) # [-100,100] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.5+(sin(x1^2 - x2^2)^2 - 0.5)/(1+0.001*(x1^2 + x2^2))^2
  }
  
  eggholder.bat = function(D,x) # [-512,512] min -959 at (512,404)
  {
    x1 <- x[1]
    x2 <- x[2]
    -(x2+47)*sin(sqrt(abs(x2+x1/2+47)))-x1*sin(sqrt(abs(x1-(x2+47))))
  }
  
  six.hump.camel.bat <- function(D,x) #x1[-3,3] x2[-2,2] min -1.03 at (0.089,-0.712) lub(-0.089,   0.71)
  {
    x1 <- x[1]
    x2 <- x[2]
    (4-2.1*x1^2+(x1^4)/3)*x1^2+x1*x2+(-4+4*x2^2)*x2^2
  }
  
  gramacy_lee.bat = function(D,x) ## 1 wymiarowe [0.5,2.5]
  {
    x1 <- x[1]
    x2 <- x[2]
    (((sin(10*pi*x1))/(2*x1))+(x1-1)^4)
  }
  
  drop_wave.bat = function(D,x)# [-5.12,5.12] min -1 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    (-(1+cos(12*sqrt(x1^2+x2^2)))/(0.5*(x1^2+x2^2)+2))
  }
  
  mccormick.bat = function(D,x) # x1[-1.5,4] x2[-3,4] min -1.91 at (-0.54,-1.54)
  {
    x1 <- x[1]
    x2 <- x[2]
    sin(x1+x2)+(x1-x2)^2-(1.5*x1)+(2.5*x2)+1
  }
  
  holder.table.bat <- function(D,x) #x[-10,10] min -19 at (8.05,9.66 i z minusami)
  {
    x1 <- x[1]
    x2 <- x[2]
    -abs(sin(x1)*cos(x2)*exp(abs(1 - sqrt(x1^2+x2^2)/pi)))
  }
  
  cross_in_tray.bat = function(D,x) # x[-10,10] min -2.06 at (1.34,1.34 i z minusami)
  {
    x1 <- x[1]
    x2 <- x[2]
    -0.0001*(abs(sin(x1)*sin(x2)*exp(abs(100-((sqrt(x1^2+x2^2))/pi))))+1)^0.1
  }
  
  test_tube_1.bat = function(D,x) ## nie ze strony
  {
    x1 <- x[1]
    x2 <- x[2]
    -4*abs(sin(x1)*cos(x2)*exp(1)^abs(cos(((x1^2)+(x2^2))/200)))
  }
  
  adjiman.bat = function(D,x) # x1[-1,2] x2[-1,1] min -2.02 at (2,0.1)
  {
    x1 <- x[1]
    x2 <- x[2]
    cos(x1)*sin(x2) - (x1)/(x2^2 +1)
  }
  
  bartels.conn.bat = function(D,x) # [-500,500] min 1 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    abs(x1^2 + x2^2 + x1*x2)+abs(sin(x1))+abs(cos(x2))
  }
  
  bohachevsky.bat = function(D,x) # [-100,100] min 0 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    x1^2 + 2*x2^2 - 0.3*cos(3*pi*x1) - 0.4*cos(4*pi*x2)+0.7
  }
  
  brent.bat = function(D,x) #[-10,10] min 0 at (0,0) ale wychodzi 201
  {
    x1 <- x[1]
    x2 <- x[2]
    (x1+10)^2 + (x2+10)^2 + exp(1)^(-x1^2 -x2^2)
  }
  
  leon.bat = function(D,x) # [-1.2,1.2] min 0 at (1,1)
  {
    x1 <- x[1]
    x2 <- x[2]
    100*(x2-x1^2)^2 + (1-x1)^2
  }
  
  venter.bat = function(D,x) # [-50,50] min -400 at (0,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    x1^2 - 100*cos(x1)^2-100*cos(x1^2/30)+x2^2-100*cos(x2)^2-100*cos(x2^2/30)
  }
  
  zirilli.bat = function(D,x) #[-10,10] min -0.35 at (-1.04,0)
  {
    x1 <- x[1]
    x2 <- x[2]
    0.25*x1^4 - 0.5*x1^2 + 0.1*x1 + 0.5*x2^2
  }
  