########################
###KNN Classification###
########################

### Author: Yandong Xiong
### Project 3

KNN <- function(dat_train, dat_test, run_knn = FALSE, run_knn_pred = FALSE){
  
  # run knn if run_knn == TRUE, otherwise load "knn.RData"
  if(run_knn) {
    
    ctrl <- trainControl(method="repeatedcv",repeats = 3)
    tm_knn_train <- system.time({knn <- caret::train(label ~ ., data = dat_train, method = "knn", 
                                             trControl = ctrl, preProcess = c("center","scale"), tuneLength = 10)})

    save(knn, file="../output/knn.RData")
    save(tm_knn_train, file = "../output/tm_knn_train.RData")
    
    }else{
      
      load(file = "../output/knn.RData")
      load(file = "../output/knn_pred.RData")
  
      }
  
  # make predictions on knn if run_knn_pred == TRUE, otherwise load "knn_pred.RData"
  if(run_knn_pred){
    
    tm_knn_pred <- system.time({knn_pred <- predict(knn, newdata = dat_test)})
    knn_prob_pred <- predict(knn, newdata = dat_test, type="prob")
    
    save(knn_pred, file="../output/knn_pred.RData")
    save(knn_prob_pred, file="../output/knn_prob_pred.RData")
    save(tm_knn_pred, file="../output/tm_knn_pred.RData")
    
    }else{
      
      load(file = "../output/knn_pred.RData")
      load(file="../output/knn_prob_pred.RData")
      load(file="../output/tm_knn_pred.RData")
  
      }
  
  knnROC <- roc(dat_test$label, knn_prob_pred[,1])
  
  return(list(knn = knn, tm_knn_train = tm_knn_train, knn_pred = knn_pred,
         tm_knn_pred = tm_knn_pred, knn_prob_pred = knn_prob_pred,
         knnROC = knnROC))
}