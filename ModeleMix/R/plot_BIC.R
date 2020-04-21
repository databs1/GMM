#'@name plotBIC
#'@title Representation graphique du BIC pour les clusters
#'@param data data matrix
#'@param k number of clusters
#'@examples
#'#k=3
#'#data = data("heterodata")
#'#plot_BIC(data,k)
#'
#'@export
plot_BIC <- function(data,k){
  exe = sapply(1:k,function(i) modelMixte(data,i))
  BIC = sapply(1:k, function(x) exe[,x]$BIC)
  graphics::plot(BIC,col=c(1:k),type="p",xlab="Nombre de clusters")
}
