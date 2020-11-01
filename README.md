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
- the values of the BIC and ICL criteria<br/><br/>
Data needs to contain quantitative and qualitative data or only qualitative data only,it doesn't run if only quantitative data is supplied. Use Kmeans instead for clustering with quantitative data. <br/><br/>
devtools::install_github("databs1/GMM") #to install the package<br/>
library(ModeleMix)  &nbsp;&nbsp;#load library<br/>
modelMixte(data,k) <br/>
vignette("Mixmod") &nbsp;&nbsp;#To see examples 
