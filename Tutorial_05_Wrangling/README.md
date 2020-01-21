
# Tutorial 5: Data Wrangling

## Dates and Times

  - This week’s tutorial will focus on how to deal with dates and times
    and also introduce functions which can be used to clean data.

  - Dates and times can come in many different forms. We will look at
    three functions which can be used to format dates and times in R:
    `parse_datetime()`, `parse_date()` and `parse_hm()`.

### `parse_datetime()`

  - The `parse_datetime()` function formats both the date and time in
    one step.  
  - The function expects an ISO8601 date-time. ISO8601 is an
    international standard in which the components of a date are sorted
    as follows: year, month, day, hour, minute, second.

<!-- end list -->

``` r
parse_datetime("2018-11-17T190711")
```

    ## [1] "2018-11-17 19:07:11 UTC"

  - If you don’t add the time into the function, the time is assumed to
    be midnight.

<!-- end list -->

``` r
parse_datetime("20170319")
```

    ## [1] "2017-03-19 UTC"

### `parse_date()`

  - `parse_date()` formats the date only.

  - The function requires a four digit year, a - or /, the month, a - or
    /, then the day.

<!-- end list -->

``` r
parse_date("2015-12-11")
```

    ## [1] "2015-12-11"

### `parse_hm()`

  - `parse_hm()` is used for formatting times.

  - You will need to install and load the `hms` package to use this
    function.

  - The functions takes the format hours then minutes seperated by a
    `:`.

  - To include seconds you will need to use the `parse_hms()` function.

<!-- end list -->

``` r
parse_hm("02:15")
```

    ## 02:15:00

``` r
parse_hms("21:09:23")
```

    ## 21:09:23

## Gather/Spread

  - Tidy datasets are much easier to work with in R. When initially
    reading in a dataset look at how the data is laid out. It is always
    much easier to tidy up data before starting your analysis as opposed
    to trying to work around messy data or clean up as you go along.

  - There are three golden rules of a tidy dataset:
    
    1.  Each variable should have its own column.
    2.  Each observation should have its own row.
    3.  Each value should have its own cell.

  - The `gather()` and `spread()` functions can be used to tidy data.

### `gather()`

  - An issue in some datasets is that sometimes the column names are the
    values of a variable, as opposed to the name of a variable.
  - An example of this can be seen in `table 1` shown below where the
    column names `a` and `b` represent values of the `drug` variable,
    and each row represents two observations, not one.

<!-- end list -->

    ##     name  a  b
    ## 1 Arthur 67 56
    ## 2   Mary 80 90
    ## 3  Frank 64 50
    ## 4 Sharon 81 87

  - To tidy this dataset we need to gather the two columns into two new
    variables.  
  - To do this we need to establish three seperate parameters:
    1.  The columns which represent the values of a variable and not the
        variable itself. For this instance, those columns are `a` and
        `b`.
    2.  The `key`: this is the name of the variable whose values form
        the column names from point 1. In our example the variable in
        question is called `drug`.
    3.  The `value`: this is the variable whose values are in the cells
        corresponding to columns in point 1. In table 1 this is
        `heartrate`.
  - These parameters are used in the `gather()` function as shown below:

<!-- end list -->

``` r
tidyTable1 <- gather(table1,'a', 'b', key = drug, value = heartrate)
tidyTable1
```

    ##     name drug heartrate
    ## 1 Arthur    a        67
    ## 2   Mary    a        80
    ## 3  Frank    a        64
    ## 4 Sharon    a        81
    ## 5 Arthur    b        56
    ## 6   Mary    b        90
    ## 7  Frank    b        50
    ## 8 Sharon    b        87

  - Alternatively this function can be written as follows:

<!-- end list -->

``` r
tidyTable1 <- table1 %>%
    gather('a', 'b', key = drug, value = heartrate)
tidyTable1
```

    ##     name drug heartrate
    ## 1 Arthur    a        67
    ## 2   Mary    a        80
    ## 3  Frank    a        64
    ## 4 Sharon    a        81
    ## 5 Arthur    b        56
    ## 6   Mary    b        90
    ## 7  Frank    b        50
    ## 8 Sharon    b        87

  - The `%>%` symbol is known as a pipe. It is a symbol which is
    exclusive to the tidyverse package. For more complex lines of code
    when you are applying many functions together, the pipe syntax makes
    it much easier to read the code. However, the use of pipes is not a
    necessity in R. To find out more about pipes read the read the
    [pipes](https://r4ds.had.co.nz/pipes.html#pipes) chapter from the [R
    for Data Science](http://r4ds.had.co.nz/index.html) book.

### `spread()`

  - Spreading is the opposite of gathering. It is used when an
    observation is scattered across multiple rows in a dataset.

  - For example in table2 below, an observation is a person on a
    particular drug, but each observation is spread across two rows.

<!-- end list -->

    ##      name drug           type  result
    ## 1  Arthur    a      heartrate      67
    ## 2    Mary    a      heartrate      80
    ## 3   Frank    a      heartrate      64
    ## 4  Sharon    a      heartrate      81
    ## 5  Arthur    a blood pressure  140/90
    ## 6    Mary    a blood pressure  160/10
    ## 7   Frank    a blood pressure   90/60
    ## 8  Sharon    a blood pressure  140/90
    ## 9  Arthur    b      heartrate      56
    ## 10   Mary    b      heartrate      90
    ## 11  Frank    b      heartrate      50
    ## 12 Sharon    b      heartrate      87
    ## 13 Arthur    b blood pressure   70/40
    ## 14   Mary    b blood pressure 179/109
    ## 15  Frank    b blood pressure   99/64
    ## 16 Sharon    b blood pressure  159/99

  - This time around to tidy up the data we need to identify two
    parameters:
    1.  The `key`: this is the column which contains the names of the
        variables. For `table2`, this is `type`.
    2.  The `value`: this is the column which contains the values for
        the variables from part 1. This is the `result` column in our
        example.
  - These parameters are used in the `spread()` function as follows:

<!-- end list -->

``` r
tidyTable2 <- table2 %>%
    spread(key = type, value = result)
tidyTable2
```

    ##     name drug blood pressure heartrate
    ## 1 Arthur    a         140/90        67
    ## 2 Arthur    b          70/40        56
    ## 3  Frank    a          90/60        64
    ## 4  Frank    b          99/64        50
    ## 5   Mary    a         160/10        80
    ## 6   Mary    b        179/109        90
    ## 7 Sharon    a         140/90        81
    ## 8 Sharon    b         159/99        87

## Separate/Unite

### `separate()`

  - In some case you may wish to split one variable into two separate
    variables.  
  - Take `table3` for example, the result parameter contains both the
    population and the GDP for each of the countries.

<!-- end list -->

    ##   country year        result
    ## 1 Ireland 2018   4720234/383
    ## 2 Ireland 2017   4702364/333
    ## 3      UK 2018 66043875/3028
    ## 4      UK 2017 65986342/3780
    ## 5  France 2018 67190324/2776
    ## 6  France 2017 67078375/2582
    ## 7   Italy 2018 60480921/2234
    ## 8   Italy 2017 60397321/1935

  - The following code will seperate the `result` variable into two new
    variables: `population` and `GDP`.

<!-- end list -->

``` r
table3Separate <- 
  table3 %>% 
  separate(result, into = c("population", "GDP"))

table3Separate
```

    ##   country year population  GDP
    ## 1 Ireland 2018    4720234  383
    ## 2 Ireland 2017    4702364  333
    ## 3      UK 2018   66043875 3028
    ## 4      UK 2017   65986342 3780
    ## 5  France 2018   67190324 2776
    ## 6  France 2017   67078375 2582
    ## 7   Italy 2018   60480921 2234
    ## 8   Italy 2017   60397321 1935

  - By default, the `separate()` function splits values wherever it sees
    a non-alphanumeric character (i.e. a character that isn’t a number
    or letter). In our example this was the point where there was a
    forward slash. However, it is possible to specify a character to
    separate a column by using the `sep` argument in the function.

<!-- end list -->

``` r
table3Separate <- 
  table3 %>% 
  separate(result, into = c("population", "GDP"), sep = "/")

table3Separate
```

    ##   country year population  GDP
    ## 1 Ireland 2018    4720234  383
    ## 2 Ireland 2017    4702364  333
    ## 3      UK 2018   66043875 3028
    ## 4      UK 2017   65986342 3780
    ## 5  France 2018   67190324 2776
    ## 6  France 2017   67078375 2582
    ## 7   Italy 2018   60480921 2234
    ## 8   Italy 2017   60397321 1935

#### Exercise 1

**Using the `californiaFires` data. Seperate the `damage` variable into
two separate variables: `acresBurned` and `costOfDamage`.**

[Exercise 1 Solution](#exercise-1-solution)

  - The `sep` argument can also be set to a number which indicates the
    position at which to split the column.

<!-- end list -->

``` r
table3SplitYear <- 
  table3Separate %>% 
  separate(year, into = c("century", "year"), sep = 2)

table3SplitYear
```

    ##   country century year population  GDP
    ## 1 Ireland      20   18    4720234  383
    ## 2 Ireland      20   17    4702364  333
    ## 3      UK      20   18   66043875 3028
    ## 4      UK      20   17   65986342 3780
    ## 5  France      20   18   67190324 2776
    ## 6  France      20   17   67078375 2582
    ## 7   Italy      20   18   60480921 2234
    ## 8   Italy      20   17   60397321 1935

  - Examine the code and results below to see if you can determine what
    the negative `sep` value does to the resulting dataframe.

<!-- end list -->

``` r
table3Separate  %>% 
     separate(population, into = c("millions", "thousands"), sep = -6)
```

    ##   country year millions thousands  GDP
    ## 1 Ireland 2018        4    720234  383
    ## 2 Ireland 2017        4    702364  333
    ## 3      UK 2018       66    043875 3028
    ## 4      UK 2017       65    986342 3780
    ## 5  France 2018       67    190324 2776
    ## 6  France 2017       67    078375 2582
    ## 7   Italy 2018       60    480921 2234
    ## 8   Italy 2017       60    397321 1935

#### Exercise 2

**Using the data frame created in Exercise 1, split the `costOfDamage`
into `millions` and `thousands`.**

[Exercise 2 Solution](#exercise-2-solution)

### `unite()`

  - The `unite()` function is the exact opposite of the `seperate()`
    function. It is used to combine two columns to make one column.

<!-- end list -->

``` r
table3SplitYear %>%
  unite(year, century, year)
```

    ##   country  year population  GDP
    ## 1 Ireland 20_18    4720234  383
    ## 2 Ireland 20_17    4702364  333
    ## 3      UK 20_18   66043875 3028
    ## 4      UK 20_17   65986342 3780
    ## 5  France 20_18   67190324 2776
    ## 6  France 20_17   67078375 2582
    ## 7   Italy 20_18   60480921 2234
    ## 8   Italy 20_17   60397321 1935

  - The function separates the two values by a `_` by default. This can
    be changed using the `sep` parameter. In this case we do not want
    anything separating the two values so we set `sep=""`:

<!-- end list -->

``` r
table3SplitYear %>%
  unite(year, century, year, sep = "")
```

    ##   country year population  GDP
    ## 1 Ireland 2018    4720234  383
    ## 2 Ireland 2017    4702364  333
    ## 3      UK 2018   66043875 3028
    ## 4      UK 2017   65986342 3780
    ## 5  France 2018   67190324 2776
    ## 6  France 2017   67078375 2582
    ## 7   Italy 2018   60480921 2234
    ## 8   Italy 2017   60397321 1935

#### Exercise 3

**Using the dataframe created in Exercise 2, combine the
`NUMBER.OF.FIRES` column with the `acresBurned` column, naming that
column `fireDamage`. Make sure the two values are separated by a `/` in
the new column.**

[Exercise 3
Solution](#exercise-3-solution)

<!-- ## Update 16 April 2019 -->

<!-- There are 2 new functions in the tidyr package, a package which is part of the tidyverse.   -->

<!-- The functions were created as a more intuative replacement for `gather()` and `spread()`. -->

<!-- To get use of the functions now (16/4/19), you will need to install the dev version of tidyr.  This can be done using `devtools::install_github("tidyverse/tidyr")`. -->

<!-- An explaination can be found [here](https://tidyr.tidyverse.org/dev/articles/pivot.html).   -->

<!-- ### `pivot_longer()` -->

<!-- ### `pivot_wider()` -->

## Relational Data

Often when conducting data analysis you will have deal with multiple
different sets of data. It may be necessary to combine these different
tables for the sake of your analysis. The name relational data comes
from the fact that when combining different datasets it is the
relationship between the datasets that is important.

A database is one of the most common uses of relational data.

### Keys

  - A key is a variable which is used to connect two datasets. It is
    important that a key uniquely identifies an observation. Names and
    id numbers are commonly used as keys.  
  - The figure below depicts a set of relational datasets. What are the
    keys in each table?

![Image source:
<https://docs.microsoft.com/en-us/azure/architecture/data-guide/relational-data/>](images/example-relational.png)

  - There are two main kinds of keys; *primary keys* and *foreign keys*.
      - A *primary key* uniquely identifies each observation in a
        particular table.  
      - A *foreign key* is usually a primary key from one table that
        appears as a column in another where the first table has a
        relationship to the second.

### Flight Data

  - The `nycflights13` package contains five different datasets that
    relate to one another:
      - `flights`  
      - `airlines`  
      - `airports`  
      - `planes`  
      - `weather`  
  - Can you determine the columns (keys) which relate each table to one
    another?

<!-- end list -->

``` r
flights
```

    ## # A tibble: 336,776 x 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ##  1  2013     1     1      517            515         2      830
    ##  2  2013     1     1      533            529         4      850
    ##  3  2013     1     1      542            540         2      923
    ##  4  2013     1     1      544            545        -1     1004
    ##  5  2013     1     1      554            600        -6      812
    ##  6  2013     1     1      554            558        -4      740
    ##  7  2013     1     1      555            600        -5      913
    ##  8  2013     1     1      557            600        -3      709
    ##  9  2013     1     1      557            600        -3      838
    ## 10  2013     1     1      558            600        -2      753
    ## # … with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
    ## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>

``` r
planes
```

    ## # A tibble: 3,322 x 9
    ##    tailnum  year type       manufacturer  model  engines seats speed engine
    ##    <chr>   <int> <chr>      <chr>         <chr>    <int> <int> <int> <chr> 
    ##  1 N10156   2004 Fixed win… EMBRAER       EMB-1…       2    55    NA Turbo…
    ##  2 N102UW   1998 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  3 N103US   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  4 N104UW   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  5 N10575   2002 Fixed win… EMBRAER       EMB-1…       2    55    NA Turbo…
    ##  6 N105UW   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  7 N107US   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  8 N108UW   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ##  9 N109UW   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ## 10 N110UW   1999 Fixed win… AIRBUS INDUS… A320-…       2   182    NA Turbo…
    ## # … with 3,312 more rows

  - A relationship diagram of the tables is shown below:

![Image source:
<https://r4ds.had.co.nz/relational-data.html>](images/relational-nycflights.png)

  - The primary key in the `flights` dataset is the `tailnum` variable.
    It is important that you ensure that your primary key is unique for
    every observation in that table. For example, you wouldn’t want to
    have a dataset of student data with two students having the same
    student id, if this was the case then the student id wouldn’t
    uniquely identify each observation and would not be a primary key.
  - It is good practice to check if a variable you think may be a
    primary key is unique for all observations. You can do so as
    follows:

<!-- end list -->

``` r
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)
```

    ## # A tibble: 0 x 2
    ## # … with 2 variables: tailnum <chr>, n <int>

### Exercise

**Exercise: Identify the primary key in the `airlines` table and verify
that it is unique for all observations.**

``` r
airlines %>% 
  count(carrier) %>% 
  filter(n > 1)
```

    ## # A tibble: 0 x 2
    ## # … with 2 variables: carrier <chr>, n <int>

### Primary Key

  - The `flights` table lacks a primary key. It is sometimes useful when
    performing an analysis on relational data to include a primary key
    if one doesn’t exist. You can do this easily using the `cbind()`
    function.

<!-- end list -->

``` r
uniqueID <- c(1:nrow(flights))
flights <- cbind(uniqueID, flights)
```

## Mutating Joins

  - We can us the relationships between the tables to combine data from
    one table to another.  

  - There are four different kinds of joins:
    
      - An inner join  
      - A left join  
      - A right join  
      - A full join

  - An **inner join** will join all observation from table a to table b
    by matching the keys between the two tables. An inner join will only
    keep the observations which have matching keys in **both** tables.
    For example if table a contained keys x, y, z and table b had keys
    w, x, y, then only the observations with keys x and y would be kept
    after the join.

  - A **left join** keeps all the observations in table a but only keeps
    the observations from table b which match with the keys from table
    a. Using the same example as above the observations with keys x, y
    and z would remain after performing a left join on tables a and b.

  - A **right join** is the exact opposite of a left join and will keep
    all the observations in table b but only the observations from table
    a which match with the keys from table b.

  - A **full join** keeps all observations from both tables.

  - Venn diagrams are commonly used to describe these joins:

![“Image source: www.dofactory.com”](images/sql-joins.png)

  - For example take the two tables `flights` and `airlines`. The
    primary key `carrrier` in the `airlines` table is a foreign key in
    the `flights` table. The left join function can be used to join the
    two tables as follows:

<!-- end list -->

``` r
flightsLJ <- 
  flights %>%
  left_join(airlines, by = "carrier")

head(flightsLJ)
```

    ##   uniqueID year month day dep_time sched_dep_time dep_delay arr_time
    ## 1        1 2013     1   1      517            515         2      830
    ## 2        2 2013     1   1      533            529         4      850
    ## 3        3 2013     1   1      542            540         2      923
    ## 4        4 2013     1   1      544            545        -1     1004
    ## 5        5 2013     1   1      554            600        -6      812
    ## 6        6 2013     1   1      554            558        -4      740
    ##   sched_arr_time arr_delay carrier flight tailnum origin dest air_time
    ## 1            819        11      UA   1545  N14228    EWR  IAH      227
    ## 2            830        20      UA   1714  N24211    LGA  IAH      227
    ## 3            850        33      AA   1141  N619AA    JFK  MIA      160
    ## 4           1022       -18      B6    725  N804JB    JFK  BQN      183
    ## 5            837       -25      DL    461  N668DN    LGA  ATL      116
    ## 6            728        12      UA   1696  N39463    EWR  ORD      150
    ##   distance hour minute           time_hour                   name
    ## 1     1400    5     15 2013-01-01 05:00:00  United Air Lines Inc.
    ## 2     1416    5     29 2013-01-01 05:00:00  United Air Lines Inc.
    ## 3     1089    5     40 2013-01-01 05:00:00 American Airlines Inc.
    ## 4     1576    5     45 2013-01-01 05:00:00        JetBlue Airways
    ## 5      762    6      0 2013-01-01 06:00:00   Delta Air Lines Inc.
    ## 6      719    5     58 2013-01-01 05:00:00  United Air Lines Inc.

  - The flights table now has 21 columns with the `carrier` variable as
    the last column. The `carrier` column isn’t visible in the R console
    as the dataset is too wide. To see all the variables use the
    `View()` function.

### Exercise

**Exercise 2: Create a new smaller `flights` dataset which only contains
the `flight`, `origin`, `dest` and `tailnum` variables and call it
`flights2`. Then left join the `planes` table to `flights2` so that
`flights2` will now contain all the information about the planes used in
each flight.**

``` r
flights2 <- select(flights, flight, origin, dest, tailnum)
flights2 <- flights2 %>%
  left_join(planes, by = "tailnum")
head(flights2)
```

    ##   flight origin dest tailnum year                    type manufacturer
    ## 1   1545    EWR  IAH  N14228 1999 Fixed wing multi engine       BOEING
    ## 2   1714    LGA  IAH  N24211 1998 Fixed wing multi engine       BOEING
    ## 3   1141    JFK  MIA  N619AA 1990 Fixed wing multi engine       BOEING
    ## 4    725    JFK  BQN  N804JB 2012 Fixed wing multi engine       AIRBUS
    ## 5    461    LGA  ATL  N668DN 1991 Fixed wing multi engine       BOEING
    ## 6   1696    EWR  ORD  N39463 2012 Fixed wing multi engine       BOEING
    ##       model engines seats speed    engine
    ## 1   737-824       2   149    NA Turbo-fan
    ## 2   737-824       2   149    NA Turbo-fan
    ## 3   757-223       2   178    NA Turbo-fan
    ## 4  A320-232       2   200    NA Turbo-fan
    ## 5   757-232       2   178    NA Turbo-fan
    ## 6 737-924ER       2   191    NA Turbo-fan

  - When joining two tables the keys in the two tables may not have the
    same name in both tables. For example the `airports` table has a
    variable `faa` that contains the FAA code for each airport. When
    joining this table to the `flights` table you will notice that the
    `faa` variable matches to two variables in the `flights` table:
    `origin` and `dest`. Therefore you must specify the variable you
    wish to join the tables on as follows:

<!-- end list -->

``` r
flightsLJ2 <- flights %>% 
                left_join(airports, c("origin" = "faa"))
head(flightsLJ2)
```

    ##   uniqueID year month day dep_time sched_dep_time dep_delay arr_time
    ## 1        1 2013     1   1      517            515         2      830
    ## 2        2 2013     1   1      533            529         4      850
    ## 3        3 2013     1   1      542            540         2      923
    ## 4        4 2013     1   1      544            545        -1     1004
    ## 5        5 2013     1   1      554            600        -6      812
    ## 6        6 2013     1   1      554            558        -4      740
    ##   sched_arr_time arr_delay carrier flight tailnum origin dest air_time
    ## 1            819        11      UA   1545  N14228    EWR  IAH      227
    ## 2            830        20      UA   1714  N24211    LGA  IAH      227
    ## 3            850        33      AA   1141  N619AA    JFK  MIA      160
    ## 4           1022       -18      B6    725  N804JB    JFK  BQN      183
    ## 5            837       -25      DL    461  N668DN    LGA  ATL      116
    ## 6            728        12      UA   1696  N39463    EWR  ORD      150
    ##   distance hour minute           time_hour                name      lat
    ## 1     1400    5     15 2013-01-01 05:00:00 Newark Liberty Intl 40.69250
    ## 2     1416    5     29 2013-01-01 05:00:00          La Guardia 40.77725
    ## 3     1089    5     40 2013-01-01 05:00:00 John F Kennedy Intl 40.63975
    ## 4     1576    5     45 2013-01-01 05:00:00 John F Kennedy Intl 40.63975
    ## 5      762    6      0 2013-01-01 06:00:00          La Guardia 40.77725
    ## 6      719    5     58 2013-01-01 05:00:00 Newark Liberty Intl 40.69250
    ##         lon alt tz dst            tzone
    ## 1 -74.16867  18 -5   A America/New_York
    ## 2 -73.87261  22 -5   A America/New_York
    ## 3 -73.77893  13 -5   A America/New_York
    ## 4 -73.77893  13 -5   A America/New_York
    ## 5 -73.87261  22 -5   A America/New_York
    ## 6 -74.16867  18 -5   A America/New_York

## Filtering Joins

  - Filtering joins are similar to mutating joins but they affect the
    observations in the tables, not the variables.

  - There are two different types of filtering joins:
    
      - `semi_join(x, y)`: this keeps all the observations in table x
        which have a match in table y.  
      - `anti_join(x, y)`: this keeps all the observations in table x
        which do **not** have a match in table y.  

  - For example perhaps you wanted to find out the top five airports
    with the most outward flights. When you have this information you
    then want all the flight information which just relates to flights
    leaving the five most popular airports. This can be done as follows:

<!-- end list -->

``` r
top5origins <- flights %>%
  count(origin, sort = TRUE) %>%
  head(5)

flightsTop5 <- flights %>% 
  semi_join(top5origins)
```

    ## Joining, by = "origin"

``` r
head(flightsTop5) 
```

    ##   uniqueID year month day dep_time sched_dep_time dep_delay arr_time
    ## 1        1 2013     1   1      517            515         2      830
    ## 2        2 2013     1   1      533            529         4      850
    ## 3        3 2013     1   1      542            540         2      923
    ## 4        4 2013     1   1      544            545        -1     1004
    ## 5        5 2013     1   1      554            600        -6      812
    ## 6        6 2013     1   1      554            558        -4      740
    ##   sched_arr_time arr_delay carrier flight tailnum origin dest air_time
    ## 1            819        11      UA   1545  N14228    EWR  IAH      227
    ## 2            830        20      UA   1714  N24211    LGA  IAH      227
    ## 3            850        33      AA   1141  N619AA    JFK  MIA      160
    ## 4           1022       -18      B6    725  N804JB    JFK  BQN      183
    ## 5            837       -25      DL    461  N668DN    LGA  ATL      116
    ## 6            728        12      UA   1696  N39463    EWR  ORD      150
    ##   distance hour minute           time_hour
    ## 1     1400    5     15 2013-01-01 05:00:00
    ## 2     1416    5     29 2013-01-01 05:00:00
    ## 3     1089    5     40 2013-01-01 05:00:00
    ## 4     1576    5     45 2013-01-01 05:00:00
    ## 5      762    6      0 2013-01-01 06:00:00
    ## 6      719    5     58 2013-01-01 05:00:00

**Exercise: Find the five most popular destinations and obtain the
flight data for only the flights going to those five destinations.**

``` r
top5dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(5)

flightsTop5dest <- flights %>% 
  semi_join(top5dest)
```

    ## Joining, by = "dest"

``` r
head(flightsTop5dest)
```

    ##   uniqueID year month day dep_time sched_dep_time dep_delay arr_time
    ## 1        5 2013     1   1      554            600        -6      812
    ## 2        6 2013     1   1      554            558        -4      740
    ## 3        9 2013     1   1      557            600        -3      838
    ## 4       10 2013     1   1      558            600        -2      753
    ## 5       13 2013     1   1      558            600        -2      924
    ## 6       16 2013     1   1      559            559         0      702
    ##   sched_arr_time arr_delay carrier flight tailnum origin dest air_time
    ## 1            837       -25      DL    461  N668DN    LGA  ATL      116
    ## 2            728        12      UA   1696  N39463    EWR  ORD      150
    ## 3            846        -8      B6     79  N593JB    JFK  MCO      140
    ## 4            745         8      AA    301  N3ALAA    LGA  ORD      138
    ## 5            917         7      UA    194  N29129    JFK  LAX      345
    ## 6            706        -4      B6   1806  N708JB    JFK  BOS       44
    ##   distance hour minute           time_hour
    ## 1      762    6      0 2013-01-01 06:00:00
    ## 2      719    5     58 2013-01-01 05:00:00
    ## 3      944    6      0 2013-01-01 06:00:00
    ## 4      733    6      0 2013-01-01 06:00:00
    ## 5     2475    6      0 2013-01-01 06:00:00
    ## 6      187    5     59 2013-01-01 05:00:00

**Exercise: Use the anti-join function to find out if any airlines have
no flights in the `flights` dataset.**

``` r
airlines %>% 
  anti_join(flights, by = "carrier")
```

    ## # A tibble: 0 x 2
    ## # … with 2 variables: carrier <chr>, name <chr>

## Set Operators

  - Another method of comparing two datasets is the use of set
    operators.  
  - Set operators only work if the two datasets you are comparing have
    the same variables in each.  
  - There are three different kinds of set operators:
      - `intersect(x, y)`- returns all observations which are in both
        table x and table y.  
      - `union(x, y)`- returns the unique observations in table x and
        y.  
      - `setdiff(x, y)`- returns all observations in table x but not in
        y.

<br><br>

# Solutions

### Exercise 1 Solution

``` r
# californiaFiresData <- read_csv("californiaFires.csv")
californiaFiresData1 <- 
  californiaFiresData %>% 
  separate(damage, into = c("acresBurned", "costOfDamage"), sep = "/")

head(californiaFiresData1)
```

    ##   X YEAR NUMBER.OF.FIRES acresBurned costOfDamage
    ## 1 1 1933            1994      129210       318636
    ## 2 2 1934            2338      363052       563710
    ## 3 3 1935            1447      127262       165543
    ## 4 4 1936            3805      756696      1877147
    ## 5 5 1937            2907       71312       151584
    ## 6 6 1938            4150      221061       404225

[Back to Exercise 1](#exercise-1)

### Exercise 2 Solution

``` r
californiaFiresData2 <- 
  californiaFiresData1  %>% 
  separate(costOfDamage, into = c("millions", "thousands"), sep = -6)

head(californiaFiresData2)
```

    ##   X YEAR NUMBER.OF.FIRES acresBurned millions thousands
    ## 1 1 1933            1994      129210             318636
    ## 2 2 1934            2338      363052             563710
    ## 3 3 1935            1447      127262             165543
    ## 4 4 1936            3805      756696        1    877147
    ## 5 5 1937            2907       71312             151584
    ## 6 6 1938            4150      221061             404225

[Back to Exercise 2](#exercise-2)

### Exercise 3 Solution

``` r
californiaFiresData3 <- 
  californiaFiresData2 %>%
  unite(fireDamage, NUMBER.OF.FIRES, acresBurned, sep = "/")

head(californiaFiresData3)
```

    ##   X YEAR  fireDamage millions thousands
    ## 1 1 1933 1994/129210             318636
    ## 2 2 1934 2338/363052             563710
    ## 3 3 1935 1447/127262             165543
    ## 4 4 1936 3805/756696        1    877147
    ## 5 5 1937  2907/71312             151584
    ## 6 6 1938 4150/221061             404225

[Back to Exercise 3](#exercise-3)
