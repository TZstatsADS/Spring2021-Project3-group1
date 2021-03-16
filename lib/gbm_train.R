train <- function(features, labels, w = NULL, num_trees, shrink){
  labels <- ifelse(labels == 2, 0, 1)
  model <- gbm(labels ~ .,
               distribution = "bernoulli",
               weights = w,
               data = data.frame(cbind(features, labels)), 
               n.trees = num_trees,
               interaction.depth = 1,
               n.minobsinnode = 10,
               shrinkage = shrink,
               keep.data = TRUE,
               verbose = FALSE)
  return(model)
}