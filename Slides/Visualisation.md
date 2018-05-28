Visualisation
================
Aidan Boland
28/5/2018

ggplot2
-------

<br> <br>

-   For creating plots of data we will use the [ggplot2](http://ggplot2.tidyverse.org/) package.
-   We will follow the [data visualisation](http://r4ds.had.co.nz/data-visualisation.html) chapter from the [R for Data Science](http://r4ds.had.co.nz/index.html) book.

Scatterplots
============

mpg Data
--------

-   `mpg` contains observations collected by the US Environment Protection Agency on 38 models of car

<br>

-   We will begin with the relationship between engine size (`displ`) and fuel efficiency (`hwy`)
-   What would you expect the reationship to be?

<br>

Basic Scatterplot
-----------------

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```

<img src="Visualisation_files/figure-markdown_github/plot1-1.png" style="display: block; margin: auto;" />

<br>

Plot Template
-------------

``` r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```

-   The ggplot2 template takes the above form
-   The data (`<DATA>`) is passed as part of the ggplot function
-   The type of graph is defined by the function which follows (`<GEOM_FUNCTION>`)
    -   We have seen previously the `geom_point` function which creates a scatterplot
    -   There are different functions which create other type of graphs such as a bar chart `geom_bar`
-   The `<MAPPINGS>` component defines which variables are plotted and can control other parts of the graph like the colour, size, etc...

<br>

Scatterplot with Colour
-----------------------

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
```

<img src="Visualisation_files/figure-markdown_github/plot_colour-1.png" style="display: block; margin: auto;" />

<br>

Scatterplot with Shade
----------------------

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
```

<img src="Visualisation_files/figure-markdown_github/plot_shade-1.png" style="display: block; margin: auto;" />

<br>

Scatterplot with Shape
----------------------

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
```

<img src="Visualisation_files/figure-markdown_github/plot_shape-1.png" style="display: block; margin: auto;" />

<br>

Other Plots
===========

Different geom Types
--------------------

-   `geom_point` scatterplot
-   `geom_bar` barplot
-   `geom_histogram` histogram
    <br>

Diamonds data
-------------

-   Diamonds is a dataset containing the prices and other attributes of almost 54,000 diamonds.

<br>
<center>
</center>
<br>

Barplot
-------

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
```

<img src="Visualisation_files/figure-markdown_github/bar1-1.png" style="display: block; margin: auto;" />

Barplot - Category by colour
----------------------------

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
```

<img src="Visualisation_files/figure-markdown_github/bar2-1.png" style="display: block; margin: auto;" />

Barplot - Fill using another variable
-------------------------------------

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
```

<img src="Visualisation_files/figure-markdown_github/bar3-1.png" style="display: block; margin: auto;" />

Barplot - Fill using another variable
-------------------------------------

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
```

<img src="Visualisation_files/figure-markdown_github/bar4-1.png" style="display: block; margin: auto;" />

Barplot - Fill using another variable
-------------------------------------

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
```

<img src="Visualisation_files/figure-markdown_github/bar5-1.png" style="display: block; margin: auto;" />

Histogram
---------

``` r
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.01)
```

<img src="Visualisation_files/figure-markdown_github/hist1-1.png" style="display: block; margin: auto;" />

Histogram
---------

``` r
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)
```

<img src="Visualisation_files/figure-markdown_github/hist2-1.png" style="display: block; margin: auto;" />
