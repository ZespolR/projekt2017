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

venter.ga = function(x1,x2) # [-50,50] min -400 at (0,0)
  x1^2 - 100*cos(x1)^2-100*cos(x1^2/30)+x2^2-100*cos(x2)^2-100*cos(x2^2/30)


zirilli.ga = function(x1,x2) #[-10,10] min -0.35 at (-1.04,0)
  0.25*x1^4 - 0.5*x1^2 + 0.1*x1 + 0.5*x2^2
