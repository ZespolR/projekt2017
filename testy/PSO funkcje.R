
ackley.pso = function(x)
{
  a =-(-20*exp(-0.2*sqrt(0.5*(x[,1]^2+x[,2]^2)))-exp(0.5*(cos(2*pi*x[,1])+cos(2*pi*x[,2]))) + exp(1) + 20)
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

  
