# --- Introduction to the tidyverse

# Our first task is to install the pacakge
# This only needs to be done the very first time you use this script
install.packages("tidyverse")

# If you have run the install.packages command previously
# you need only run the next line to load the package
library(tidyverse)

# The tidyverse uses a concept known as pipes (%>%) 
population %>% summary

# this is equal to
summary(population)

# For more complex lines of code when you are applying
# many functions together, the pipe syntax makes it much
# easier to read the code