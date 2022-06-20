bootstrap_r_squared <- function(obs, pred, n = 1000){
  if(length(obs) != length(pred)) stop("obs and pred differ in length")
  n_obs <- length(obs)
  r_squared <- c()
  for(i in 1:n) {
    indices <- sample(1:n_obs, n_obs, replace = TRUE)
    r_squared[i] <- cor(obs[indices],pred[indices])^2
  }
  
  r_squared
}

bootstrap_accuracy <- function(obs, pred, n = 1000){
  if(length(obs) != length(pred)) stop("obs and pred differ in length")
  n_obs <- length(obs)
  accuracy <- c()
  for(i in 1:n) {
    indices <- sample(1:n_obs, n_obs, replace = TRUE)
    accuracy[i] <- mean(obs[indices] == pred[indices])
  }
  accuracy
}
