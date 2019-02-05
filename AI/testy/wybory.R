algorytmy <- function() #Poprawiony wybór algorytmu
{
  algor <- readline("Wybrany algorytm: ")
  if(!grepl("^[0-9]+$",algor))
  {
    cat("Niewlasciwy wybor")
    return(algorytmy())
  }
  
  alg <<- as.integer(algor)
  
  if(alg>4 || alg<1)
  {
    cat("Niewlasciwy wybor")
    return(algorytmy())
  }
}

wybor_funkcji <- function() #Wybor funkcji z listy
{
  wyb <- readline("Podaj numer wybranej funkcji: ")
  if(!grepl("^[0-9]+$",wyb))
  {
    cat("Niewlasciwy wybor")
    return(wybor_funkcji())
  }
  wybor <<- as.integer(wyb)
  
  if(wybor>13 || wybor<1)
  {
    cat("Niewlasciwy wybor")
    return(wybor_funkcji())
  }
}

powtorzenia <- function() #Wybor ilosci powtorzen
{
  p <- readline("Podaj ilosc powtorzen: ")
  if(!grepl("^[0-9]+$",p))
  {
    return(powtorzenia())
  }
  powt <<- as.integer(p)
  if(powt<10)
  {
    cat("Ilosc powtorzen musi wynosic co najmniej 10")
    return(powtorzenia())
  }
}

