#'@name plot_cluster
#'@title Representation graphique des clusters avec les donnees
#'@param data data matrix
#'@param clusters numeric vector
#'@examples
#'#data = data("iris")
#'#fit <- modelMixte(data,k)
#'#plot_cluster(data,fit$cluster)
#'
#'@export
plot_cluster <- function(data,clusters){
  graphics::plot(data,col=clusters)
}
