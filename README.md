# GMM
The model considered is a mixture between a Gaussian and multinomial, with conditional independence between the categorical variables
and the quantitative variables. The expectation–maximization (EM) algorithm will be used for inference of the model.
The clustering function takes as input:
- the data set
- the number of clusters
- the number of initializations of the EM algorithm (by specifying a default value)
The algorithm returns:
- the posterior probabilities for each individual belonging to each online cluster
- the partitions estimated by maximum a posteriori
- the proportions, means and variance of each cluster
- the values of the BIC and ICL criteria
