########################
##Trees Classification##
########################

### Author: Yandong Xiong
### Project 3

Tree <- function(dat_train, dat_test, run_tree = FALSE){
  
  # installing and loading required packages
  if(!require("rpart")){
    install.packages("rpart")
  }
  if(!require("pROC")){
    install.packages("pROC")
  }
  require(rpart)
  require(pROC)
  
  # run Tree if run_trees == TRUE, otherwise load "trees.RData"
  if(run_tree){
    
    # Fit a decision tree using rpart
    # Note: when you fit a tree using rpart, the fitting routine automatically
    # performs 10-fold CV and stores the errors for later use 
    # (such as for pruning the tree)
    tm_tree <- system.time({tree = rpart(as.factor(label) ~ ., data = dat_train, method = "class")})

    save(tree, file = "../output/tree.RData")
    save(tm_tree, file = "../output/tm_tree.RData")
    
  }else{
    
    load(file = "../output/tree.RData")
    load(file = "../output/tm_tree.RData")
  
    }
  
  # find best value of cost complexity
  min_cp = tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"]
  
  # pruning tree using best cp
  tree_prune = prune(tree, cp = min_cp)
  
  # make predictions
  tm_tree_pred <- system.time({tree_pred = predict(tree_prune, dat_test, type = "class")})
  tree_prob_pred = predict(tree_prune, dat_test, type = "prob")
  
  treeROC = roc(dat_test$label, tree_prob_pred[,1])
  
  return(list(tree = tree, tm_tree = tm_tree, min_cp = min_cp, tree_prune = tree_prune, tree_pred = tree_pred, 
         tm_tree_pred = tm_tree_pred, tree_prob_pred = tree_prob_pred, treeROC = treeROC))
  
}
