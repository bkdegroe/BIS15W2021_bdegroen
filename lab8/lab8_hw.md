---
title: "Lab 8 Homework"
author: "Berlin DeGroen"
date: "2021-03-15"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
```

## Install `here`
The package `here` is a nice option for keeping directories clear when loading files. I will demonstrate below and let you decide if it is something you want to use.  

```r
#install.packages("here")
```

## Data
For this homework, we will use a data set compiled by the Office of Environment and Heritage in New South Whales, Australia. It contains the enterococci counts in water samples obtained from Sydney beaches as part of the Beachwatch Water Quality Program. Enterococci are bacteria common in the intestines of mammals; they are rarely present in clean water. So, enterococci values are a measurement of pollution. `cfu` stands for colony forming units and measures the number of viable bacteria in a sample [cfu](https://en.wikipedia.org/wiki/Colony-forming_unit).   

This homework loosely follows the tutorial of [R Ladies Sydney](https://rladiessydney.org/). If you get stuck, check it out!  

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

Disclaimer: I'm pretty sure I mostly just followed the key here. Completed it for the sake of future reference.

1. Start by loading the data `sydneybeaches`. Do some exploratory analysis to get an idea of the data structure.

```r
sydneybeaches <- read_csv("data/sydneybeaches.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   BeachId = col_double(),
##   Region = col_character(),
##   Council = col_character(),
##   Site = col_character(),
##   Longitude = col_double(),
##   Latitude = col_double(),
##   Date = col_character(),
##   `Enterococci (cfu/100ml)` = col_double()
## )
```

```r
sydneybeaches
```

```
## # A tibble: 3,690 x 8
##    BeachId Region    Council   Site   Longitude Latitude Date  `Enterococci (cf~
##      <dbl> <chr>     <chr>     <chr>      <dbl>    <dbl> <chr>             <dbl>
##  1      25 Sydney C~ Randwick~ Clove~      151.    -33.9 02/0~                19
##  2      25 Sydney C~ Randwick~ Clove~      151.    -33.9 06/0~                 3
##  3      25 Sydney C~ Randwick~ Clove~      151.    -33.9 12/0~                 2
##  4      25 Sydney C~ Randwick~ Clove~      151.    -33.9 18/0~                13
##  5      25 Sydney C~ Randwick~ Clove~      151.    -33.9 30/0~                 8
##  6      25 Sydney C~ Randwick~ Clove~      151.    -33.9 05/0~                 7
##  7      25 Sydney C~ Randwick~ Clove~      151.    -33.9 11/0~                11
##  8      25 Sydney C~ Randwick~ Clove~      151.    -33.9 23/0~                97
##  9      25 Sydney C~ Randwick~ Clove~      151.    -33.9 07/0~                 3
## 10      25 Sydney C~ Randwick~ Clove~      151.    -33.9 25/0~                 0
## # ... with 3,680 more rows
```

If you want to try `here`, first notice the output when you load the `here` library. It gives you information on the current working directory. You can then use it to easily and intuitively load files.

```r
library(here)
```

```
## here() starts at D:/TA files/Winter2021 BIS15L/students_rep/BIS15W2021_bdegroen
```

The quotes show the folder structure from the root directory.

```r
sydneybeaches <-read_csv(here("lab8", "data", "sydneybeaches.csv")) %>% janitor::clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   BeachId = col_double(),
##   Region = col_character(),
##   Council = col_character(),
##   Site = col_character(),
##   Longitude = col_double(),
##   Latitude = col_double(),
##   Date = col_character(),
##   `Enterococci (cfu/100ml)` = col_double()
## )
```

2. Are these data "tidy" per the definitions of the tidyverse? How do you know? Are they in wide or long format?

(1) Each variable has its own column. 
Yes(?)

(2) Each observation has its own row. 
No, because each observation is grouped by BeachId

(3) Each value has its own cell. 
Yes.

They are in wide format.

# long format

Professor's answer:
The data appear to be tidy. Each variable has its own column, each observation has its own row, and each cell has its own value. Because the sites are repeated based on their observation date, the data are in long format.



3. We are only interested in the variables site, date, and enterococci_cfu_100ml. Make a new object focused on these variables only. Name the object `sydneybeaches_long`

```r
sydneybeaches_long <- sydneybeaches %>% 
  select(site, date, enterococci_cfu_100ml)
sydneybeaches_long
```

```
## # A tibble: 3,690 x 3
##    site           date       enterococci_cfu_100ml
##    <chr>          <chr>                      <dbl>
##  1 Clovelly Beach 02/01/2013                    19
##  2 Clovelly Beach 06/01/2013                     3
##  3 Clovelly Beach 12/01/2013                     2
##  4 Clovelly Beach 18/01/2013                    13
##  5 Clovelly Beach 30/01/2013                     8
##  6 Clovelly Beach 05/02/2013                     7
##  7 Clovelly Beach 11/02/2013                    11
##  8 Clovelly Beach 23/02/2013                    97
##  9 Clovelly Beach 07/03/2013                     3
## 10 Clovelly Beach 25/03/2013                     0
## # ... with 3,680 more rows
```


4. Pivot the data such that the dates are column names and each beach only appears once. Name the object `sydneybeaches_wide`

```r
sydneybeaches_wide <- sydneybeaches_long %>%
  pivot_wider(names_from = "site",
              values_from = "enterococci_cfu_100ml")
sydneybeaches_wide
```

```
## # A tibble: 344 x 12
##    date     `Clovelly Beach` `Coogee Beach` `Gordons Bay (Eas~ `Little Bay Beac~
##    <chr>               <dbl>          <dbl>              <dbl>             <dbl>
##  1 02/01/2~               19             15                 NA                 9
##  2 06/01/2~                3              4                 NA                 3
##  3 12/01/2~                2             17                 NA                72
##  4 18/01/2~               13             18                 NA                 1
##  5 30/01/2~                8             22                 NA                44
##  6 05/02/2~                7              2                 NA                 7
##  7 11/02/2~               11            110                 NA               150
##  8 23/02/2~               97            630                 NA               330
##  9 07/03/2~                3             11                 NA                31
## 10 25/03/2~                0             82                  4               420
## # ... with 334 more rows, and 7 more variables: Malabar Beach <dbl>,
## #   Maroubra Beach <dbl>, South Maroubra Beach <dbl>,
## #   South Maroubra Rockpool <dbl>, Bondi Beach <dbl>, Bronte Beach <dbl>,
## #   Tamarama Beach <dbl>
```


5. Pivot the data back so that the dates are data and not column names.

```r
sydneybeaches_wide %>%
  pivot_longer(-date,
                 names_to = "beach",
                 values_to = "enterococci_cfu_100ml")
```

```
## # A tibble: 3,784 x 3
##    date       beach                   enterococci_cfu_100ml
##    <chr>      <chr>                                   <dbl>
##  1 02/01/2013 Clovelly Beach                             19
##  2 02/01/2013 Coogee Beach                               15
##  3 02/01/2013 Gordons Bay (East)                         NA
##  4 02/01/2013 Little Bay Beach                            9
##  5 02/01/2013 Malabar Beach                               2
##  6 02/01/2013 Maroubra Beach                              1
##  7 02/01/2013 South Maroubra Beach                        1
##  8 02/01/2013 South Maroubra Rockpool                    12
##  9 02/01/2013 Bondi Beach                                 3
## 10 02/01/2013 Bronte Beach                                4
## # ... with 3,774 more rows
```


6. We haven't dealt much with dates yet, but separate the date into columns day, month, and year. Do this on the `sydneybeaches_long` data.

```r
sydneybeaches_year <- sydneybeaches_long %>%
   separate(date, into= c("day", "month", "year"), sep = "/")
sydneybeaches_year
```

```
## # A tibble: 3,690 x 5
##    site           day   month year  enterococci_cfu_100ml
##    <chr>          <chr> <chr> <chr>                 <dbl>
##  1 Clovelly Beach 02    01    2013                     19
##  2 Clovelly Beach 06    01    2013                      3
##  3 Clovelly Beach 12    01    2013                      2
##  4 Clovelly Beach 18    01    2013                     13
##  5 Clovelly Beach 30    01    2013                      8
##  6 Clovelly Beach 05    02    2013                      7
##  7 Clovelly Beach 11    02    2013                     11
##  8 Clovelly Beach 23    02    2013                     97
##  9 Clovelly Beach 07    03    2013                      3
## 10 Clovelly Beach 25    03    2013                      0
## # ... with 3,680 more rows
```


7. What is the average `enterococci_cfu_100ml` by year for each beach. Think about which data you will use- long or wide.

```r
sydneybeaches_mean <- sydneybeaches_year %>%
  group_by(year, site) %>% 
  summarize(average_enterococci_cfu_100ml=mean(enterococci_cfu_100ml, na.rm=T))
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

```r
sydneybeaches_mean
```

```
## # A tibble: 66 x 3
## # Groups:   year [6]
##    year  site                    average_enterococci_cfu_100ml
##    <chr> <chr>                                           <dbl>
##  1 2013  Bondi Beach                                     32.2 
##  2 2013  Bronte Beach                                    26.8 
##  3 2013  Clovelly Beach                                   9.28
##  4 2013  Coogee Beach                                    39.7 
##  5 2013  Gordons Bay (East)                              24.8 
##  6 2013  Little Bay Beach                               122.  
##  7 2013  Malabar Beach                                  101.  
##  8 2013  Maroubra Beach                                  47.1 
##  9 2013  South Maroubra Beach                            39.3 
## 10 2013  South Maroubra Rockpool                         96.4 
## # ... with 56 more rows
```


8. Make the output from question 7 easier to read by pivoting it to wide format.

```r
sydneybeaches_year_wide <- sydneybeaches_mean %>%
  pivot_wider(names_from = "site",
              values_from = "average_enterococci_cfu_100ml")
sydneybeaches_year_wide
```

```
## # A tibble: 6 x 12
## # Groups:   year [6]
##   year  `Bondi Beach` `Bronte Beach` `Clovelly Beach` `Coogee Beach`
##   <chr>         <dbl>          <dbl>            <dbl>          <dbl>
## 1 2013           32.2           26.8             9.28           39.7
## 2 2014           11.1           17.5            13.8            52.6
## 3 2015           14.3           23.6             8.82           40.3
## 4 2016           19.4           61.3            11.3            59.5
## 5 2017           13.2           16.8             7.93           20.7
## 6 2018           22.9           43.4            10.6            21.6
## # ... with 7 more variables: Gordons Bay (East) <dbl>, Little Bay Beach <dbl>,
## #   Malabar Beach <dbl>, Maroubra Beach <dbl>, South Maroubra Beach <dbl>,
## #   South Maroubra Rockpool <dbl>, Tamarama Beach <dbl>
```


9. What was the most polluted beach in 2018?

```r
sydneybeaches_mean %>%
  filter(year == 2018) %>%
  arrange(desc(average_enterococci_cfu_100ml))
```

```
## # A tibble: 11 x 3
## # Groups:   year [1]
##    year  site                    average_enterococci_cfu_100ml
##    <chr> <chr>                                           <dbl>
##  1 2018  South Maroubra Rockpool                        112.  
##  2 2018  Little Bay Beach                                59.1 
##  3 2018  Bronte Beach                                    43.4 
##  4 2018  Malabar Beach                                   38.0 
##  5 2018  Bondi Beach                                     22.9 
##  6 2018  Coogee Beach                                    21.6 
##  7 2018  Gordons Bay (East)                              17.6 
##  8 2018  Tamarama Beach                                  15.5 
##  9 2018  South Maroubra Beach                            12.5 
## 10 2018  Clovelly Beach                                  10.6 
## 11 2018  Maroubra Beach                                   9.21
```

South Maroubra Rockpool is the most polluted beach.

10. Please complete the class project survey at: [BIS 15L Group Project](https://forms.gle/H2j69Z3ZtbLH3efW6)
</div>


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
