---
title: "Pipes, `mutate()`, and `if_else()`"
date: "2021-01-19"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Learning Goals
*At the end of this exercise, you will be able to:*    
1. Use pipes to connect functions in dplyr.  
2. Use `arrange()` to order dplyr outputs.  
3. Use `mutate()` to add columns in a dataframe.  
4. Use `mutate()` and `if_else()` to replace values in a dataframe.  

## Review
At this point, you should be comfortable using the `select()` and `filter()` functions of `dplyr`. If you need extra help, please [email me](mailto: jmledford@ucdavis.edu).  


```r
getwd()
```

```
## [1] "/Users/Astrobeecal/Desktop/GitHub/BIS15W2021_bdegroen/lab5"
```


## Load the tidyverse

```r
library("tidyverse")
```

## Load the data
For this lab, we will use the following two datasets:  

1. Gaeta J., G. Sass, S. Carpenter. 2012. Biocomplexity at North Temperate Lakes LTER: Coordinated Field Studies: Large Mouth Bass Growth 2006. Environmental Data Initiative.   [link](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=267)  

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## Parsed with column specification:
## cols(
##   lakeid = col_character(),
##   fish_id = col_double(),
##   annnumber = col_character(),
##   length = col_double(),
##   radii_length_mm = col_double(),
##   scalelength = col_double()
## )
```

2. S. K. Morgan Ernest. 2003. Life history characteristics of placental non-volant mammals. Ecology 84:3402.   [link](http://esapubs.org/archive/ecol/E084/093/)  

```r
mammals <- readr::read_csv("data/mammal_lifehistories_v2.csv")
```

```
## Parsed with column specification:
## cols(
##   order = col_character(),
##   family = col_character(),
##   Genus = col_character(),
##   species = col_character(),
##   mass = col_double(),
##   gestation = col_double(),
##   newborn = col_double(),
##   weaning = col_double(),
##   `wean mass` = col_double(),
##   AFR = col_double(),
##   `max. life` = col_double(),
##   `litter size` = col_double(),
##   `litters/year` = col_double()
## )
```

Let's rename some of the `mammals` variables.  

```r
mammals <- rename(mammals, genus="Genus", wean_mass="wean mass", max_life= "max. life", litter_size="litter size", litters_per_year="litters/year")
```

## Pipes `%>%` 
In order to start combining `select()`, `filter()`, and other functions more efficiently, we need to learn pipes. Pipes feed the output from one function into the input of another function. This helps us keep our code sequential and clean.  

In this example, we use a pipe to select only `lakeid` and `scalelength` then filter that output only for lakes "AL". Notice that we only need to call the data one time.

-When you want to run data, you sometimes want to combine different functions of dplier. In order to do that, take the output of one function and feed it into the input of another. We do this doing pipes.
-Shortcut for pipes: shift, command, m
-Beforehand, we would do

```r
filter(fish, lakeid=="AL")
```

```
## # A tibble: 383 x 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 373 more rows
```
-What if you want to use different things in combination? Don't always want to constantly redo functions, so here's how you do that.
-Piping select through filter

```r
fish %>%
  select(lakeid, scalelength) %>%
  filter(lakeid == "AL")
```

```
## # A tibble: 383 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # … with 373 more rows
```
-Same thing if you did

```r
select(fish, lakeid, scalelength)
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # … with 4,023 more rows
```
-Now you don't have to constantly recall the data. Now you filter out through a new function
-Now calling data and feeding it through the function you want to d

Here we select family, genus, and species then filter for gestation greater than 15 months.
-Mammals piped into select, then piping that to find mammals that have gestation greater than 15 months

```r
mammals %>% 
  select(family, genus, species, gestation) %>% 
  filter(gestation>=15)
```

```
## # A tibble: 8 x 4
##   family         genus         species       gestation
##   <chr>          <chr>         <chr>             <dbl>
## 1 Delphinidae    Globicephala  macrorhynchus      15.2
## 2 Physeteridae   Physeter      catodon            15.8
## 3 Rhinocerotidae Ceratotherium simum              15.9
## 4 Rhinocerotidae Diceros       bicornis           16.1
## 5 Rhinocerotidae Rhinoceros    unicornis          16.4
## 6 Rhinocerotidae Rhinoceros    sondaicus          16.5
## 7 Elephantidae   Elephas       maximus            21.1
## 8 Elephantidae   Loxodonta     africana           21.5
```
-Now essentially using pipes for the rest of the class, so get comfy! Hopefully pretty intuitive!

## Practice
1. We are interested in the fish from the lakes "AL" and "AR" with a radii length between 2 and 4. Extract this information from the `fish` data. Use pipes!  
-Only interested in two lakes, then the radii

```r
fish %>% 
  select(lakeid,radii_length_mm) %>% 
  filter(lakeid == "AL" | lakeid == "AR") %>% 
  filter(between(radii_length_mm, 2, 4)) %>% 
  arrange(desc(radii_length_mm))
```

```
## # A tibble: 253 x 2
##    lakeid radii_length_mm
##    <chr>            <dbl>
##  1 AR                4.00
##  2 AR                3.99
##  3 AR                3.99
##  4 AR                3.98
##  5 AR                3.98
##  6 AR                3.96
##  7 AR                3.94
##  8 AR                3.94
##  9 AR                3.94
## 10 AL                3.94
## # … with 243 more rows
```

## `arrange()`
The `arrange()` command is a bit like a sort command in excel. Note that the default is ascending order.  

```r
fish %>% 
  select(lakeid, scalelength) %>% 
  arrange(scalelength)
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 WS           0.628
##  2 WS           0.637
##  3 LSG          0.773
##  4 WS           0.832
##  5 LSG          1.15 
##  6 WS           1.41 
##  7 WS           1.41 
##  8 WS           1.41 
##  9 BO           1.43 
## 10 BO           1.43 
## # … with 4,023 more rows
```
-Scale length now in ascending order

To sort in decreasing order, wrap the variable name in `desc()`.

```r
fish %>% 
  select(lakeid, scalelength) %>% 
  arrange(desc(scalelength))
```

```
## # A tibble: 4,033 x 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 WS            11.0
##  2 WS            11.0
##  3 WS            11.0
##  4 WS            11.0
##  5 WS            11.0
##  6 WS            11.0
##  7 WS            11.0
##  8 WS            11.0
##  9 WS            11.0
## 10 WS            11.0
## # … with 4,023 more rows
```

`arrange()` can be very helpful in combination with the other functions.

```r
fish %>% 
  select(lakeid, length, fish_id, scalelength) %>% 
  filter(lakeid=="AL") %>% 
  arrange(fish_id)
```

```
## # A tibble: 383 x 4
##    lakeid length fish_id scalelength
##    <chr>   <dbl>   <dbl>       <dbl>
##  1 AL        167     299        2.70
##  2 AL        167     299        2.70
##  3 AL        167     299        2.70
##  4 AL        175     300        3.02
##  5 AL        175     300        3.02
##  6 AL        175     300        3.02
##  7 AL        175     300        3.02
##  8 AL        194     301        3.34
##  9 AL        194     301        3.34
## 10 AL        194     301        3.34
## # … with 373 more rows
```

## Practice
1. We are interested in the radii length and scalelength of fish with the id `300`. Extract this information from the `fish` data. Please sort the data by radii length.

```r
fish %>% 
  select(fish_id, radii_length_mm, scalelength) %>% 
  filter(fish_id == 300) %>% 
  arrange(radii_length_mm)
```

```
## # A tibble: 4 x 3
##   fish_id radii_length_mm scalelength
##     <dbl>           <dbl>       <dbl>
## 1     300            1.23        3.02
## 2     300            2.14        3.02
## 3     300            2.67        3.02
## 4     300            3.02        3.02
```

```r
#Arrange in increasing order for radii length
```

## `mutate()`  
Mutate allows us to create a new column from existing columns in a data frame. We are doing a small introduction here and will add some additional functions later. Let's convert the length variable from cm to millimeters and create a new variable called length_mm.
-Helpful for ex. conversions, mathematical manipulation of data

```r
fish %>% 
  mutate(length_mm = length*10) %>% 
  select(fish_id, length, length_mm)
```

```
## # A tibble: 4,033 x 3
##    fish_id length length_mm
##      <dbl>  <dbl>     <dbl>
##  1     299    167      1670
##  2     299    167      1670
##  3     299    167      1670
##  4     300    175      1750
##  5     300    175      1750
##  6     300    175      1750
##  7     300    175      1750
##  8     301    194      1940
##  9     301    194      1940
## 10     301    194      1940
## # … with 4,023 more rows
```
-Mutate has a specific format. First give the name of the new column you want to create (length_mm)
-Take values in existing length column and multiply them
-Further select out columns to be easier to read
-Important that you retained the original column! (length in cm)

## `mutate_all()`
This last function is super helpful when cleaning data. With "wild" data, there are often mixed entries (upper and lowercase), blank spaces, odd characters, etc. These all need to be dealt with before analysis.  
-Super helpful when dealing with wilds/mixed entries
-Emphasizing point of having standardized nomenclature

Here is an example that changes all entries to lowercase (if present).  

```r
mammals
```

```
## # A tibble: 1,440 x 13
##    order family genus species   mass gestation newborn weaning wean_mass    AFR
##    <chr> <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>     <dbl>  <dbl>
##  1 Arti… Antil… Anti… americ… 4.54e4      8.13   3246.    3         8900   13.5
##  2 Arti… Bovid… Addax nasoma… 1.82e5      9.39   5480     6.5       -999   27.3
##  3 Arti… Bovid… Aepy… melamp… 4.15e4      6.35   5093     5.63     15900   16.7
##  4 Arti… Bovid… Alce… busela… 1.50e5      7.9   10167.    6.5       -999   23.0
##  5 Arti… Bovid… Ammo… clarkei 2.85e4      6.8    -999  -999         -999 -999  
##  6 Arti… Bovid… Ammo… lervia  5.55e4      5.08   3810     4         -999   14.9
##  7 Arti… Bovid… Anti… marsup… 3.00e4      5.72   3910     4.04      -999   10.2
##  8 Arti… Bovid… Anti… cervic… 3.75e4      5.5    3846     2.13      -999   20.1
##  9 Arti… Bovid… Bison bison   4.98e5      8.93  20000    10.7     157500   29.4
## 10 Arti… Bovid… Bison bonasus 5.00e5      9.14  23000.    6.6       -999   30.0
## # … with 1,430 more rows, and 3 more variables: max_life <dbl>,
## #   litter_size <dbl>, litters_per_year <dbl>
```
-Some names capitalized, some lower, etc. The names that are capitalized should be in any formal publication
-This mutate all look at all of the entries in all of the columns and puts them lowercased


```r
mammals %>%
  mutate_all(tolower)
```

```
## # A tibble: 1,440 x 13
##    order family genus species mass  gestation newborn weaning wean_mass AFR  
##    <chr> <chr>  <chr> <chr>   <chr> <chr>     <chr>   <chr>   <chr>     <chr>
##  1 arti… antil… anti… americ… 45375 8.13      3246.36 3       8900      13.53
##  2 arti… bovid… addax nasoma… 1823… 9.39      5480    6.5     -999      27.27
##  3 arti… bovid… aepy… melamp… 41480 6.35      5093    5.63    15900     16.66
##  4 arti… bovid… alce… busela… 1500… 7.9       10166.… 6.5     -999      23.02
##  5 arti… bovid… ammo… clarkei 28500 6.8       -999    -999    -999      -999 
##  6 arti… bovid… ammo… lervia  55500 5.08      3810    4       -999      14.89
##  7 arti… bovid… anti… marsup… 30000 5.72      3910    4.04    -999      10.23
##  8 arti… bovid… anti… cervic… 37500 5.5       3846    2.13    -999      20.13
##  9 arti… bovid… bison bison   4976… 8.93      20000   10.71   157500    29.45
## 10 arti… bovid… bison bonasus 5e+05 9.14      23000.… 6.6     -999      29.99
## # … with 1,430 more rows, and 3 more variables: max_life <chr>,
## #   litter_size <chr>, litters_per_year <chr>
```
-Very helptul, because minimizes chance of mispelling

## `if_else()`
We will briefly introduce `if_else()` here because it allows us to use `mutate()` but not the entire column affected in the same way. In a sense, this can function like find and replace in a spreadsheet program. With `ifelse()`, you first specify a logical statement, afterwards what needs to happen if the statement returns `TRUE`, and lastly what needs to happen if it's  `FALSE`.
-Operator that acts within mutate
-Acts like a search and replace function in Microsoft Excel
-First you have a logical statement, then tell R what to do if statement is true, then if it's false
-Ex. -999 is NA value, which is a very bad idea. R is going to treat -999 as a numeric, so this screws up your calculations
-SO use if_else to replace -999 with NA

Have a look at the data from mammals below. Notice that the values for newborn include `-999.00`. This is sometimes used as a placeholder for NA (but, is a really bad idea). We can use `if_else()` to replace `-999.00` with `NA`.  

```r
mammals %>% 
  select(genus, species, newborn) %>% 
  arrange(newborn)
```

```
## # A tibble: 1,440 x 3
##    genus       species        newborn
##    <chr>       <chr>            <dbl>
##  1 Ammodorcas  clarkei           -999
##  2 Bos         javanicus         -999
##  3 Bubalus     depressicornis    -999
##  4 Bubalus     mindorensis       -999
##  5 Capra       falconeri         -999
##  6 Cephalophus niger             -999
##  7 Cephalophus nigrifrons        -999
##  8 Cephalophus natalensis        -999
##  9 Cephalophus leucogaster       -999
## 10 Cephalophus ogilbyi           -999
## # … with 1,430 more rows
```
-To use if else, call mammals data
-Select species and newborn
-Use mutate function for new column name (newborn_new), which then equals ifelse
-Inside that cell, but in NA
-If not -999, then whatever value already existed in newborn

```r
mammals %>% 
  select(genus, species, newborn) %>%
  mutate(newborn_new = ifelse(newborn == -999.00, NA, newborn)) %>% 
  arrange(newborn)
```

```
## # A tibble: 1,440 x 4
##    genus       species        newborn newborn_new
##    <chr>       <chr>            <dbl>       <dbl>
##  1 Ammodorcas  clarkei           -999          NA
##  2 Bos         javanicus         -999          NA
##  3 Bubalus     depressicornis    -999          NA
##  4 Bubalus     mindorensis       -999          NA
##  5 Capra       falconeri         -999          NA
##  6 Cephalophus niger             -999          NA
##  7 Cephalophus nigrifrons        -999          NA
##  8 Cephalophus natalensis        -999          NA
##  9 Cephalophus leucogaster       -999          NA
## 10 Cephalophus ogilbyi           -999          NA
## # … with 1,430 more rows
```

## Practice
1. Use `mutate()` to make a new column that is the half length of each fish: length_half = length/2. Select only fish_id, length, and length_half.
Length_half new column name, then where to get data from


```r
fish %>% 
  mutate(length_half=length/2) %>% 
  select(fish_id,length, length_half)
```

```
## # A tibble: 4,033 x 3
##    fish_id length length_half
##      <dbl>  <dbl>       <dbl>
##  1     299    167        83.5
##  2     299    167        83.5
##  3     299    167        83.5
##  4     300    175        87.5
##  5     300    175        87.5
##  6     300    175        87.5
##  7     300    175        87.5
##  8     301    194        97  
##  9     301    194        97  
## 10     301    194        97  
## # … with 4,023 more rows
```

2. We are interested in the family, genus, species and max life variables. Because the max life span for several mammals is unknown, the authors have use -999 in place of NA. Replace all of these values with NA in a new column titled `max_life_new`. Finally, sort the date in descending order by max_life_new. Which mammal has the oldest known life span?

```r
mammals %>%
  select(family, genus, species, max_life) %>%
  arrange(max_life) #Shows the -999 values
```

```
## # A tibble: 1,440 x 4
##    family  genus       species     max_life
##    <chr>   <chr>       <chr>          <dbl>
##  1 Bovidae Ammodorcas  clarkei         -999
##  2 Bovidae Capra       caucasica       -999
##  3 Bovidae Capra       ibex            -999
##  4 Bovidae Cephalophus niger           -999
##  5 Bovidae Cephalophus natalensis      -999
##  6 Bovidae Cephalophus leucogaster     -999
##  7 Bovidae Cephalophus ogilbyi         -999
##  8 Bovidae Cephalophus zebra           -999
##  9 Bovidae Cephalophus rufilatus       -999
## 10 Bovidae Cephalophus dorsalis        -999
## # … with 1,430 more rows
```

```r
mammals %>%
  select(family, genus, species, max_life) %>%
  mutate(max_life_new= ifelse(max_life==-999, NA, max_life)) %>% 
  arrange(max_life)
```

```
## # A tibble: 1,440 x 5
##    family  genus       species     max_life max_life_new
##    <chr>   <chr>       <chr>          <dbl>        <dbl>
##  1 Bovidae Ammodorcas  clarkei         -999           NA
##  2 Bovidae Capra       caucasica       -999           NA
##  3 Bovidae Capra       ibex            -999           NA
##  4 Bovidae Cephalophus niger           -999           NA
##  5 Bovidae Cephalophus natalensis      -999           NA
##  6 Bovidae Cephalophus leucogaster     -999           NA
##  7 Bovidae Cephalophus ogilbyi         -999           NA
##  8 Bovidae Cephalophus zebra           -999           NA
##  9 Bovidae Cephalophus rufilatus       -999           NA
## 10 Bovidae Cephalophus dorsalis        -999           NA
## # … with 1,430 more rows
```

## That's it! Take a break and I will see you on Zoom!  

-->[Home](https://jmledford3115.github.io/datascibiol/)  
