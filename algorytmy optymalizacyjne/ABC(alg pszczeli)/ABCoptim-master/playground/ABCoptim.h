#ifndef abcoptim_h
#define abcoptim_h

#include <Rinternals.h>
#include <Rcpp.h>

using namespace Rcpp;

/* Constant definitions */
#define MAX_D 10000
#define ABC_MAX_LIMIT 1e+300
typedef double (*ptrFun)(NumericVector x);

using namespace Rcpp;

/* Constant definitions */
#define MAX_D 10000
#define ABC_MAX_LIMIT 1e+300
typedef double (*ptrFun)(NumericVector x);

/* Boundaries */
struct abc_boundaries {
  double lb[MAX_D];
  double ub[MAX_D];
};


/* Uniform RNG between lb;ub*/
double abc_unif(double lb=0.0, double ub=1.0) {
  return ((double)rand()/(double)RAND_MAX)*(ub - lb) + lb;
}

/* Computes fitness */
double abc_calc_fit(double x) {  
  if (x >= 0) return 1/(x + 1);
	else return(1 + fabs(x));
}

/* The best food source is memorized */
void abc_mem_best_src(
  List& Foods,
  int * persistance)
{
	// Poiting to the foods position en valfun
	NumericMatrix foods_pos = Foods["pos"];
	NumericVector foods_val = Foods["val"];
	int nfoods = foods_val.size();
	int nparam = foods_pos.ncol();

	/* Pointing to the globmin pos and valfun */
	NumericVector global_pos  = Foods["GlobalParams"];
	NumericVector global_val  = Foods["GlobalMin"];

	int change = 0;
	for(int i=0;i<nfoods;i++)
		if (foods_val[i] < global_val[0]) {
      			change+=1;
			/* Found a new global minimum */
			global_val[0] = foods_val[i];
			for(int j=0;j<nparam;j++)
				global_pos[j] = foods_pos(i,j);
        
		}
	if (!change) *persistance+=1;

	return ;
}

/* A food source is chosen with the probability which is proportioal to its 
quality. Different schemes can be used to calculate the probability values For
example prob(i)=fitness(i)/sum(fitness) or in a way used in the metot below
prob(i)=a*fitness(i)/max(fitness)+b probability values are calculated by using
fitness values and normalized by dividing maximum fitness value
*/
// [[Rcpp::export]]
void abc_calc_prob(List& Foods,int FoodNumber) {

  NumericVector fitness = Foods["fitness"];
  NumericVector prob    = Foods["prob"];
  double maxfit  = fitness[0];
  
  for(int i=1;i<FoodNumber;i++) 
    if (fitness[i] > maxfit) maxfit = fitness[i];
  
  for(int i=0;i<FoodNumber;i++)
    prob[i] = (0.9*(fitness[i]/maxfit) + .1);
    
  return ;
}

/* Initializes */
List abc_initialize_Cpp(
  int nfoods,
  int nparam,
  ptrFun objfun,
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
      
    val[i]     = (*objfun)(pos(i,_));
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

void abc_init_Cpp(
  int index,
	List& Foods,
	ptrFun objfun,
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
	foods_val[index] = (*objfun)(foods_pos(index,_));
	foods_fit[index] = abc_calc_fit(foods_val[index]);
	foods_trl[index] = 0;

	return ;
}

void abc_send_empl_bees_Cpp(
  List& Foods, 
  int nfoods, int nparam,
  abc_boundaries * b, 
  ptrFun objfun
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
    
    new_val = (*objfun)(new_foods_pos);
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
void abc_send_onlooker_bees_Cpp(
  List& Foods, 
  ptrFun objfun,
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
      
      double ObjValSol  = (*objfun)(solution(i,_));
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
void abc_send_scout_bees_Cpp(
  List& Foods,
  ptrFun objfun,
  abc_boundaries * b,
  int FoodNumber)
{
  
  NumericVector trials = Foods["trials"];
  int maxtrialindex    = 1;
  int limit            = Foods["limit"];
  for (int i=0;i<FoodNumber;i++)
    if (trials[i] > trials[maxtrialindex]) maxtrialindex = i;
  
  if (trials[maxtrialindex] >= limit)
    abc_init_Cpp(maxtrialindex, Foods, objfun, b);
  
  
  return;
}

List abc_optim_Cpp(
  NumericVector par,
  ptrFun fn,
  NumericVector lb,
  NumericVector ub,
  int FoodNumber   = 20,
  int limit        = 100,
  int maxCycle     = 1000,
  int criter       = 50
  )
{
  /* Number of parameters  */
  int nparam = par.size();
  
  /* Boundaries */
  int lsize=lb.size();
  int usize=ub.size();
  
  if (lsize != usize)
    stop("Error in boundaries: Sizes do not match");
  
  double lb0[nparam];
  double ub0[nparam];
  if (lsize == 1)
  {
    for(int i=0;i<nparam;i++)
    {
          lb0[i] = lb[0];
          ub0[i] = ub[0];
    }
  }
  else
  {
    for(int i=0;i<nparam;i++)
    {
          lb0[i] = lb[i];
          ub0[i] = ub[i];
    }
  }
  
  abc_boundaries boundaries;
  for(int i=0;i<nparam;i++)
  {
    boundaries.ub[i] = ub0[i];
    boundaries.lb[i] = lb0[i];
  }
  
  List Foods = abc_initialize_Cpp(FoodNumber, nparam, fn, &boundaries, limit);
  
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
    
    abc_send_empl_bees_Cpp(Foods, FoodNumber, nparam, &boundaries, fn);
    // Rprintf("send_empl... Iter %d\n",iter);
    
    abc_calc_prob(Foods, FoodNumber);
    // Rprintf("calc_prob... Iter %d\n",iter);
    
    abc_send_onlooker_bees_Cpp(Foods, fn, FoodNumber, nparam, &boundaries);
    // Rprintf("send_onlooker... Iter %d\n",iter);
    
    abc_mem_best_src(Foods, &persistance);
    // Rprintf("mem_best... Iter %d\n",iter);
    
    if (persistance > criter) break;
    abc_send_scout_bees_Cpp(Foods, fn, &boundaries, FoodNumber);
    // Rprintf("send_scout... Iter %d\n",iter);
  }

  /* Rebuilding boundaries */
  NumericVector ubN(nparam);
  NumericVector lbN(nparam);
  for(int i=0;i<nparam;i++)
  {
    ubN[i] = ub0[i];
    lbN[i] = lb0[i];
  }

  return(
    List::create(
      _["par"]=Foods["GlobalParams"],
      _["value"]=Foods["GlobalMin"],
      _["counts"]=iter,
      _["persistance"]=persistance,
      _["lb"]=lbN,
      _["ub"]=ubN
      )
    );
}

#endif