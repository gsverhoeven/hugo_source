# Complete procedure: RFE + tuning

RunRFEandTuneRF <- function(X, Y, ctrl_object = ctrl, run_nr = Sys.time(), outdir = "./")  {
  X <- data.table(X)
  # pick deciles if  more than 10 predictors
  if(ncol(X) >= 10){
    #subsets <- round(quantile(1:ncol(X), probs = seq(0, 0.9, 0.1)))
    subsets <- round(exp(seq(log(1), log(ncol(X)), length.out=sqrt(ncol(X)))))
  } else{ subsets <- 1:(ncol(X) - 1)}
  
  set.seed(1)
  print("starting the rfe procedure ..")
  varsel <- rfe(X, Y,
                sizes = subsets,
                rfeControl = ctrl_object)
  
  filename <- paste0("model_", run_nr,"_rfe.rds")
  saveRDS(varsel, paste0(outdir, filename))
  
  # step two: tune mtry for optimal set of predictors
  print("Tuning the model after feature elimination ...")
  # caret: list predictors used in the model
  preds <- predictors(varsel)
  Xrfe <- X[, preds, with = F]
  
  train.control <- trainControl(method = "repeatedcv",
                                number = 10, repeats = 1,
                                savePredictions = TRUE)
  
  # check mtry at different orders of magnitude
  rf.grid <- expand.grid(mtry = round(exp(seq(log(1), log(length(preds)), length.out=sqrt(length(preds))))),
                         splitrule = "variance",
                         min.node.size = 5)
  set.seed(1)
  fit <- train(x = Xrfe,
               y = Y,
               method = "ranger",
               trControl = train.control,
               tuneGrid = rf.grid)
  
  filename <- paste0("model_", run_nr, "_fit.rds")
  saveRDS(fit, paste0(outdir, filename))
  return(fit)
}