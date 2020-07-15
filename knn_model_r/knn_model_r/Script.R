library(ggvis)
library(class)

# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"),
                 header = FALSE)

# Print first lines
#head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# Check the result
#iris

# Iris scatter plot
iris %>% ggvis(~Sepal.Length, ~ Sepal.Width, fill = ~Species) %>% layer_points()

# Advantage of setting a seed is that you can get the same sequence of random numbers 
set.seed(1234)

ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.67, 0.33))

# Compose training set
iris.training <- iris[ind == 1, 1:4]

# Inspect training set
#head(iris.training)

# Compose test set
iris.test <- iris[ind==2, 1:4]

# Inspect test set
#head(iris.test)

# Compose `iris` training labels
iris.trainLabels <- iris[ind == 1, 5]

# Inspect result
#print(iris.trainLabels)

# Compose `iris` test labels
iris.testLabels <- iris[ind == 2, 5]

# Inspect result
#print(iris.testLabels)

# Build the model
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k = 3)

# Inspect `iris_pred`
#iris_pred

# Put `iris.testLabels` in a data frame
irisTestLabels <- data.frame(iris.testLabels)

# Merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(iris_pred, iris.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

# Inspect `merge` -> check 29th row
merge