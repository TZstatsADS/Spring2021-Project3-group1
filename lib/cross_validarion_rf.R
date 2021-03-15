cv.function_rf <- function(features, labels, K, ntree, mtry){
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
  #reweight <- FALSE
  for (i in 1:K){
    ## create features and labels for train/test
    feature_train_cv <- features[s != i,]
    feature_test_cv <- features[s == i,]
    label_train_cv <- labels[s != i]
    label_test_cv <- labels[s == i]
    
    label_train_cv <- ifelse(label_train_cv == 2, 1, 2) #flip
    
    
    ## model training
    model_train <- train_RF(feature_train_cv, label_train_cv, ntree=ntree, mtry=mtry)
    
    ## make predictions
    label_pred <- test_RF(model_train, feature_test_cv)
    label_pred1 <- ifelse(label_pred == 2, 0, 1)
    label_test_cv1<-ifelse(label_test_cv==2, 0, 1)
    
    #prob_pred <- label_pred$predictions
    cv.error[i] <- 1 - (sum(label_pred1== label_test_cv1) / length(label_test_cv1))
    #prob_pred <- test(model_train,feature_test_cv, pred.type="prob")
    #tpr.fpr <- roc(prob_pred, label_test_cv)
   
    #cv.AUC[i] <- tpr.fpr$auc
  }
  return(c(mean(cv.error),sd(cv.error)))
 # return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}