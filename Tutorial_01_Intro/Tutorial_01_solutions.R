
### Exercise 1
testScores <- matrix(c(70,43,81,59,75,59,88,63,68,46,83,61), nrow=4, ncol=3)
testScores

### Exercise 2
colnames(testScores) <- c("Jan", "Feb", "Mar")

rownames(testScores) <- c("Katie", "Robert","Niamh", "Nick")
testScores

### Exercise 3
Apr <- c(72,53,85,64)
testScores <- cbind(testScores, Apr)

Lucy <- c(61, 64, 70, 63)
testScores <- rbind(testScores, Lucy)
testScores

### Exercise 4
apply(testScores, 1, max)

### Exercise 5
testScores["Niamh", "Feb"] <- 78
testScores

### Exercise 6
testScores["Robert",] <- testScores["Robert",]*1.2
testScores


