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
