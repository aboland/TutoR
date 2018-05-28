# --- Visualisation

# The library within the tidyverse used for visualisations is the ggplot2 package
# If you have already loaded the tidyverse you do not need to reload ggplot2
library(ggplot2)


# - Data Frame

# We have not seen a data frame yet, a data frame is a rectangular colection of variables 
# This can be thought of as similar to a spreadsheet 
# We will first look at the `mpg` data frame which contains observations collected by the US 
# Environment Protection Agency on 38 models of car
# Look at the help file to see what the different columns represent
mpg
?mpg


# - Creating a plot

# The code below will create a plot which shows the relationship between 
# engine size (displ) and fuel efficiency (hwy)
# Before you run the code, what would you expect the reationship to be?
# Will cars with bigger engines use more fuel?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# We can convey more information in the data using the aesthetic in the plot
# For example, the colour the points can be mapped to  the class of each car
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# An alternative is to map the class to the transparency of the points using
# the alpha aesthetic
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Or the shape of the points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))


# - Other types of plots

# - Barplot 

# diamonds data
diamonds

# A simple barplot
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# A barplot with colour for the different type of cut
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# A barplot coloured by clarity
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# A barplot coloured by clarity and expanded to equal heights
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# A barplot coloured with clarity separated within each cut
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


# - Histogram

# A histogram of carat
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.01)

# A histogram with cut included as a colour
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)
