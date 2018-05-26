# --- Introduction to R

# Comments begin with a # symbol
# These lines will not be run as part of the script


# Highlight the code on the line below and click Run at the top left
# of the screen to run this piece of code
print("Hello World")
# You should see the output in the console window


# - Simple operations

2 + 3
4 * 5
1 / 3
log(10)


# - Variables

# You can assign variables to names
my_variable <- 4

# Calling the variable will return the value
my_variable

# You can also assign a set of variables
# A set of variables is written using c(var1, var2, var3)
my_set <- c(1, 4, 6)
my_set


# - Functions

# R has many built in functions to perform various operations
# There are also many packages available which have other useful functions
mean(my_set)
max(my_set)
seq(1, 10)

one_to_ten <- seq(1, 10)
length(one_to_ten)

# There are help files for all functions. The help files will explain
# what the function shoudl do and what arguments should/can be given.
# Help files can be accesed using ?
?mean

# The helpfile explains the mean function and the available arguments
# There is an optional argument na.rm, this removes NA values. A NA value
# is a blank entry
my_set2 <- c(3, 4, 5, NA)
my_set2

# What happens when we try to calculate the mean of a set of variables which
# contain an NA entry?
mean(my_set2)
# The additional arguments can fix this
mean(my_set2, na.rm = TRUE)


# - Further examples

# Variables can be different types such as strings
character_vector <- c("Hello", "World")

# Certain functions will only work with particular types of variables
mean(character_vector)
tolower(character_vector)

# Check the helpfiles to understand what these functions are doing
paste(character_vector, collapse = " ")
gsub("o", "", character_vector)
sort(my_set, decreasing = TRUE)
