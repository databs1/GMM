#'@name ModelMixte
#'@title Faire une modele mixte Mulitinomial et Gaussien
#'@param data data matrix
#'@param k number of clusters
#'@return liste avec les proportions(pi), parametres(alpha,mu,cov_list), probabilite a posteriori(tik),BIC,ICL
#'@export
modelMixte <- function(data,k){
  n = nrow(data)
  p = ncol(data)
  isquali = data[,which(sapply(data, is.factor)==TRUE)]
  data_qualitatif = data.frame(isquali)
  colnames(data_qualitatif) <- names(data_qualitatif)
  mod = length(which(sapply(data, is.factor)==TRUE))
  modalite = sapply(data,nlevels)
  modalite = modalite[which(modalite!=0)]
  cons = lapply(data_qualitatif, stats::contrasts, contrasts = FALSE)
  #tableau disjonctif complet
  dataq = as.data.frame(stats::model.matrix(~ .+0, data_qualitatif, contrasts.arg = cons))
  cluster = sample(k,n,replace=T) #initialisation des clusters qualitatifs
  data_clust = cbind(dataq,cluster)
  #calcule des alphas
  alpha = sapply(1:k,function(x)colMeans(subset(data_clust,data_clust$cluster==x)))
  alpha = alpha[-nrow(alpha),]
  ###
  data_quantitatif = data[,which(sapply(data, is.factor)==FALSE)]
  cov_list = rep(list(diag(n)),k)
  mat = stats::kmeans(data_quantitatif,k)
  vec = sapply(1:k,function(i)ifelse(mat$cluster==i,1,0))
  pi = rowSums(vec)
  mu = mat$centers
  cov_list  <- lapply(1:k,function(x) stats::cov(data_quantitatif[mat$cluster==x,]))
  ini=iter = 1
  itermax = 150
  LL=c();LL_nu=0
  while(iter <= itermax){
    # E-step
    if(is.array(alpha)!= F){
      sub_sum <- pi * sapply(1:k, function(c) mmmpdf(alpha[,c],dataq) * NPflow::mvnpdf(t(data_quantitatif), mu[c,], cov_list[c],Log=F))
    }else{
      sub_sum <- pi * sapply(1:k, function(c) mmmpdf(alpha,dataq) * NPflow::mvnpdf(t(data_quantitatif), mu[c,], cov_list[c],Log=F))
    }
    tik <- sub_sum / rowSums(sub_sum)
    LL[ini] = sum(round(log(rowSums(sub_sum)),4))
    if(LL_nu==LL[ini])break;#calcule pour la convergence
    LL_nu=LL[ini]
    # M-step
    pi <- colSums(tik)/sum(tik)
    mu <- t(sapply(1:k, function(c)  colSums(tik[, c] * data_quantitatif)/colSums(tik)[c]))
    for (k in 1:k){
      X = t(apply(data_quantitatif, 1, '-', mu[k,]))
      cov_list[[k]]  <- 1/ colSums(tik)[k] * t(X) %*% (X*tik[,k])
    }
    alpha = sapply(1:k,function(x) colSums(tik[,x] * dataq)/colSums(tik)[x])
    ini = ini + 1
    iter = iter + 1
  }
  numParams = (k*(p * (p + 1)/2 + p + 1) - 1) + sum((modalite-1) * ncol(dataq))
  BIC = -2*LL_nu + numParams*log(n)
  ICL = BIC -sum(tik * log(tik), na.rm=TRUE)
  if(is.array(alpha)!= F) alpha = lapply(1:k,function(x)split(alpha[,x], rep(1:length(modalite), modalite)))
  cluster = apply(tik,1,which.max)
  list(pi=pi,alpha = alpha,tik=tik,ICL=ICL,BIC=BIC,mu=mu,cov_list=cov_list,cluster = as.numeric(cluster))
}
mmmpdf <- function(alpha,Xi){
  matrixStats::rowProds(t(apply(Xi,1,function(x) alpha^x)))
}

