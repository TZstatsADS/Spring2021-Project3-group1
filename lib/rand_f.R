
############Random forest functions############
#########By Shuqi Yu###########


library(randomForest)



train_RF <- function(features, labels, ntree, mtry){
  labels <- ifelse(labels == 2, 0, 1)
  labels <- as.character(labels)
  labels <- as.factor(labels)
  model <- randomForest(features, labels, ntree=ntree, mtry=mtry )
  return(model)
}




test <- function(model, features, pred.type){
  res <- predict(model, newx = features, type = pred.type)
}



test_RF <- function(model, features){
  res <- predict(model, features)
  return(res)
}


