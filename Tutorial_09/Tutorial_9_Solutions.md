Tutorial 9: Solutions
================

### Exercise 1

``` r
countryIndex <- sample(1:nrow(alcoholData), 10)
randomSubsetAlcohol <-alcoholData[countryIndex,]
ggplot(randomSubsetAlcohol, aes(total_litres_of_pure_alcohol, fct_reorder(country,total_litres_of_pure_alcohol ))) + geom_point()
```

![](Tutorial_9_Solutions_files/figure-markdown_github/unnamed-chunk-2-1.png)

### Exercise 2

``` r
levels(thanksgivingMeal$main_dish_other)
```

    ##  [1] "A turkey and a ham. Always."                                                          
    ##  [2] "A wild game bird which changes every year."                                           
    ##  [3] "alternate turkey & ham"                                                               
    ##  [4] "always different"                                                                     
    ##  [5] "Both turkey and a vegetarian nut loaf"                                                
    ##  [6] "changes every year"                                                                   
    ##  [7] "Chicken Dressing"                                                                     
    ##  [8] "Duck"                                                                                 
    ##  [9] "fish"                                                                                 
    ## [10] "goose"                                                                                
    ## [11] "gumbo"                                                                                
    ## [12] "head cheese"                                                                          
    ## [13] "Homemade vegan entree"                                                                
    ## [14] "It varies, ham or turkey or boston butt"                                              
    ## [15] "Lentil Loaf"                                                                          
    ## [16] "No predictable main dish"                                                             
    ## [17] "prime rib"                                                                            
    ## [18] "Prime Rib"                                                                            
    ## [19] "Restaurant with various choices."                                                     
    ## [20] "salmon"                                                                               
    ## [21] "seafood"                                                                              
    ## [22] "some kind of lentil or vegetable stew"                                                
    ## [23] "steak"                                                                                
    ## [24] "Steak"                                                                                
    ## [25] "This year we are having baked lasagna, diff every year"                               
    ## [26] "Turkey & Ham or Seafood Hotdish (a secret family recipe)."                            
    ## [27] "Turkey and Ham"                                                                       
    ## [28] "Turkey and Vegetarian Turkey"                                                         
    ## [29] "turkey, ham. vegetarian for me."                                                      
    ## [30] "Varies"                                                                               
    ## [31] "Varies significantly by year as one group of people we tend to be with are vegetarian"
    ## [32] "Venison"

``` r
thanksgivingMeal$main_dish_other <- fct_recode(thanksgivingMeal$main_dish_other, "Varies"="Varies significantly by year as one group of people we tend to be with are vegetarian", "Varies"= "It varies, ham or turkey or boston butt", "Varies"= "always different", "Varies"="changes every year", "Varies"= "This year we are having baked lasagna, diff every year", "Steak"= "steak", "Prime Rib"= "prime rib","Turkey and Ham"= "A turkey and a ham. Always.")  
levels(thanksgivingMeal$main_dish_other)
```

    ##  [1] "Turkey and Ham"                                           
    ##  [2] "A wild game bird which changes every year."               
    ##  [3] "alternate turkey & ham"                                   
    ##  [4] "Varies"                                                   
    ##  [5] "Both turkey and a vegetarian nut loaf"                    
    ##  [6] "Chicken Dressing"                                         
    ##  [7] "Duck"                                                     
    ##  [8] "fish"                                                     
    ##  [9] "goose"                                                    
    ## [10] "gumbo"                                                    
    ## [11] "head cheese"                                              
    ## [12] "Homemade vegan entree"                                    
    ## [13] "Lentil Loaf"                                              
    ## [14] "No predictable main dish"                                 
    ## [15] "Prime Rib"                                                
    ## [16] "Restaurant with various choices."                         
    ## [17] "salmon"                                                   
    ## [18] "seafood"                                                  
    ## [19] "some kind of lentil or vegetable stew"                    
    ## [20] "Steak"                                                    
    ## [21] "Turkey & Ham or Seafood Hotdish (a secret family recipe)."
    ## [22] "Turkey and Vegetarian Turkey"                             
    ## [23] "turkey, ham. vegetarian for me."                          
    ## [24] "Venison"

### Exercise 3

``` r
levels(thanksgivingMeal$main_prep_other)
```

    ##  [1] "1 fried 1 roasted"                
    ##  [2] "always different"                 
    ##  [3] "baked, grilled, fried"            
    ##  [4] "Barbecue"                         
    ##  [5] "Barbeque"                         
    ##  [6] "BBQ'd"                            
    ##  [7] "Broiled"                          
    ##  [8] "Cooked in bourbon and then smokes"
    ##  [9] "Cooked on a Weber Charcoal Grill" 
    ## [10] "fried"                            
    ## [11] "Fried and one baked"              
    ## [12] "grilled"                          
    ## [13] "Grilled"                          
    ## [14] "Grilled on the Weber"             
    ## [15] "Having a Smoked Turkey this year" 
    ## [16] "like soup"                        
    ## [17] "O"                                
    ## [18] "on the grill"                     
    ## [19] "Restaurant with various choices." 
    ## [20] "Ronco"                            
    ## [21] "Rotisserie"                       
    ## [22] "roulade"                          
    ## [23] "Slow cooked"                      
    ## [24] "smoked"                           
    ## [25] "Smoked"                           
    ## [26] "store smoked"                     
    ## [27] "stovetop"                         
    ## [28] "Try a new technique yearly."      
    ## [29] "Varies"                           
    ## [30] "Varies as per above"              
    ## [31] "various ways"                     
    ## [32] "We eat out"

``` r
thanksgivingMeal$main_prep_other <- fct_collapse(thanksgivingMeal$main_prep_other, "Varies" = c("various ways", "Varies as per above","Try a new technique yearly.","always different"), "Barbecue"= c("Barbeque", "BBQ'd"), "Grilled"= c("grilled", "Grilled on the Weber","Cooked on a Weber Charcoal Grill","on the grill"), "Smoked"= c("smoked", "store smoked", "Having a Smoked Turkey this year", "Cooked in bourbon and then smokes"), "Eat Out"= c("We eat out", "Restaurant with various choices.") )
levels(thanksgivingMeal$main_prep_other)
```

    ##  [1] "1 fried 1 roasted"     "Varies"               
    ##  [3] "baked, grilled, fried" "Barbecue"             
    ##  [5] "Broiled"               "Smoked"               
    ##  [7] "Grilled"               "fried"                
    ##  [9] "Fried and one baked"   "like soup"            
    ## [11] "O"                     "Eat Out"              
    ## [13] "Ronco"                 "Rotisserie"           
    ## [15] "roulade"               "Slow cooked"          
    ## [17] "stovetop"
