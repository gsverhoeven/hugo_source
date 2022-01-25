# Backwards Feature Selection Helper Functions (aka recursive feature elimination)

# this version only calculates feature importance for the model that includes all the features (the first)
rangerFuncs <-  list(summary = defaultSummary,
                     fit = function(x, y, first, last, ...) {
                       loadNamespace("ranger")
                       dat <- if(is.data.frame(x)) 
                         x else as.data.frame(x)
                       dat$.outcome <- y
                       # return a model object to generate preds
                       ranger::ranger(.outcome ~ ., 
                                      data = dat, 
                                      importance = if(first) "permutation" else "none", # we use permutation importance 
                                      probability = is.factor(y), # TRUE if the outcome is a factor
                                      write.forest = TRUE, # Save ranger.forest object, required for prediction
                                      ...)
                     },
                     pred = function(object, x)  {
                       if(!is.data.frame(x)) x <- as.data.frame(x)
                       out <- predict(object, x)$predictions
                       if(object$treetype == "Probability estimation") {
                         out <- cbind(pred = colnames(out)[apply(out, 1, which.max)],
                                      out)
                       } 
                       out
                     },
                     rank = function(object, x, y) {
                       if(length(object$variable.importance) == 0)
                         stop("No importance values available")
                       imps <- ranger:::importance(object)
                       vimp <- data.frame(Overall = as.vector(imps),
                                          var = names(imps))
                       rownames(vimp) <- names(imps)
                       
                       vimp <- vimp[order(vimp$Overall, decreasing = TRUE),, drop = FALSE]
                       vimp
                     },
                     selectSize = pickSizeTolerance, # instead of pickSizeBest
                     selectVar = pickVars)


rangerTuneFuncs <- rangerFuncs

# PM split off to separate rangerTuneFuncs.R
rangerTuneFuncs$fit <- function(x, y, first, last, ...){
    if(first){ 
      n_preds <- ncol(x)
      # check mtry at different orders of magnitude
      tune_grid <- expand.grid(mtry = round(exp(seq(log(1), log(n_preds), length.out= 3))), #length.out=sqrt(n_preds)))),
                               splitrule = "variance",
                               min.node.size = 5)

      train(x, y, method = "ranger", tuneGrid = tune_grid, verbose = TRUE, importance = "permutation",...)
    } else {
      n_preds <- ncol(x)
      # check mtry at different orders of magnitude
      tune_grid <- expand.grid(mtry = round(exp(seq(log(1), log(n_preds), length.out= 3))), #length.out=sqrt(n_preds)))),
                               splitrule = "variance",
                               min.node.size = 5)
      train(x, y, method = "ranger", tuneGrid = tune_grid, verbose = TRUE, importance = "none", ...)
    }
}

rangerTuneFuncs$pred <- function(object, x)  {
  if(!is.data.frame(x)) x <- as.data.frame(x)
  out <- predict(object, x)
  # Only works for Regression
  # if(object$treetype == "Probability estimation") {
  #   out <- cbind(pred = colnames(out)[apply(out, 1, which.max)],
  #                out)
  # }
  out
}

# stolen from caretFuncs
rangerTuneFuncs$rank <- function(object, x, y) {
  vimp <- varImp(object, scale = FALSE)$importance
  if(!is.data.frame(vimp)) vimp <- as.data.frame(vimp, stringsAsFactors = TRUE)
  if(object$modelType == "Regression") {
    vimp <- vimp[order(vimp[,1], decreasing = TRUE),,drop = FALSE]
  } else {
    if(all(levels(y) %in% colnames(vimp)) & !("Overall" %in% colnames(vimp))) {
      avImp <- apply(vimp[, levels(y), drop = TRUE], 1, mean)
      vimp$Overall <- avImp
    }
  }
  vimp <- vimp[order(vimp$Overall, decreasing = TRUE),, drop = FALSE]
  vimp$var <- rownames(vimp)
  vimp
}

# this version calculates new variable importance measures every time a model is fit
# has a higher computational cost

rangerFuncsRerank <-  list(summary = defaultSummary,
                          fit = function(x, y, first, last, ...) {
                            loadNamespace("ranger")
                            dat <- if(is.data.frame(x)) 
                              x else as.data.frame(x)
                            dat$.outcome <- y
                            ranger::ranger(.outcome ~ ., data = dat, 
                                           importance = "permutation", # ONLY DIFFERENCCE!!! WHAT WITH RERANK TRUE
                                           probability = is.factor(y),
                                           write.forest = TRUE,
                                           ...)
                          },
                          pred = function(object, x)  {
                            if(!is.data.frame(x)) x <- as.data.frame(x)
                            out <- predict(object, x)$predictions
                            if(object$treetype == "Probability estimation") {
                              out <- cbind(pred = colnames(out)[apply(out, 1, which.max)],
                                           out)
                            } 
                            out
                          },
                          rank = function(object, x, y) {
                            if(length(object$variable.importance) == 0)
                              stop("No importance values available")
                            imps <- ranger:::importance(object)
                            vimp <- data.frame(Overall = as.vector(imps),
                                               var = names(imps))
                            rownames(vimp) <- names(imps)
                            
                            vimp <- vimp[order(vimp$Overall, decreasing = TRUE),, drop = FALSE]
                            vimp
                          },
                          #selectSize = pickSizeBest,
                          selectSize  = pickSizeTolerance,
                          selectVar = pickVars)
