PSO:
ackleypso = function(x)
{
  #ujemny (trzeba koncowy wynik pomno¿yæ *-1)
  a =-(-20*exp(-0.2*sqrt(0.5*(x[,1]^2+x[,2]^2)))-exp(0.5*(cos(2*pi*x[,1])+cos(2*pi*x[,2]))) + exp(1) + 20)
  return(a)
}
ackleypso = function(x)
{
  #dodatni
  a =-20*exp(-0.2*sqrt(0.5*(x[,1]^2+x[,2]^2)))-exp(0.5*(cos(2*pi*x[,1])+cos(2*pi*x[,2]))) + exp(1) + 20
  return(a)
}
x = matrix(0,,2)
x[1,1] = 5
x[1,2] = 4
ackleypso(x)


GA #algorytm jest ustawiony na maksymalna wartosc funkcji:
  ackleyga = function(x1,x2)
  {
    a =-20*exp(-0.2*sqrt(0.5*(x1^2+x2^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2))) + exp(1) + 20
    return(a)
  }  

  
ABC:
  #ujemny
  ackleyabc = function(x)
  {
    a =-(-20*exp(-0.2*sqrt(0.5*(x[1]^2+x[2]^2)))-exp(0.5*(cos(2*pi*x[1])+cos(2*pi*x[2]))) + exp(1) + 20)
    return(a)
  }  
  #dodatni
  ackleyabc = function(x)
  {
    a =-20*exp(-0.2*sqrt(0.5*(x[1]^2+x[2]^2)))-exp(0.5*(cos(2*pi*x[1])+cos(2*pi*x[2]))) + exp(1) + 20
    return(a)
  }  