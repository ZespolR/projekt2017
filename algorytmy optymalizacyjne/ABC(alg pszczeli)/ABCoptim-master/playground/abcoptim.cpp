#include <ABCoptim.h>

using namespace Rcpp;

/* Function to evaluate an R function */
double abc_fun(SEXP fn, SEXP par)
{
  SEXP R_fcall, ans;

  if(!isFunction(fn)) error("'fn' must be a function");
  R_fcall = PROTECT(lang2(fn, R_NilValue));
  
  SETCADR(R_fcall, par);
  ans=eval(R_fcall, R_GlobalEnv);
  UNPROTECT(1);
  return REAL(ans)[0];
}


List abc_initialize(
  int nfoods,
  int nparam,
  SEXP objfun,
  abc_boundaries * b,
  int limit
) 
{
    
  NumericVector fitness(nfoods);
	NumericMatrix pos(nfoods,nparam);
	NumericVector val(nfoods);
	NumericVector prob(nfoods);
  NumericVector trials(nfoods);
  NumericVector GlobPars(nparam);
  
  for(int i=0;i<nfoods;i++)
  {
    for(int j=0;j<nparam;j++)
      pos(i,j) = abc_unif(b->lb[j],b->ub[j]);
      
    val[i]     = abc_fun(objfun, wrap(pos(i,_)));
    fitness[i] = abc_calc_fit(val[i]);
  }
  

	return List::create(
    _["fitness"]      = fitness,  /* Fitness of each food source */
    _["pos"]          = pos,      /* Current possition of each food source */
    _["prob"]         = prob,
    _["val"]          = val,      /* Current value of each food source */
    _["GlobalMin"]    = val[0],   /* Current Global Minimum */
    _["GlobalParams"] = pos(0,_), /* Current optimal params */
    _["trials"]       = trials,   /* Number of trials on the source */
    _["persistance"]  = 0,        /* N of iter without improvement */
    _["limit"]        = limit     /* Maximum number of attemps */
	);
} 

void abc_init(
  int index,
	List& Foods,
	SEXP objfun,
	abc_boundaries * b
) {
	int i,j;

	/* Getting the food number */
	NumericMatrix foods_pos = Foods["pos"];
	NumericVector foods_val = Foods["val"];
	NumericVector foods_trl = Foods["trials"];
	NumericVector foods_fit = Foods["fitness"];
	int nparam = foods_pos.ncol();

	/* Setting the positions */
	for(j=0;j<nparam;j++)
		foods_pos(index,j) = abc_unif(b->lb[j],b->ub[j]);
	
	/* Getting the value and */
	foods_val[index] = abc_fun(objfun, wrap(foods_pos(index,_)));
	foods_fit[index] = abc_calc_fit(foods_val[index]);
	foods_trl[index] = 0;

	return ;
}

void abc_send_empl_bees(
  List& Foods, 
  int nfoods, int nparam,
  abc_boundaries * b, 
  SEXP objfun
) {
  
	/* Poiting */
	NumericMatrix foods_pos = Foods["pos"];
	NumericVector foods_val = Foods["val"];
  NumericVector foods_fit = Foods["fitness"];
  NumericVector foods_trl = Foods["trials"];

	NumericVector new_foods_pos;

	int param2change = floor(abc_unif()*nparam);
  
	/* Random solution */
	int neighbour  = 0;
  double new_val = 0.0;
  double new_fit = 0.0;
  
	for(int i=0;i<nfoods;i++) 
  {
    neighbour = (int)floor(abc_unif()*nfoods);
		while(neighbour==i)
    {
      /* Checking if the user press break */
      // R_CheckUserInterrupt();
      neighbour = (int)floor(abc_unif()*nfoods);
      
    }
    new_foods_pos = foods_pos(i,_);
		new_foods_pos[param2change] =
			foods_pos(i,param2change) +
			(foods_pos(i,param2change) - 
			foods_pos(neighbour,param2change))*(abc_unif()-.5)*2;
    
    /* Checking boundaries */
    if (new_foods_pos[param2change] > b->ub[param2change]) 
      new_foods_pos[param2change] = b->ub[param2change];
    else if (new_foods_pos[param2change] < b->lb[param2change]) 
      new_foods_pos[param2change] = b->lb[param2change];      
    
    new_val = abc_fun(objfun, wrap(new_foods_pos));
    new_fit = abc_calc_fit(new_val);
    
    /* Greedy selection */
    if (new_fit > foods_fit[i])
    {
      foods_trl[i] = 0;
      foods_pos(i,_) = clone(new_foods_pos);
      foods_val[i]   = new_val;
      foods_fit[i]   = new_fit;
    }
    else foods_trl[i] += 1;
  }

	return ;
}


/* Pointer Function Definition */
/*type double (*ptrFun)(NumericVector x);*/
void abc_send_onlooker_bees(
  List& Foods, 
  SEXP objfun,
  int FoodNumber,
  int D,
  abc_boundaries * b
  )
{
  // Onlooker Bee phase
  int i = 0;
  int t = 0;

  NumericVector foods_val = Foods["val"];
  NumericMatrix foods_pos = Foods["pos"];
  NumericVector foods_trl = Foods["trials"];
  NumericVector foods_prb = Foods["prob"];
  // Rprintf("ok\n");
  NumericVector foods_fit = Foods["fitness"];
  NumericMatrix solution  = clone(foods_pos);
  double r=0.0;
  while(t < FoodNumber)
  {
    /* Checking if the user press break */
    R_CheckUserInterrupt();
    
    r = abc_unif();
    // choose a food source depending on its probability to be chosen
    if (r < foods_prb[i])
    {
      t += 1;
      
      // The parameter to be changed is determined randomly
      int param2change = floor(r*D);
      
      /* A randomly chosen solution is used in producing a mutant solution of
      the solution i Randomly selected solution must be different from the
      solution i*/        
      int neighbour = floor(r*FoodNumber);
      while(neighbour==i)
        neighbour = floor(abc_unif()*FoodNumber);
      
      /* v_{ij}=x_{ij}+\phi_{ij}*(x_{kj}-x_{ij}) */
      r = abc_unif();
      
      /* if (optiinteger) solution[param2change] <<- r > .5
      else 
      {*/
      solution(i,param2change) =
        solution(i,param2change)+
        (solution(i,param2change)-foods_pos(neighbour,param2change))*(r-0.5)*2;
      
      /* if generated parameter value is out of boundaries, it is shifted onto
      the boundaries*/
      if (solution(i,param2change)< b->lb[param2change]) 
        solution(i,param2change) = b->lb[param2change];
      
      if (solution(i,param2change)> b->ub[param2change]) 
        solution(i,param2change) = b->ub[param2change];
        
      /*}*/
      
      double ObjValSol  = abc_fun(objfun,wrap(solution(i,_)));
      double FitnessSol = abc_calc_fit(ObjValSol);
      
      /* a greedy selection is applied between the current solution i and its
      mutant*/
      if (FitnessSol>foods_fit[i])
      {
        /* If the mutant solution is better than the current solution i,
        replace the solution with the mutant and reset the trial counter of
        solution i*/
        foods_trl[i]   = 0;
        foods_pos(i,_) = solution(i,_);
        foods_val[i]   = ObjValSol;
        foods_fit[i]   = FitnessSol;
      } /* if the solution i can not be improved, increase its trial counter*/
      else foods_trl[i] += 1;
    }
    if (i<FoodNumber) i+= 1;
    else i = 0;
    
    // end of onlooker bee phase
  }
}

/* determine the food sources whose trial counter exceeds the "limit" value.
In Basic ABC, only one scout is allowed to occur in each cycle*/
void abc_send_scout_bees(
  List& Foods,
  SEXP objfun,
  abc_boundaries * b,
  int FoodNumber)
{

  NumericVector trials = Foods["trials"];
  int maxtrialindex    = 1;
  int limit            = Foods["limit"];
  for (int i=0;i<FoodNumber;i++)
    if (trials[i] > trials[maxtrialindex]) maxtrialindex = i;
  
  if (trials[maxtrialindex] >= limit)
    abc_init(maxtrialindex, Foods, objfun, b);
  
  
  return;
}

// [[Rcpp::export]]
List abc_optimCpp(
  NumericVector par, SEXP fn,
  NumericVector lb = NumericVector::create(1,-DBL_MAX),
  NumericVector ub = NumericVector::create(1,DBL_MAX),
  int FoodNumber   = 20,
  int limit        = 100,
  int maxCycle     = 1000,
  int criter       = 50
  )
{

  /* Number of parameters  */
  int nparam = par.size();
  
  /* Boundaries */
  double lb0[nparam];
  double ub0[nparam];
  if (lb.size() == nparam)
    for(int i=0;i<nparam;i++)
      lb0[i] = lb[i];
  else
    for(int i=0;i<nparam;i++)
      lb0[i] = lb[0];
  
  if (ub.size() == nparam)
    for(int i=0;i<nparam;i++)
      ub0[i] = ub[i];
  else
    for(int i=0;i<nparam;i++)
      ub0[i] = ub[0];
  
  abc_boundaries boundaries;
  for(int i=0;i<nparam;i++)
  {
    boundaries.ub[i] = ub0[i];
    boundaries.lb[i] = lb0[i];
  }
  
  List Foods = abc_initialize(FoodNumber, nparam, fn, &boundaries, limit);
  abc_calc_prob(Foods, FoodNumber);
 
  /* Memorizes the initial sol */
  int persistance=0;
  abc_mem_best_src(Foods, &persistance);
  
  /* Start! */
  int iter = 0;
  while (++iter < maxCycle)
  {
    // Rprintf("Enter %d\n", iter);
    /* Checking if the user press break */
    R_CheckUserInterrupt();
    
    abc_send_empl_bees(Foods, FoodNumber, nparam, &boundaries, fn);
    // Rprintf("send_empl... Iter %d\n",iter);
    
    abc_calc_prob(Foods, FoodNumber);
    // Rprintf("calc_prob... Iter %d\n",iter);
    
    abc_send_onlooker_bees(Foods, fn, FoodNumber, nparam, &boundaries);
    // Rprintf("send_onlooker... Iter %d\n",iter);
    
    abc_mem_best_src(Foods, &persistance);
    // Rprintf("mem_best... Iter %d\n",iter);
    
    if (persistance > criter) break;
    abc_send_scout_bees(Foods, fn, &boundaries, FoodNumber);
    // Rprintf("send_scout... Iter %d\n",iter);
  }

  return(
    List::create(
      _["par"]=Foods["GlobalParams"],
      _["value"]=Foods["GlobalMin"],
      _["counts"]=iter,
      _["persistance"]=persistance
      )
    );
}

// [[Rcpp::export]]
double funRcpp(NumericVector x)
{
  return -cos(x[0])*cos(x[1])*exp(-(
    pow(x[0]-M_PI,2.0) + pow(x[1]-M_PI,2.0) ));
}

/*** R



fun <- function(x) {
  -cos(x[1])*cos(x[2])*exp(-((x[1] - pi)^2 + (x[2] - pi)^2))
}

library(microbenchmark)
library(ABCoptim)

message("Funcion en R")
x1<-abc_optimCpp(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200)
x2<-abc_optim(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200)
x1
x2

microbenchmark(
  abc_optimCpp(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200),
  abc_optim(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200),
  times=1
  )

message("Funcion en C")
x1<-abc_optimCpp(par=rep(0,2), fn=funRcpp, lb=-20, ub=20, criter=200)
x2<-abc_optim(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200)
x1
x2

microbenchmark(
  abc_optimCpp(par=rep(0,2), fn=funRcpp, lb=-20, ub=20, criter=200),
  abc_optim(par=rep(0,2), fn=fun, lb=-20, ub=20, criter=200),
  times=1
  )


*/

/* // [[Rcpp::export]] */



