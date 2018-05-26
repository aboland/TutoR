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



