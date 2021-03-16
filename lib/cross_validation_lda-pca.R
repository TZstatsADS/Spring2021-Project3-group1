########################
### Cross Validation ###
########################

### author: Zhihang Xia
### Project 3


pca_lda.cv <- function(data, K){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  feature_train <- as.matrix(data[, -6007])
  label_train <- as.integer(data[, 6007])
  
  pca_train <- prcomp(feature_train)
  
  CPVE <- (cumsum((pca_train$sdev)^2)/sum((pca_train$sdev)^2))
  
  for (i in 1:length(CPVE)){
    while (CPVE[i] <= 0.9){
      i <- i+1
      a <- i
    }
    a
  }
  
  for (i in 1:length(CPVE)){
    while (CPVE[i] <= 0.999){
      i <- i+1
      b <- i
    }
    b
  }
  
  pca_train_b <- pca_train$x[,1:b]
  dat_train_b <- data.frame(pca_train_b, label_train)
  
  nRows <- nrow(dat_train_b)
  splitPlan <- kWayCrossValidation(nRows, K, NULL, NULL)
  
  acc_test <- rep(NA, K)
  acc_test_means <- rep(NA, b)
  
  for (j in a:b){
    data_new <- data.frame(dat_train_b[,1:j], label_train)
    feature_new <- data.frame(data_new[,-(j+1)])
    for (i in 1:K) {
      split <- splitPlan[[i]]
      model <- lda(label_train ~ ., data = data_new[split$train,])
      model.pred.cv <- predict(model, newdata = data.frame(feature_new[split$app,]))
      acc_test[i] <- mean(model.pred.cv$class == data_new['label_train'][split$app,])
    }
    acc_test_means[j] <- mean(acc_test)
  }
  return(acc_test_means)
}
