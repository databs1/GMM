## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "exemple d'application"
)

## ----fit-----------------------------------------------------------------
library(ModeleMix)
library(Rmixmod)
data("heterodata")
fit <- ModeleMix::modelMixte(heterodata,3)
print(fit)

## ----plotcluster---------------------------------------------------------
ModeleMix::plot_cluster(heterodata,fit$cluster)

## ----plotbic-------------------------------------------------------------
ModeleMix::plot_BIC(heterodata,4)

## ----plotcluster2--------------------------------------------------------
data("iris")
fit <- ModeleMix::modelMixte(iris,3)
ModeleMix::plot_cluster(iris,fit$cluster)


