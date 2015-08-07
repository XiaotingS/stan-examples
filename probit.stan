// Runs a probit model
// returns beta coefficients and ystar, a measure of latent utility 

data {
  int<lower=0> N; // number of obs
  int<lower=0> K; // number of predictors
  int<lower=0,upper=1> y[N]; // outcomes
  vector<lower=-1,upper=1>[N] sign; // y = 0 -> -1, y = 1 -> 1
  matrix[N, K] x; // predictor variables
}
parameters {
  vector[K] beta; // beta coefficients
}
model {
  vector[N] mu;
  beta ~ normal(0, 10); // normal priors for betas
  mu <- x*beta; 
  for (n in 1:N) mu[n] <- Phi(mu[n]);
  y ~ bernoulli(mu);
}
generated quantities {
  vector[N] ystar;
  {
    vector[N] mu;
    mu <- x * beta;
    for (n in 1:N) {
      real draw;
      draw <- not_a_number();
      if (sign[n] == 1) while(!(draw > 0)) draw <- normal_rng(mu[n], 1);
      else while(!(draw < 0)) draw <- normal_rng(mu[n], 1);
      ystar[n] <- draw;
    }
  }
}
