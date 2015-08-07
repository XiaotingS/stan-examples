# A place to store stan example models

You can get stan [here](http://mc-stan.org/).

# Limited Dependent Variables
## Probit
The stan model [here](limited-dv/probit.stan) implements a probit model. It requires a response variable y coded as 0 or 1 and an x matrix of predictor variables (with a column of 1's if you want an intercept). The model returns beta coefficients that represent the marginal effect of a one unit change on the latent utility scale. It also returns estimates of the latent utility for each observation. Location is fixed by assuming that y=1 if ystar>0, and scale is fixed by assuming that the variance of the latent error term is 1.
