Tutorial 2: Data Visualisation
================

## Introduction

  - This interactive tutorial will give an introduction on how to use R
    to produce graphs such as scatterplots, bar charts, histograms and
    boxplots. The use of graphics can help with the interpretation of
    large datasets and enhance reports.

  - We will use the ggplot2 package, which is a member of the tidyverse
    package, to produce plots of our data.

  - This tutorial will introduce many techniques. For additional
    information and examples on how to use `ggplot2` to plot data, read
    the [data
    visualisation](http://r4ds.had.co.nz/data-visualisation.html)
    chapter from the [R for Data
    Science](http://r4ds.had.co.nz/index.html) book.

### Installing and Loading Packages

  - In order to run this interactive tutorial, you had to install a
    number of packages.

  - There are thousands of packages available for R, some more useful
    than others.

  - Packages can be installed using the `install.packages` command.
    
      - `install.packages("tidyverse")`

  - To then use the package you need to load it by typing the following:
    
      - `library(tidyverse)`

  - **Note:** you only need to install a package once, however, you need
    to load it every time you start a new session and want to use that
    package.

### `mpg` Dataset

  - R already has datasets available that we can graph.

  - For the beginning of this lesson we will use the `mpg` dataset from
    the tidyverse package.

  - It contains observations collected by the US Environmental
    Protection Agency on different car models.

  - Consult the helpfile which can be found
    <a href="https://ggplot2.tidyverse.org/reference/mpg.html" rel="noopener noreferrer" target="_blank">here</a>
    to find more information on the data, including a description of the
    variables.

  - Before we start to graph this dataset it is important to take a look
    at its contents.

<!-- end list -->

    ## # A tibble: 234 x 11
    ##    manufacturer model displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr> <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr>
    ##  1 audi         a4      1.8  1999     4 auto… f        18    29 p     comp…
    ##  2 audi         a4      1.8  1999     4 manu… f        21    29 p     comp…
    ##  3 audi         a4      2    2008     4 manu… f        20    31 p     comp…
    ##  4 audi         a4      2    2008     4 auto… f        21    30 p     comp…
    ##  5 audi         a4      2.8  1999     6 auto… f        16    26 p     comp…
    ##  6 audi         a4      2.8  1999     6 manu… f        18    26 p     comp…
    ##  7 audi         a4      3.1  2008     6 auto… f        18    27 p     comp…
    ##  8 audi         a4 q…   1.8  1999     4 manu… 4        18    26 p     comp…
    ##  9 audi         a4 q…   1.8  1999     4 auto… 4        16    25 p     comp…
    ## 10 audi         a4 q…   2    2008     4 manu… 4        20    28 p     comp…
    ## # … with 224 more rows

## Scatterplots

  - We will start by producing a basic scatterplot of the `displ`
    (engine displacement in litres) and `cty` (city miles per gallon)
    variables.

<img src="Tutorial_02_files/figure-gfm/firstScatterplot-1.png" style="display: block; margin: auto;" />

#### Exercise 1

**Produce a scatterplot with `displ` on the x-axis and `hwy` (highway
miles per gallon) on the y-axis.**

[Exercise 1 Solution](#exercise-1-solution)

### Graphing Template

`ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))`

  - The ggplot2 template takes the above form.
  - The data (`<DATA>`) is passed as part of the ggplot function.
  - The type of graph is defined by the function which follows
    (`<GEOM_FUNCTION>`).
      - We have seen previously the `geom_point` function which creates
        a scatterplot.
      - There are different functions which create other type of graphs
        such as a bar chart `geom_bar`.
  - The `<MAPPINGS>` component defines which variables are plotted and
    can control other parts of the graph like the colour, size, etc…

### Scatterplots with Colour

  - You can also produce scatterplots that are coloured.
  - In the scatterplot below we have now coloured the data points using
    the `drv` variable. This means that data points will be coloured
    based on whether the car is a front-wheel drive, rear-wheel drive or
    four-wheel
drive.

<img src="Tutorial_02_files/figure-gfm/colourScatter-1.png" style="display: block; margin: auto;" />

#### Exercise 2

**Colour the scatterplot created in Exercise 1 using the `class`
variable.**

[Exercise 2 Solution](#exercise-2-solution)

#### Note on colour

  - To colour all points in a plot the same colour, the argument must be
    outside the `aes` function.
  - Values inside the aes function are assumed to be variables.

#### Exercise 3

**Move the colour inside `aes` to see what happens.**

[Exercise 3
Solution](#exercise-3-solution)

<img src="Tutorial_02_files/figure-gfm/colourScatter_note-1.png" style="display: block; margin: auto;" />

### Other Scatterplot Effects

  - It is also possible to use variables to alter the shade and shape of
    scatterplots.
  - Below are some examples of
this.

<img src="Tutorial_02_files/figure-gfm/shade-1.png" style="display: block; margin: auto;" /><img src="Tutorial_02_files/figure-gfm/shade-2.png" style="display: block; margin: auto;" />

  - These are examples of just some of the changes you can make to
    scatterplots. Exploring the [help
    file](https://ggplot2.tidyverse.org/reference/geom_point.html) for
    `geom_point` will help you find out more about the function.

### Other Plots

#### Different geom Types

  - `geom_point` = scatterplot

  - `geom_bar` = barplot

  - `geom_histogram` = histogram

  - `geom_box` = boxplot

  - See RStudio’s
    [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
    for more information on different graph types and many other helpful
    tips.

## Barplots

### Diamonds data

  - `Diamonds` is a dataset containing the prices and other attributes
    of almost 54,000 diamonds.
  - Consult the help file
    [here](https://ggplot2.tidyverse.org/reference/diamonds.html) for an
    explanation of the variables contained in the dataset.

<!-- end list -->

    ## # A tibble: 53,940 x 10
    ##    carat cut       color clarity depth table price     x     y     z
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
    ##  1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
    ##  2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
    ##  3 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
    ##  4 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
    ##  5 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
    ##  6 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
    ##  7 0.24  Very Good I     VVS1     62.3    57   336  3.95  3.98  2.47
    ##  8 0.26  Very Good H     SI1      61.9    55   337  4.07  4.11  2.53
    ##  9 0.22  Fair      E     VS2      65.1    61   337  3.87  3.78  2.49
    ## 10 0.23  Very Good H     VS1      59.4    61   338  4     4.05  2.39
    ## # … with 53,930 more rows

### Basic Barplot

<img src="Tutorial_02_files/figure-gfm/basicBarplot-1.png" style="display: block; margin: auto;" />

\#\#\#\# Exercise 4

**Create a barplot of the `cut` variable.**

### Barplots with Colour

  - You can colour a barplot depending on the variable being plotted as
    shown
below:

<img src="Tutorial_02_files/figure-gfm/barplotColour-1.png" style="display: block; margin: auto;" />

  - Alternatively, you can colour the barplot using another
variable:

<img src="Tutorial_02_files/figure-gfm/barplotVarColour-1.png" style="display: block; margin: auto;" />

  - Another interesting barplot
iteration:

<img src="Tutorial_02_files/figure-gfm/otherBarplot-1.png" style="display: block; margin: auto;" />

## Histograms

### Basic Histogram

<img src="Tutorial_02_files/figure-gfm/basicHistogram-1.png" style="display: block; margin: auto;" />

#### Exercise 5

**Create a histogram of price but this time set the `binwidth` parameter
to 1000. What effect does this have on the resulting plot?**

## Boxplots

  - Boxplots are a very useful method of graphing data as they clearly
    show the distribution of data.
  - If you are unfamiliar with what a boxplot displays, a good
    explanation can be found
    [here](https://www.wellbeingatschool.org.nz/information-sheet/understanding-and-interpreting-box-plots).

### Basic Boxplot

<img src="Tutorial_02_files/figure-gfm/basicBoxplot-1.png" style="display: block; margin: auto;" />

### Boxplot with Colour

<img src="Tutorial_02_files/figure-gfm/colourBoxplot-1.png" style="display: block; margin: auto;" />

  - The legend to the right of the plot can be removed by using the
    `theme()` function.
      - Also note how the `mapping` argument will work when set inside
        `ggplot`.
      - The arguments are passed on to subsequent elements of the
plot.

<img src="Tutorial_02_files/figure-gfm/boxplotNoLegend-1.png" style="display: block; margin: auto;" />

## Styling

### Coordinates

#### Axis Range

  - It is possible to shorten or widen the range of both the x and y
    axis.  
  - Modify `xlim` and `ylims` to see how they effect the
plot.

<img src="Tutorial_02_files/figure-gfm/coord_simple-1.png" style="display: block; margin: auto;" />

  - It’s possible to specify more control on the axis using
    `scale_x_continuous` and `scale_y_continuous`.
      - The `limits` argument has the same effect as `xlim` and
        `ylim`.  
      - The `breaks` argument allows you to choose where to display
        numbers on the axes.
  - Look at the solution to see another example of choosing where to
    display
values.

<img src="Tutorial_02_files/figure-gfm/coord_advanced-1.png" style="display: block; margin: auto;" />

<img src="Tutorial_02_files/figure-gfm/coord_advanced-solution-1.png" style="display: block; margin: auto;" />

#### Axis Flip

  - The `coord_flip()` function will flip the x and y axis
    automatically.  
  - This is useful to display boxplots vertically.

#### Exercise 6

**Use `coord_flip()` to change the plot.**

### Labels

  - The `labs()` function is used to add title’s and labels to the plot.
      - `title` adds a main title.
      - `subtitle` adds additional detail in a smaller font beneath the
        title.
      - `caption` adds text at the bottom right of the plot, often used
        to describe the source of the data.

#### Exercise 7

**add a subtitle and caption to the plot below.**

  - You can also use `labs()` to replace the axis and legend titles.
  - It’s usually a good idea to replace short variable names with more
    detailed descriptions, and to include the
units.

<img src="Tutorial_02_files/figure-gfm/labels3-1.png" style="display: block; margin: auto;" />

### Themes

  - Themes change the default colours.

  - `theme_bw()`, `theme_light()`, `theme_classic()`, `theme_gray()` are
    just some examples.  

  - Change the code to try some of the different
themes.

<img src="Tutorial_02_files/figure-gfm/themes1-1.png" style="display: block; margin: auto;" />

#### Custom Theme

  - You can create your own custom theme.
  - After saving your team as a variable it can be used with any plot.
      - See `my_edge_theme` as an example of
this.

<img src="Tutorial_02_files/figure-gfm/Edge_theme-1.png" style="display: block; margin: auto;" />

### Facets

  - One way to add additional variables is with aesthetics (colour,
    shape, etc…). Another way, particularly useful for categorical
    variables, is to split your plot into facets, subplots that each
    display one subset of the data.

  - To facet your plot by a single variable, use `facet_wrap()`. The
    first argument of `facet_wrap()` should be a formula, which you
    create with `~` followed by a variable name (here “formula” is the
    name of a data structure in R, not a synonym for “equation”). The
    variable that you pass to `facet_wrap()` should be
discrete.

<img src="Tutorial_02_files/figure-gfm/facets1-1.png" style="display: block; margin: auto;" />

  - To facet your plot on the combination of two variables, add
    `facet_grid()` to your plot call. The first argument of
    `facet_grid()` is also a formula. This time the formula should
    contain two variable names separated by a
`~`.

<img src="Tutorial_02_files/figure-gfm/facets2-1.png" style="display: block; margin: auto;" />

<!-- - What plots does the following code make? What does . do? -->

<!-- ```{r ex-facets, exercise = TRUE, exercise.eval = FALSE} -->

<!-- ggplot(data = mpg) + -->

<!--   geom_point(mapping = aes(x = displ, y = hwy)) + -->

<!--   facet_grid(drv ~ .) -->

<!-- ggplot(data = mpg) + -->

<!--   geom_point(mapping = aes(x = displ, y = hwy)) + -->

<!--   facet_grid(. ~ cyl) -->

<!-- ``` -->

<!-- ```{r ex-facets-solution} -->

<!-- # The . refers to the dataset being used -->

<!-- # -->

<!-- # .$displ will access the displ variable -->

<!-- ``` -->

## Advanced

### Maps

  - This section uses the `maps` and `scales` packages.
  - `maps`
      - This packages contains maps which can be used to visualise
        geographical data.
  - `scales`
      - This package contains functions to improve axis labels and
        legends.
  - The code below loads some United States economic data, as well as
    map data for the US.  
  - We will cover some of the commands used below in later tutorials.

<!-- end list -->

    ## # A tibble: 86,284 x 41
    ##    CensusId State County TotalPop   Men Women Hispanic White Black Native
    ##       <dbl> <chr> <chr>     <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl>
    ##  1     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  2     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  3     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  4     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  5     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  6     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  7     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  8     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ##  9     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ## 10     1001 alab… autau…    55221 26745 28476      2.6  75.8  18.5    0.4
    ## # … with 86,274 more rows, and 31 more variables: Asian <dbl>,
    ## #   Pacific <dbl>, Citizen <dbl>, Income <dbl>, IncomeErr <dbl>,
    ## #   IncomePerCap <dbl>, IncomePerCapErr <dbl>, Poverty <dbl>,
    ## #   ChildPoverty <dbl>, Professional <dbl>, Service <dbl>, Office <dbl>,
    ## #   Construction <dbl>, Production <dbl>, Drive <dbl>, Carpool <dbl>,
    ## #   Transit <dbl>, Walk <dbl>, OtherTransp <dbl>, WorkAtHome <dbl>,
    ## #   MeanCommute <dbl>, Employed <dbl>, PrivateWork <dbl>,
    ## #   PublicWork <dbl>, SelfEmployed <dbl>, FamilyWork <dbl>,
    ## #   Unemployment <dbl>, long <dbl>, lat <dbl>, group <dbl>, order <int>

  - We can create a heatmap coloured according to *Income*.
  - Try and change *Income* to a different variable such as
    *Unemployment* or *MeanCommute*.
      - You may need to change the `labels` argument inside the
        `scales_fill_distiller`.
      - See the solution for an
example.

<img src="Tutorial_02_files/figure-gfm/maps-1.png" style="display: block; margin: auto;" />
<img src="Tutorial_02_files/figure-gfm/maps-solution-1.png" style="display: block; margin: auto;" />

### Animate `gganimate`

  - We will now look at the `gganimtte` package.

  - This can be used to create animations of data.

  - The data used here is [US Voter
    Data](https://github.com/rfordatascience/tidytuesday/tree/master/data/2018/2018-10-09),
    click on the link to learn more about the data.

<!-- end list -->

    ## # A tibble: 918 x 7
    ##       X1  year icpsr_state_code alphanumeric_st… state  votes
    ##    <dbl> <dbl>            <dbl>            <dbl> <chr>  <dbl>
    ##  1     2  2014               41                1 Alab… 1.19e6
    ##  2     3  2014               81                2 Alas… 2.85e5
    ##  3     4  2014               61                3 Ariz… 1.54e6
    ##  4     5  2014               42                4 Arka… 8.53e5
    ##  5     6  2014               71                5 Cali… 7.51e6
    ##  6     7  2014               62                6 Colo… 2.08e6
    ##  7     8  2014                1                7 Conn… 1.10e6
    ##  8     9  2014               11                8 Dela… 2.38e5
    ##  9    10  2014               55                9 Dist… 1.77e5
    ## 10    11  2014               43               10 Flor… 6.03e6
    ## # … with 908 more rows, and 1 more variable: eligible_voters <dbl>

  - The plot begins as a standard
ggplot.

<img src="Tutorial_02_files/figure-gfm/animate2-1.png" style="display: block; margin: auto;" />

#### Animation

  - We add to the ggplot to create the animation.
  - The `transtion_time` argument selects which variable to animate
    over.
  - Note `{round(frame-time)}` as part of the subtitle.
      - This is specific to gganimate.
      - The subtitle will change as the year changes.
  - **This chunk of code may take up to 60 seconds to
complete**

<img src="Tutorial_02_files/figure-gfm/animate-1.gif" style="display: block; margin: auto;" />

### Map Animation

  - We can combine the `maps` and `gganimate` packages.

  - The final animation looks at [US Wind Turbine
    Data](https://github.com/rfordatascience/tidytuesday/tree/master/data/2018/2018-11-06)

<!-- end list -->

    ## # A tibble: 58,123 x 24
    ##    case_id faa_ors faa_asn usgs_pr_id t_state t_county t_fips p_name p_year
    ##      <dbl> <chr>   <chr>        <dbl> <chr>   <chr>    <chr>  <chr>   <dbl>
    ##  1 3073429 <NA>    <NA>          4960 CA      Kern Co… 06029  251 W…   1987
    ##  2 3071522 <NA>    <NA>          4997 CA      Kern Co… 06029  251 W…   1987
    ##  3 3073425 <NA>    <NA>          4957 CA      Kern Co… 06029  251 W…   1987
    ##  4 3071569 <NA>    <NA>          5023 CA      Kern Co… 06029  251 W…   1987
    ##  5 3005252 <NA>    <NA>          5768 CA      Kern Co… 06029  251 W…   1987
    ##  6 3003862 <NA>    <NA>          5836 CA      Kern Co… 06029  251 W…   1987
    ##  7 3073370 <NA>    <NA>          4948 CA      Kern Co… 06029  251 W…   1987
    ##  8 3010101 <NA>    <NA>          5828 CA      Kern Co… 06029  251 W…   1987
    ##  9 3073324 <NA>    <NA>          4965 CA      Kern Co… 06029  251 W…   1987
    ## 10 3072659 <NA>    <NA>          5044 CA      Kern Co… 06029  251 W…   1987
    ## # … with 58,113 more rows, and 15 more variables: p_tnum <dbl>,
    ## #   p_cap <dbl>, t_manu <chr>, t_model <chr>, t_cap <dbl>, t_hh <dbl>,
    ## #   t_rd <dbl>, t_rsa <dbl>, t_ttlh <dbl>, t_conf_atr <dbl>,
    ## #   t_conf_loc <dbl>, t_img_date <chr>, t_img_srce <chr>, xlong <dbl>,
    ## #   ylat <dbl>

  - Notice below how the `ggplot` function is left blank
      - The *states* data and *turbine* data are used separately inside
        the plotting functions
  - **This chunk of code may take up to 60 seconds to
complete**

<img src="Tutorial_02_files/figure-gfm/wind-turbines-animation-1.gif" style="display: block; margin: auto;" />

# Solutions

### Exercise 1 Solution

<img src="Tutorial_02_files/figure-gfm/ex1-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise
1](#exercise-1)

### Exercise 2 Solution

<img src="Tutorial_02_files/figure-gfm/ex2-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise
2](#exercise-2)

### Exercise 3 Solution

<img src="Tutorial_02_files/figure-gfm/colourScatter_note-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise 3](#exercise-3)

### Exercise 4 Solution

``` r
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
```

<img src="Tutorial_02_files/figure-gfm/ex3-solution-static-1.png" style="display: block; margin: auto;" />

\[Back to Exercise 4\]\[Exercise
4\]

### Exercise 5 Solution

<img src="Tutorial_02_files/figure-gfm/ex4-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise
5](#exercise-5)

### Exercise 6 Solution

<img src="Tutorial_02_files/figure-gfm/coord-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise
6](#exercise-6)

### Exercise 7 Solution

<img src="Tutorial_02_files/figure-gfm/labels_title-solution-static-1.png" style="display: block; margin: auto;" />

[Back to Exercise 7](#exercise-7)
