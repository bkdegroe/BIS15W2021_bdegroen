---
title: "Lab 6 Homework"
author: "Please Add Your Name Here"
date: "2021-01-24"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---




```r
getwd()
```

```
## [1] "/Users/Astrobeecal/Desktop/GitHub/BIS15W2021_bdegroen/lab6"
```


## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv("data/FAO_1950to2012_111914.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
## ℹ Use `spec()` for the full column specifications.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
names(fisheries)
```

```
##  [1] "Country"                 "Common name"            
##  [3] "ISSCAAP group#"          "ISSCAAP taxonomic group"
##  [5] "ASFIS species#"          "ASFIS species name"     
##  [7] "FAO major fishing area"  "Measure"                
##  [9] "1950"                    "1951"                   
## [11] "1952"                    "1953"                   
## [13] "1954"                    "1955"                   
## [15] "1956"                    "1957"                   
## [17] "1958"                    "1959"                   
## [19] "1960"                    "1961"                   
## [21] "1962"                    "1963"                   
## [23] "1964"                    "1965"                   
## [25] "1966"                    "1967"                   
## [27] "1968"                    "1969"                   
## [29] "1970"                    "1971"                   
## [31] "1972"                    "1973"                   
## [33] "1974"                    "1975"                   
## [35] "1976"                    "1977"                   
## [37] "1978"                    "1979"                   
## [39] "1980"                    "1981"                   
## [41] "1982"                    "1983"                   
## [43] "1984"                    "1985"                   
## [45] "1986"                    "1987"                   
## [47] "1988"                    "1989"                   
## [49] "1990"                    "1991"                   
## [51] "1992"                    "1993"                   
## [53] "1994"                    "1995"                   
## [55] "1996"                    "1997"                   
## [57] "1998"                    "1999"                   
## [59] "2000"                    "2001"                   
## [61] "2002"                    "2003"                   
## [63] "2004"                    "2005"                   
## [65] "2006"                    "2007"                   
## [67] "2008"                    "2009"                   
## [69] "2010"                    "2011"                   
## [71] "2012"
```

```r
dim(fisheries)
```

```
## [1] 17692    71
```

```r
anyNA(fisheries)
```

```
## [1] TRUE
```

```r
summary(fisheries)
```

```
##    Country          Common name        ISSCAAP group#  ISSCAAP taxonomic group
##  Length:17692       Length:17692       Min.   :11.00   Length:17692           
##  Class :character   Class :character   1st Qu.:33.00   Class :character       
##  Mode  :character   Mode  :character   Median :36.00   Mode  :character       
##                                        Mean   :37.38                          
##                                        3rd Qu.:38.00                          
##                                        Max.   :77.00                          
##  ASFIS species#     ASFIS species name FAO major fishing area
##  Length:17692       Length:17692       Min.   :18.00         
##  Class :character   Class :character   1st Qu.:31.00         
##  Mode  :character   Mode  :character   Median :37.00         
##                                        Mean   :45.34         
##                                        3rd Qu.:57.00         
##                                        Max.   :88.00         
##    Measure              1950               1951               1952          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1953               1954               1955               1956          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1957               1958               1959               1960          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1961               1962               1963               1964          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1965               1966               1967               1968          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1969               1970               1971               1972          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1973               1974               1975               1976          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1977               1978               1979               1980          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1981               1982               1983               1984          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1985               1986               1987               1988          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1989               1990               1991               1992          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1993               1994               1995               1996          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1997               1998               1999               2000          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2001               2002               2003               2004          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2005               2006               2007               2008          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2009               2010               2011               2012          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
## 
```

```r
class(fisheries)
```

```
## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
```
The class is character.



2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- janitor::clean_names(fisheries)
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
glimpse(fisheries_tidy)
```

```
## Rows: 376,771
## Columns: 10
## $ country                 <fct> Albania, Albania, Albania, Albania, Albania, …
## $ common_name             <chr> "Angelsharks, sand devils nei", "Angelsharks,…
## $ isscaap_group_number    <fct> 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 3…
## $ isscaap_taxonomic_group <chr> "Sharks, rays, chimaeras", "Sharks, rays, chi…
## $ asfis_species_number    <fct> 10903XXXXX, 10903XXXXX, 10903XXXXX, 10903XXXX…
## $ asfis_species_name      <chr> "Squatinidae", "Squatinidae", "Squatinidae", …
## $ fao_major_fishing_area  <fct> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 3…
## $ measure                 <chr> "Quantity (tonnes)", "Quantity (tonnes)", "Qu…
## $ year                    <dbl> 1995, 1996, 1997, 1998, 1999, 2000, 2001, 200…
## $ catch                   <dbl> NA, 53, 20, 31, 30, 30, 16, 79, 1, 4, 68, 55,…
```


```r
fisheries_tidy %>%
  summarize(n_country = n_distinct(country))
```

```
## # A tibble: 1 x 1
##   n_country
##       <int>
## 1       203
```

```r
fisheries_tidy %>%
  distinct(country)
```

```
## # A tibble: 203 x 1
##    country            
##    <fct>              
##  1 Albania            
##  2 Algeria            
##  3 American Samoa     
##  4 Angola             
##  5 Anguilla           
##  6 Antigua and Barbuda
##  7 Argentina          
##  8 Aruba              
##  9 Australia          
## 10 Bahamas            
## # … with 193 more rows
```

4. Refocus the data only to include only: country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
refocus_fisheries_tidy <- fisheries_tidy %>%
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
refocus_fisheries_tidy
```

```
## # A tibble: 376,771 x 6
##    country isscaap_taxonomic_g… asfis_species_na… asfis_species_num…  year catch
##    <fct>   <chr>                <chr>             <fct>              <dbl> <dbl>
##  1 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1995    NA
##  2 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1996    53
##  3 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1997    20
##  4 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1998    31
##  5 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          1999    30
##  6 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2000    30
##  7 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2001    16
##  8 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2002    79
##  9 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2003     1
## 10 Albania Sharks, rays, chima… Squatinidae       10903XXXXX          2004     4
## # … with 376,761 more rows
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
refocus_fisheries_tidy %>%
  select(asfis_species_number) %>%
  summarize(distinct_asfis_species_number = n_distinct(asfis_species_number))
```

```
## # A tibble: 1 x 1
##   distinct_asfis_species_number
##                           <int>
## 1                          1551
```

6. Which country had the largest overall catch in the year 2000?

```r
refocus_fisheries_tidy %>%
  select(country, year, catch) %>%
  filter(year==2000) %>%
  group_by(country) %>% 
  summarize(max_catch = max(catch, na.rm = T)) %>% 
  arrange(desc(max_catch))
```

```
## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf

## Warning in max(catch, na.rm = T): no non-missing arguments to max; returning -
## Inf
```

```
## # A tibble: 193 x 2
##    country                  max_catch
##    <fct>                        <dbl>
##  1 China                         9068
##  2 Peru                          5717
##  3 Russian Federation            5065
##  4 Viet Nam                      4945
##  5 Chile                         4299
##  6 United States of America      2438
##  7 Philippines                    999
##  8 Japan                          988
##  9 Bangladesh                     977
## 10 Senegal                        970
## # … with 183 more rows
```

```r
#This was just trying to figure out a cleaner way to get the data
refocus_fisheries_tidy %>%
  select(country, year, catch) %>%
  filter(year==2000) %>%
  summarize(max_catch = max(catch, na.rm = T))
```

```
## # A tibble: 1 x 1
##   max_catch
##       <dbl>
## 1      9068
```

```r
#Code a classmate suggested
refocus_fisheries_tidy %>%
  filter(year=="2000") %>% 
  group_by(country) %>% 
 summarize(sumcatch=sum(catch,na.rm=T),
            totaln=n(),.groups= 'keep') %>% 
  arrange(desc(sumcatch))
```

```
## # A tibble: 193 x 3
## # Groups:   country [193]
##    country                  sumcatch totaln
##    <fct>                       <dbl>  <int>
##  1 China                       25899     93
##  2 Russian Federation          12181    192
##  3 United States of America    11762    438
##  4 Japan                        8510    241
##  5 Indonesia                    8341    140
##  6 Peru                         7443     54
##  7 Chile                        6906     91
##  8 India                        6351     98
##  9 Thailand                     6243    127
## 10 Korea, Republic of           6124    265
## # … with 183 more rows
```


7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
refocus_fisheries_tidy %>% 
  select(country, asfis_species_name, year, catch) %>% 
  filter(asfis_species_name == "Sardina pilchardus") %>%
  filter(year >= "1990" & year <= "2000") %>% 
  group_by(country) %>% 
  summarize(sum_max_catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(sum_max_catch))
```

```
## # A tibble: 37 x 2
##    country               sum_max_catch
##    <fct>                         <dbl>
##  1 Morocco                        7470
##  2 Spain                          3507
##  3 Russian Federation             1639
##  4 Ukraine                        1030
##  5 France                          966
##  6 Portugal                        818
##  7 Greece                          528
##  8 Italy                           507
##  9 Serbia and Montenegro           478
## 10 Denmark                         477
## # … with 27 more rows
```

```r
#Why isn't year or species name coming up? Is it because of the group_by?
```

8. Which five countries caught the most cephalopods between 2008-2012?

```r
refocus_fisheries_tidy %>%
  filter(isscaap_taxonomic_group=="Squids, cuttlefishes, octopuses") %>% 
  count(asfis_species_name, sort=T)
```

```
## # A tibble: 35 x 2
##    asfis_species_name              n
##    <chr>                       <int>
##  1 Loliginidae, Ommastrephidae  3072
##  2 Octopodidae                  2935
##  3 Sepiidae, Sepiolidae         2605
##  4 Loligo spp                   1424
##  5 Sepia officinalis             699
##  6 Octopus vulgaris              611
##  7 Illex illecebrosus            460
##  8 Cephalopoda                   421
##  9 Illex argentinus              413
## 10 Loligo gahi                   281
## # … with 25 more rows
```

```r
refocus_fisheries_tidy %>%
  select(country, isscaap_taxonomic_group, year, catch) %>% 
  filter(isscaap_taxonomic_group == "Squids, cuttlefishes, octopuses") %>%
  filter(year >= 2000 & year <= 2012) %>%
  group_by(country) %>% 
  summarize(sum_max_catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(sum_max_catch))
```

```
## # A tibble: 130 x 2
##    country                  sum_max_catch
##    <fct>                            <dbl>
##  1 China                            18956
##  2 Korea, Republic of               11311
##  3 Japan                             9751
##  4 Taiwan Province of China          6467
##  5 Peru                              6346
##  6 Chile                             5603
##  7 United States of America          5059
##  8 Spain                             3194
##  9 Thailand                          3039
## 10 France                            2921
## # … with 120 more rows
```


9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
refocus_fisheries_tidy %>% 
  select(asfis_species_name, year, catch) %>%
  filter(year >= 2000 & year <= 2012) %>%
  group_by(asfis_species_name) %>%
  summarize(sum_species_max_catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(sum_species_max_catch))
```

```
## # A tibble: 1,520 x 2
##    asfis_species_name    sum_species_max_catch
##    <chr>                                 <dbl>
##  1 Osteichthyes                         317398
##  2 Engraulis ringens                    121471
##  3 Theragra chalcogramma                108651
##  4 Katsuwonus pelamis                    84421
##  5 Trichiurus lepturus                   61301
##  6 Clupea harengus                       55432
##  7 Trachurus murphyi                     52480
##  8 Thunnus albacares                     50267
##  9 Scomber japonicus                     38611
## 10 Gadus morhua                          30475
## # … with 1,510 more rows
```
Engraulis ringens had the highest catch total.


10. Use the data to do at least one analysis of your choice.

```r
refocus_fisheries_tidy %>%
  filter(country == "Netherlands") %>% 
  group_by(asfis_species_name) %>%
  summarize(sum_max_catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(sum_max_catch))
```

```
## # A tibble: 142 x 2
##    asfis_species_name       sum_max_catch
##    <chr>                            <dbl>
##  1 Clupea harengus                   9378
##  2 Trachurus trachurus               6820
##  3 Pleuronectes platessa             2057
##  4 Sardinella aurita                 1938
##  5 Scomber scombrus                  1930
##  6 Sardinella spp                    1750
##  7 Micromesistius poutassou          1524
##  8 Solea solea                       1434
##  9 Osteichthyes                      1198
## 10 Gadus morhua                      1138
## # … with 132 more rows
```

```r
refocus_fisheries_tidy %>%
  filter(country == "Netherlands") %>% 
  group_by(year) %>%
  summarize(sum_max_catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(sum_max_catch))
```

```
## # A tibble: 63 x 2
##     year sum_max_catch
##    <dbl>         <dbl>
##  1  2003          1955
##  2  2000          1777
##  3  1996          1701
##  4  1994          1654
##  5  1995          1646
##  6  2008          1638
##  7  2004          1633
##  8  1999          1600
##  9  2005          1491
## 10  1997          1404
## # … with 53 more rows
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
