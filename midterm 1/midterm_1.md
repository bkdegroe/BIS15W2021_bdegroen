---
title: "Midterm 1"
author: "Berlin DeGroen"
date: "2021-02-02"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```


```r
getwd()
```

```
## [1] "D:/TA files/Winter2021 BIS15L/students_rep/BIS15W2021_bdegroen/midterm 1"
```


## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  

R studio is mainly a more streamlined form of R programming. It is more user-friendly and less code intensive than R is, but the two programs still coordinate with each other to give the user.

Github works with these two programs to make a more user-friendly coding platform whose code can be shared with others.

R markdown is a tool that can be used to convert the information you typed into R into a specific type of output. It's important because it makes the data more clear to the viewer and is easier to share. 

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

The three types of data structures that we've discussed are numeric, logical values, and character values. We use these because sometimes, a number or object must be stored as a particular class in order to perform a certain function with it, so we do this by assigning the number or object to a class function.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**


```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
sapply(elephants, class)
```

```
##         Age      Height         Sex 
##   "numeric"   "numeric" "character"
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", ...
```

```r
summary(elephants)
```

```
##       Age            Height           Sex           
##  Min.   : 0.01   Min.   : 75.46   Length:288        
##  1st Qu.: 4.58   1st Qu.:160.75   Class :character  
##  Median : 9.46   Median :200.00   Mode  :character  
##  Mean   :10.97   Mean   :187.68                     
##  3rd Qu.:16.50   3rd Qu.:221.09                     
##  Max.   :32.17   Max.   :304.06
```

(making vairables lawercase, mutate all. Used something else. REason why it wouldn't work?
You're asking to change "every" cell from uppercase to lowercase. Might not be necessary nor something you'd want to do)


**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```


```r
elephants <- janitor::clean_names(elephants)
elephants
```

```
## # A tibble: 288 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # ... with 278 more rows
```

```r
elephants$sex <- as.factor(elephants$sex)
class(elephants$sex)
```

```
## [1] "factor"
```


**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants %>% 
  group_by(sex) %>%
  summarize(n=n())
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```


**6. (2 points) What is the average age all elephants in the data?**

```r
elephants %>%
  summarize(average_elephant_age = mean(age),
            n=n())
```

```
## # A tibble: 1 x 2
##   average_elephant_age     n
##                  <dbl> <int>
## 1                 11.0   288
```


**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>%
  group_by(sex) %>%
  summarize(average_elephant_age = mean(age),
            average_elephant_height = mean(height),
            n=n())
```

```
## # A tibble: 2 x 4
##   sex   average_elephant_age average_elephant_height     n
## * <fct>                <dbl>                   <dbl> <int>
## 1 F                    12.8                     190.   150
## 2 M                     8.95                    185.   138
```

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants %>% 
  group_by(sex) %>% 
  filter(age > "25") %>%
  summarize(average_elephant_height = mean(height),
            min_elephant_height = min(height),
            max_elephant_height = max(height),
            n=n())
```

```
## # A tibble: 2 x 5
##   sex   average_elephant_height min_elephant_height max_elephant_height     n
##   <fct>                   <dbl>               <dbl>               <dbl> <int>
## 1 F                        201.                123.                278.    63
## 2 M                        195.                136.                304.    63
```

</div>

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
invidodata <- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
sapply(invidodata, class)
```

```
##              TransectID                Distance                 HuntCat 
##               "numeric"               "numeric"             "character" 
##           NumHouseholds                 LandUse                Veg_Rich 
##               "numeric"             "character"               "numeric" 
##               Veg_Stems               Veg_liana                 Veg_DBH 
##               "numeric"               "numeric"               "numeric" 
##              Veg_Canopy          Veg_Understory                 RA_Apes 
##               "numeric"               "numeric"               "numeric" 
##                RA_Birds             RA_Elephant              RA_Monkeys 
##               "numeric"               "numeric"               "numeric" 
##               RA_Rodent             RA_Ungulate         Rich_AllSpecies 
##               "numeric"               "numeric"               "numeric" 
##     Evenness_AllSpecies    Diversity_AllSpecies        Rich_BirdSpecies 
##               "numeric"               "numeric"               "numeric" 
##    Evenness_BirdSpecies   Diversity_BirdSpecies      Rich_MammalSpecies 
##               "numeric"               "numeric"               "numeric" 
##  Evenness_MammalSpecies Diversity_MammalSpecies 
##               "numeric"               "numeric"
```


```r
glimpse(invidodata)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 1...
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24...
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None",...
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46,...
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", ...
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 1...
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 3...
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38...
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 5...
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4...
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2...
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, ...
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 4...
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0...
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 4...
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1...
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10...
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21,...
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0...
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2...
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11...
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0...
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1...
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 1...
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0...
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1...
```

```r
names(invidodata)
```

```
##  [1] "TransectID"              "Distance"               
##  [3] "HuntCat"                 "NumHouseholds"          
##  [5] "LandUse"                 "Veg_Rich"               
##  [7] "Veg_Stems"               "Veg_liana"              
##  [9] "Veg_DBH"                 "Veg_Canopy"             
## [11] "Veg_Understory"          "RA_Apes"                
## [13] "RA_Birds"                "RA_Elephant"            
## [15] "RA_Monkeys"              "RA_Rodent"              
## [17] "RA_Ungulate"             "Rich_AllSpecies"        
## [19] "Evenness_AllSpecies"     "Diversity_AllSpecies"   
## [21] "Rich_BirdSpecies"        "Evenness_BirdSpecies"   
## [23] "Diversity_BirdSpecies"   "Rich_MammalSpecies"     
## [25] "Evenness_MammalSpecies"  "Diversity_MammalSpecies"
```

```r
summary(invidodata)
```

```
##    TransectID       Distance        HuntCat          NumHouseholds  
##  Min.   : 1.00   Min.   : 2.700   Length:24          Min.   :13.00  
##  1st Qu.: 5.75   1st Qu.: 5.668   Class :character   1st Qu.:24.75  
##  Median :14.50   Median : 9.720   Mode  :character   Median :29.00  
##  Mean   :13.50   Mean   :11.879                      Mean   :37.88  
##  3rd Qu.:20.25   3rd Qu.:17.683                      3rd Qu.:54.00  
##  Max.   :27.00   Max.   :26.760                      Max.   :73.00  
##    LandUse             Veg_Rich       Veg_Stems       Veg_liana     
##  Length:24          Min.   :10.88   Min.   :23.44   Min.   : 4.750  
##  Class :character   1st Qu.:13.10   1st Qu.:28.69   1st Qu.: 9.033  
##  Mode  :character   Median :14.94   Median :32.45   Median :11.940  
##                     Mean   :14.83   Mean   :32.80   Mean   :11.040  
##                     3rd Qu.:16.54   3rd Qu.:37.08   3rd Qu.:13.250  
##                     Max.   :18.75   Max.   :47.56   Max.   :16.380  
##     Veg_DBH        Veg_Canopy    Veg_Understory     RA_Apes      
##  Min.   :28.45   Min.   :2.500   Min.   :2.380   Min.   : 0.000  
##  1st Qu.:40.65   1st Qu.:3.250   1st Qu.:2.875   1st Qu.: 0.000  
##  Median :43.90   Median :3.430   Median :3.000   Median : 0.485  
##  Mean   :46.09   Mean   :3.469   Mean   :3.020   Mean   : 2.045  
##  3rd Qu.:50.58   3rd Qu.:3.750   3rd Qu.:3.167   3rd Qu.: 3.815  
##  Max.   :76.48   Max.   :4.000   Max.   :3.880   Max.   :12.930  
##     RA_Birds      RA_Elephant       RA_Monkeys      RA_Rodent    
##  Min.   :31.56   Min.   :0.0000   Min.   : 5.84   Min.   :1.060  
##  1st Qu.:52.51   1st Qu.:0.0000   1st Qu.:22.70   1st Qu.:2.047  
##  Median :57.90   Median :0.3600   Median :31.74   Median :3.230  
##  Mean   :58.64   Mean   :0.5450   Mean   :31.30   Mean   :3.278  
##  3rd Qu.:68.17   3rd Qu.:0.8925   3rd Qu.:39.88   3rd Qu.:4.093  
##  Max.   :85.03   Max.   :2.3000   Max.   :54.12   Max.   :6.310  
##   RA_Ungulate     Rich_AllSpecies Evenness_AllSpecies Diversity_AllSpecies
##  Min.   : 0.000   Min.   :15.00   Min.   :0.6680      Min.   :1.966       
##  1st Qu.: 1.232   1st Qu.:19.00   1st Qu.:0.7542      1st Qu.:2.248       
##  Median : 2.545   Median :20.00   Median :0.7760      Median :2.316       
##  Mean   : 4.166   Mean   :20.21   Mean   :0.7699      Mean   :2.310       
##  3rd Qu.: 5.157   3rd Qu.:22.00   3rd Qu.:0.8083      3rd Qu.:2.429       
##  Max.   :13.860   Max.   :24.00   Max.   :0.8330      Max.   :2.566       
##  Rich_BirdSpecies Evenness_BirdSpecies Diversity_BirdSpecies Rich_MammalSpecies
##  Min.   : 8.00    Min.   :0.5590       Min.   :1.162         Min.   : 6.000    
##  1st Qu.:10.00    1st Qu.:0.6825       1st Qu.:1.603         1st Qu.: 9.000    
##  Median :11.00    Median :0.7220       Median :1.680         Median :10.000    
##  Mean   :10.33    Mean   :0.7137       Mean   :1.661         Mean   : 9.875    
##  3rd Qu.:11.00    3rd Qu.:0.7722       3rd Qu.:1.784         3rd Qu.:11.000    
##  Max.   :13.00    Max.   :0.8240       Max.   :2.008         Max.   :12.000    
##  Evenness_MammalSpecies Diversity_MammalSpecies
##  Min.   :0.6190         Min.   :1.378          
##  1st Qu.:0.7073         1st Qu.:1.567          
##  Median :0.7390         Median :1.699          
##  Mean   :0.7477         Mean   :1.698          
##  3rd Qu.:0.7847         3rd Qu.:1.815          
##  Max.   :0.8610         Max.   :2.065
```


```r
invidodata$HuntCat <- as.factor(invidodata$HuntCat)
class(invidodata$HuntCat)
```

```
## [1] "factor"
```

```r
invidodata$LandUse <- as.factor(invidodata$LandUse)
class(invidodata$LandUse)
```

```
## [1] "factor"
```


**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
invidodata %>% 
  filter(HuntCat == "High" | HuntCat == "Moderate") %>% 
  group_by(HuntCat) %>% 
  summarize(average_diversity_birds = mean(Diversity_BirdSpecies),
            average_diversity_mammals = mean(Diversity_MammalSpecies),
            n=n())
```

```
## # A tibble: 2 x 4
##   HuntCat  average_diversity_birds average_diversity_mammals     n
## * <fct>                      <dbl>                     <dbl> <int>
## 1 High                        1.66                      1.74     7
## 2 Moderate                    1.62                      1.68     8
```

(4 rows across, average bird, mammal, total just in case to see how many groups there are. Rows = high and moderate)

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**

```r
invidodata %>% 
  filter(Distance < "5" | Distance > "20") %>% 
  group_by(Distance < "5" & Distance > "20") %>% 
  summarize(across(c(RA_Apes, RA_Birds, RA_Elephant, RA_Monkeys, RA_Rodent), mean))
```

```
## # A tibble: 2 x 6
##   `Distance < "5" & Distance ~ RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent
## * <lgl>                          <dbl>    <dbl>       <dbl>      <dbl>     <dbl>
## 1 FALSE                           1.37     60.8       0.570       29.7      3.37
## 2 TRUE                            5.40     47.8       0.418       39.5      2.81
```
</div>

(If we're given a hint but we don't use it, could that negatively impact us or will that make it more difficult for ourselves?
Hints pretty good, so if it's given, look through labs to see how to apply it)
(Rows in final dataframe?
Want to see if you can corroberate finding in the paper, so think about sites close versus far. Think about some kind of average relative abundance. Probably not the only way, but likely makes sense. Could be one row, could be more than one, but then the interpretation could be harder. We're also doing this without applying any stats)

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

```r
invidodata %>%
  tabyl(Distance, LandUse) %>% 
  adorn_percentages() %>%
  adorn_pct_formatting(digits = 1) %>%
  adorn_ns()
```

```
##  Distance    Logging    Neither       Park
##      2.70   0.0% (0) 100.0% (1)   0.0% (0)
##      2.92 100.0% (1)   0.0% (0)   0.0% (0)
##      3.83   0.0% (0) 100.0% (1)   0.0% (0)
##      5.13 100.0% (1)   0.0% (0)   0.0% (0)
##      5.14   0.0% (0) 100.0% (1)   0.0% (0)
##      5.33 100.0% (1)   0.0% (0)   0.0% (0)
##      5.78   0.0% (0) 100.0% (1)   0.0% (0)
##      6.10 100.0% (1)   0.0% (0)   0.0% (0)
##      6.61 100.0% (2)   0.0% (0)   0.0% (0)
##      7.14   0.0% (0)   0.0% (0) 100.0% (1)
##      8.23 100.0% (1)   0.0% (0)   0.0% (0)
##     11.21 100.0% (1)   0.0% (0)   0.0% (0)
##     13.96 100.0% (1)   0.0% (0)   0.0% (0)
##     15.02 100.0% (1)   0.0% (0)   0.0% (0)
##     15.95   0.0% (0)   0.0% (0) 100.0% (1)
##     17.31   0.0% (0)   0.0% (0) 100.0% (1)
##     17.47   0.0% (0)   0.0% (0) 100.0% (1)
##     18.32   0.0% (0)   0.0% (0) 100.0% (1)
##     18.85 100.0% (1)   0.0% (0)   0.0% (0)
##     19.81 100.0% (1)   0.0% (0)   0.0% (0)
##     20.85 100.0% (1)   0.0% (0)   0.0% (0)
##     24.06   0.0% (0)   0.0% (0) 100.0% (1)
##     26.76   0.0% (0)   0.0% (0) 100.0% (1)
```

