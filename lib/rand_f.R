
############Random forest functions############
#########By Shuqi Yu###########


library(randomForest)


<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
train_RF <- function(features, labels, ntree, mtry){
  labels <- ifelse(labels == 2, 0, 1)
  labels <- as.character(labels)
  labels <- as.factor(labels)
  model <- randomForest(features, labels, ntree=ntree, mtry=mtry )
  return(model)
}

<<<<<<< Updated upstream
train_rf <- function(features, labels, w=NULL, ntree, md){
  labels <- ifelse(labels == 2, 0, 1)

  model <- ranger(formula = labels ~ .,
                        data = data.frame(cbind(features, labels)),
                  		num.trees = ntree, #hyperparameter 1
                  		case.weights = w, # weights
                  		importance = "none",
                 		write.forest = TRUE,
                  # probability = FALSE,
                 		min.node.size = 1,
                  		max.depth = md, #hyperparameter 2
                  		regularization.factor = 1,
                  		verbose = F,
                  		classification = T,
             		 	x = NULL,
                  		y = NULL
    				   )
  
  
  return(model)
}

test <- function(model, features, pred.type){
  res <- predict(model, newx = features, type = pred.type)
=======
test_rf <- function(model, features){
  res <- predict(model, data.frame(features), type = "response", predict.all = F)
>>>>>>> Stashed changes
  return(res)
}

test_RF <- function(model, features){
  res <- predict(model, features)
  return(res)
}


<<<<<<< Updated upstream
cv.function_rf <- function(features, labels, K, ntree, mtry, reweight = FALSE){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  n <- dim(features)[1]
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)
  
  for (i in 1:K){
    ## create features and labels for train/test
    feature_train <- features[s != i,]
    feature_test <- features[s == i,]
    label_train <- labels[s != i]
    label_test <- labels[s == i]
    
    ## sample reweighting
    weight_train <- rep(NA, length(label_train))
    weight_test <- rep(NA, length(label_test))
    for (v in unique(labels)){
      weight_train[label_train == v] = 0.5 * length(label_train) / length(label_train[label_train == v])
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training
    if (reweight){
      model_train <- train_RF(feature_train, label_train, ntree , mtry)
    } else {
      model_train <- train_RF(feature_train, label_train, ntree , mtry)
    }
    
    ## make predictions
    label_pred <- as.integer(test(model_train, feature_test, pred.type = 'class'))
    prob_pred <- test(model_train, feature_test, pred.type = 'response')
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}
=======
>>>>>>> Stashed changes
