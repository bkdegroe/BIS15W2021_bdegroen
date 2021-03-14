---
title: "Lab 7 Homework"
author: "Berlin DeGroen"
date: "2021-03-14"
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
library(skimr)
```

## Data
**1. For this homework, we will use two different data sets. Please load `amniota` and `amphibio`.**  

`amniota` data:  
Myhrvold N, Baldridge E, Chan B, Sivam D, Freeman DL, Ernest SKM (2015). “An amniote life-history
database to perform comparative analyses with birds, mammals, and reptiles.” _Ecology_, *96*, 3109.
doi: 10.1890/15-0846.1 (URL: https://doi.org/10.1890/15-0846.1).

```r
amniota <- readr::read_csv("data/amniota.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   common_name = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

`amphibio` data:  
Oliveira BF, São-Pedro VA, Santos-Barrera G, Penone C, Costa GC (2017). “AmphiBIO, a global database
for amphibian ecological traits.” _Scientific Data_, *4*, 170123. doi: 10.1038/sdata.2017.123 (URL:
https://doi.org/10.1038/sdata.2017.123).

```r
amphibio<- readr::read_csv("data/amphibio.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   id = col_character(),
##   Order = col_character(),
##   Family = col_character(),
##   Genus = col_character(),
##   Species = col_character(),
##   Seeds = col_logical(),
##   OBS = col_logical()
## )
## ℹ Use `spec()` for the full column specifications.
```

```
## Warning: 125 parsing failures.
##  row col           expected                                                           actual                file
## 1410 OBS 1/0/T/F/TRUE/FALSE Identified as P. appendiculata in Boquimpani-Freitas et al. 2002 'data/amphibio.csv'
## 1416 OBS 1/0/T/F/TRUE/FALSE Identified as T. miliaris in Giaretta and Facure 2004            'data/amphibio.csv'
## 1447 OBS 1/0/T/F/TRUE/FALSE Considered endangered by Soto-Azat et al. 2013                   'data/amphibio.csv'
## 1448 OBS 1/0/T/F/TRUE/FALSE Considered extinct by Soto-Azat et al. 2013                      'data/amphibio.csv'
## 1471 OBS 1/0/T/F/TRUE/FALSE nomem dubitum                                                    'data/amphibio.csv'
## .... ... .................. ................................................................ ...................
## See problems(...) for more details.
```

## Questions  
**2. Do some exploratory analysis of the `amniota` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
summary(amniota)
```

```
##     class              order              family             genus          
##  Length:21322       Length:21322       Length:21322       Length:21322      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##    species            subspecies   common_name        female_maturity_d 
##  Length:21322       Min.   :-999   Length:21322       Min.   :-30258.7  
##  Class :character   1st Qu.:-999   Class :character   1st Qu.:  -999.0  
##  Mode  :character   Median :-999   Mode  :character   Median :  -999.0  
##                     Mean   :-999                      Mean   :  -723.7  
##                     3rd Qu.:-999                      3rd Qu.:  -999.0  
##                     Max.   :-999                      Max.   :  9131.2  
##  litter_or_clutch_size_n litters_or_clutches_per_y adult_body_mass_g  
##  Min.   :-999.000        Min.   :-999.0            Min.   :     -999  
##  1st Qu.:-999.000        1st Qu.:-999.0            1st Qu.:        4  
##  Median :   1.692        Median :-999.0            Median :       24  
##  Mean   :-383.909        Mean   :-766.8            Mean   :    29107  
##  3rd Qu.:   3.200        3rd Qu.:-999.0            3rd Qu.:      135  
##  Max.   : 156.000        Max.   :  52.0            Max.   :149000000  
##  maximum_longevity_y  gestation_d       weaning_d     
##  Min.   :-999.000    Min.   :-999.0   Min.   :-999.0  
##  1st Qu.:-999.000    1st Qu.:-999.0   1st Qu.:-999.0  
##  Median :-999.000    Median :-999.0   Median :-999.0  
##  Mean   :-737.061    Mean   :-874.9   Mean   :-892.4  
##  3rd Qu.:   1.083    3rd Qu.:-999.0   3rd Qu.:-999.0  
##  Max.   : 211.000    Max.   :7396.9   Max.   :1826.2  
##  birth_or_hatching_weight_g weaning_weight_g     egg_mass_g     
##  Min.   :   -999.0          Min.   :    -999   Min.   :-999.00  
##  1st Qu.:   -999.0          1st Qu.:    -999   1st Qu.:-999.00  
##  Median :   -999.0          Median :    -999   Median :-999.00  
##  Mean   :    -88.6          Mean   :    1116   Mean   :-739.64  
##  3rd Qu.:   -999.0          3rd Qu.:    -999   3rd Qu.:   0.56  
##  Max.   :2250000.0          Max.   :17000000   Max.   :1500.00  
##   incubation_d    fledging_age_d    longevity_y       male_maturity_d 
##  Min.   :-999.0   Min.   :-999.0   Min.   :-999.000   Min.   :-999.0  
##  1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.000   1st Qu.:-999.0  
##  Median :-999.0   Median :-999.0   Median :-999.000   Median :-999.0  
##  Mean   :-820.5   Mean   :-909.4   Mean   :-737.821   Mean   :-827.8  
##  3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:   1.042   3rd Qu.:-999.0  
##  Max.   :1762.0   Max.   : 345.0   Max.   : 177.000   Max.   :9131.2  
##  inter_litter_or_interbirth_interval_y female_body_mass_g male_body_mass_g 
##  Min.   :-999.000                      Min.   :   -999    Min.   :   -999  
##  1st Qu.:-999.000                      1st Qu.:   -999    1st Qu.:   -999  
##  Median :-999.000                      Median :   -999    Median :   -999  
##  Mean   :-932.502                      Mean   :     41    Mean   :   1243  
##  3rd Qu.:-999.000                      3rd Qu.:     14    3rd Qu.:     13  
##  Max.   :   4.847                      Max.   :3700000    Max.   :4545000  
##  no_sex_body_mass_g   egg_width_mm    egg_length_mm    fledging_mass_g 
##  Min.   :     -999   Min.   :-999.0   Min.   :-999.0   Min.   :-999.0  
##  1st Qu.:     -999   1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.0  
##  Median :     -999   Median :-999.0   Median :-999.0   Median :-999.0  
##  Mean   :    30689   Mean   :-970.5   Mean   :-968.9   Mean   :-984.6  
##  3rd Qu.:       28   3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:-999.0  
##  Max.   :136000000   Max.   : 125.0   Max.   : 455.0   Max.   :9992.0  
##   adult_svl_cm       male_svl_cm     female_svl_cm    birth_or_hatching_svl_cm
##  Min.   :-999.000   Min.   :-999.0   Min.   :-999.0   Min.   :-999.0          
##  1st Qu.:-999.000   1st Qu.:-999.0   1st Qu.:-999.0   1st Qu.:-999.0          
##  Median :-999.000   Median :-999.0   Median :-999.0   Median :-999.0          
##  Mean   :-656.153   Mean   :-985.1   Mean   :-947.4   Mean   :-940.3          
##  3rd Qu.:   9.499   3rd Qu.:-999.0   3rd Qu.:-999.0   3rd Qu.:-999.0          
##  Max.   :3049.000   Max.   : 315.2   Max.   :1125.0   Max.   : 760.0          
##  female_svl_at_maturity_cm female_body_mass_at_maturity_g no_sex_svl_cm   
##  Min.   :-999.0            Min.   :  -999.0               Min.   :-999.0  
##  1st Qu.:-999.0            1st Qu.:  -999.0               1st Qu.:-999.0  
##  Median :-999.0            Median :  -999.0               Median :-999.0  
##  Mean   :-989.4            Mean   :  -980.6               Mean   :-747.1  
##  3rd Qu.:-999.0            3rd Qu.:  -999.0               3rd Qu.:-999.0  
##  Max.   : 580.0            Max.   :194000.0               Max.   :3300.0  
##  no_sex_maturity_d
##  Min.   : -999.0  
##  1st Qu.: -999.0  
##  Median : -999.0  
##  Mean   : -942.6  
##  3rd Qu.: -999.0  
##  Max.   :14610.0
```

The negative -999 in the data indicate that there are NAs


```r
amniota %>% 
  skimr::skim()
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |21322      |
|Number of columns        |36         |
|_______________________  |           |
|Column type frequency:   |           |
|character                |6          |
|numeric                  |30         |
|________________________ |           |
|Group variables          |None       |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|class         |         0|             1|   4|   8|     0|        3|          0|
|order         |         0|             1|   6|  19|     0|       72|          0|
|family        |         0|             1|   6|  19|     0|      465|          0|
|genus         |         0|             1|   2|  20|     0|     4336|          0|
|species       |         0|             1|   2|  21|     0|    11548|          0|
|common_name   |         0|             1|   2| 306|     0|    19625|          0|


**Variable type: numeric**

|skim_variable                         | n_missing| complete_rate|     mean|         sd|        p0|     p25|     p50|     p75|         p100|hist  |
|:-------------------------------------|---------:|-------------:|--------:|----------:|---------:|-------:|-------:|-------:|------------:|:-----|
|subspecies                            |         0|             1|  -999.00|       0.00|   -999.00| -999.00| -999.00| -999.00|      -999.00|▁▁▇▁▁ |
|female_maturity_d                     |         0|             1|  -723.70|     830.62| -30258.71| -999.00| -999.00| -999.00|      9131.25|▁▁▁▇▁ |
|litter_or_clutch_size_n               |         0|             1|  -383.91|     488.39|   -999.00| -999.00|    1.69|    3.20|       156.00|▅▁▁▁▇ |
|litters_or_clutches_per_y             |         0|             1|  -766.76|     422.48|   -999.00| -999.00| -999.00| -999.00|        52.00|▇▁▁▁▂ |
|adult_body_mass_g                     |         0|             1| 29107.30| 1278639.85|   -999.00|    4.44|   23.61|  135.00| 149000000.00|▇▁▁▁▁ |
|maximum_longevity_y                   |         0|             1|  -737.06|     444.36|   -999.00| -999.00| -999.00|    1.08|       211.00|▇▁▁▁▃ |
|gestation_d                           |         0|             1|  -874.91|     353.92|   -999.00| -999.00| -999.00| -999.00|      7396.92|▇▁▁▁▁ |
|weaning_d                             |         0|             1|  -892.45|     330.67|   -999.00| -999.00| -999.00| -999.00|      1826.25|▇▁▁▁▁ |
|birth_or_hatching_weight_g            |         0|             1|   -88.57|   26484.20|   -999.00| -999.00| -999.00| -999.00|   2250000.00|▇▁▁▁▁ |
|weaning_weight_g                      |         0|             1|  1116.10|  134348.60|   -999.00| -999.00| -999.00| -999.00|  17000000.00|▇▁▁▁▁ |
|egg_mass_g                            |         0|             1|  -739.64|     445.35|   -999.00| -999.00| -999.00|    0.56|      1500.00|▇▁▂▁▁ |
|incubation_d                          |         0|             1|  -820.49|     394.55|   -999.00| -999.00| -999.00| -999.00|      1762.00|▇▂▁▁▁ |
|fledging_age_d                        |         0|             1|  -909.42|     291.29|   -999.00| -999.00| -999.00| -999.00|       345.00|▇▁▁▁▁ |
|longevity_y                           |         0|             1|  -737.82|     443.03|   -999.00| -999.00| -999.00|    1.04|       177.00|▇▁▁▁▃ |
|male_maturity_d                       |         0|             1|  -827.77|     595.69|   -999.00| -999.00| -999.00| -999.00|      9131.25|▇▁▁▁▁ |
|inter_litter_or_interbirth_interval_y |         0|             1|  -932.50|     249.14|   -999.00| -999.00| -999.00| -999.00|         4.85|▇▁▁▁▁ |
|female_body_mass_g                    |         0|             1|    40.59|   27536.51|   -999.00| -999.00| -999.00|   14.50|   3700000.00|▇▁▁▁▁ |
|male_body_mass_g                      |         0|             1|  1242.90|   62044.69|   -999.00| -999.00| -999.00|   13.34|   4545000.00|▇▁▁▁▁ |
|no_sex_body_mass_g                    |         0|             1| 30689.26| 1467346.84|   -999.00| -999.00| -999.00|   27.77| 136000000.00|▇▁▁▁▁ |
|egg_width_mm                          |         0|             1|  -970.48|     168.36|   -999.00| -999.00| -999.00| -999.00|       125.00|▇▁▁▁▁ |
|egg_length_mm                         |         0|             1|  -968.89|     174.10|   -999.00| -999.00| -999.00| -999.00|       455.00|▇▁▁▁▁ |
|fledging_mass_g                       |         0|             1|  -984.64|     211.46|   -999.00| -999.00| -999.00| -999.00|      9992.00|▇▁▁▁▁ |
|adult_svl_cm                          |         0|             1|  -656.15|     490.74|   -999.00| -999.00| -999.00|    9.50|      3049.00|▇▃▁▁▁ |
|male_svl_cm                           |         0|             1|  -985.12|     120.02|   -999.00| -999.00| -999.00| -999.00|       315.20|▇▁▁▁▁ |
|female_svl_cm                         |         0|             1|  -947.35|     223.83|   -999.00| -999.00| -999.00| -999.00|      1125.00|▇▁▁▁▁ |
|birth_or_hatching_svl_cm              |         0|             1|  -940.34|     236.74|   -999.00| -999.00| -999.00| -999.00|       760.00|▇▁▁▁▁ |
|female_svl_at_maturity_cm             |         0|             1|  -989.36|      98.74|   -999.00| -999.00| -999.00| -999.00|       580.00|▇▁▁▁▁ |
|female_body_mass_at_maturity_g        |         0|             1|  -980.61|    1888.55|   -999.00| -999.00| -999.00| -999.00|    194000.00|▇▁▁▁▁ |
|no_sex_svl_cm                         |         0|             1|  -747.14|     442.27|   -999.00| -999.00| -999.00| -999.00|      3300.00|▇▂▁▁▁ |
|no_sex_maturity_d                     |         0|             1|  -942.59|     465.04|   -999.00| -999.00| -999.00| -999.00|     14610.00|▇▁▁▁▁ |

```r
#Curious where -30259 came from, maybe multiple -999 recordings?
-30259/-999
```

```
## [1] 30.28929
```

The NAs in this dataset seem to be represented by -999.



```r
amniota_no_nas <- amniota %>%
  na_if("-999")
summary(amniota_no_nas)
```

```
##     class              order              family             genus          
##  Length:21322       Length:21322       Length:21322       Length:21322      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##    species            subspecies    common_name        female_maturity_d 
##  Length:21322       Min.   : NA     Length:21322       Min.   :-30258.7  
##  Class :character   1st Qu.: NA     Class :character   1st Qu.:   288.4  
##  Mode  :character   Median : NA     Mode  :character   Median :   365.0  
##                     Mean   :NaN                        Mean   :   691.2  
##                     3rd Qu.: NA                        3rd Qu.:   819.3  
##                     Max.   : NA                        Max.   :  9131.2  
##                     NA's   :21322                      NA's   :17849     
##  litter_or_clutch_size_n litters_or_clutches_per_y adult_body_mass_g  
##  Min.   :  0.900         Min.   : 0.120            Min.   :        0  
##  1st Qu.:  2.000         1st Qu.: 1.000            1st Qu.:       15  
##  Median :  2.800         Median : 1.050            Median :       44  
##  Mean   :  3.826         Mean   : 1.752            Mean   :    37493  
##  3rd Qu.:  4.150         3rd Qu.: 2.000            3rd Qu.:      238  
##  Max.   :156.000         Max.   :52.000            Max.   :149000000  
##  NA's   :8244            NA's   :16374             NA's   :4645       
##  maximum_longevity_y  gestation_d        weaning_d      
##  Min.   :  0.083     Min.   :   5.00   Min.   :   1.94  
##  1st Qu.:  6.000     1st Qu.:  29.91   1st Qu.:  27.75  
##  Median : 12.308     Median :  63.92   Median :  51.60  
##  Mean   : 16.466     Mean   : 105.28   Mean   : 113.05  
##  3rd Qu.: 22.000     3rd Qu.: 151.88   3rd Qu.: 129.83  
##  Max.   :211.000     Max.   :7396.92   Max.   :1826.25  
##  NA's   :15822       NA's   :18926     NA's   :19279    
##  birth_or_hatching_weight_g weaning_weight_g     egg_mass_g      
##  Min.   :0.00e+00           Min.   :       1   Min.   :   0.218  
##  1st Qu.:1.30e+00           1st Qu.:      13   1st Qu.:   2.100  
##  Median :5.90e+00           Median :      43   Median :   5.100  
##  Mean   :4.48e+03           Mean   :   41386   Mean   :  22.252  
##  3rd Qu.:4.39e+01           3rd Qu.:     850   3rd Qu.:  20.100  
##  Max.   :2.25e+06           Max.   :17000000   Max.   :1500.000  
##  NA's   :17779              NA's   :20258      NA's   :15907     
##   incubation_d     fledging_age_d   longevity_y      male_maturity_d  
##  Min.   :   2.00   Min.   :  1.0   Min.   :  0.083   Min.   :  30.44  
##  1st Qu.:  17.00   1st Qu.: 16.5   1st Qu.:  5.500   1st Qu.: 365.00  
##  Median :  29.25   Median : 27.5   Median : 10.700   Median : 365.25  
##  Mean   :  46.67   Mean   : 36.8   Mean   : 13.521   Mean   : 787.16  
##  3rd Qu.:  59.50   3rd Qu.: 46.0   3rd Qu.: 18.200   3rd Qu.: 913.00  
##  Max.   :1762.00   Max.   :345.0   Max.   :177.000   Max.   :9131.25  
##  NA's   :17682     NA's   :19478   NA's   :15822     NA's   :19278    
##  inter_litter_or_interbirth_interval_y female_body_mass_g male_body_mass_g 
##  Min.   :0.047                         Min.   :      0    Min.   :      0  
##  1st Qu.:0.318                         1st Qu.:     14    1st Qu.:     16  
##  Median :0.999                         Median :     41    Median :     48  
##  Mean   :0.907                         Mean   :   2076    Mean   :   6197  
##  3rd Qu.:1.000                         3rd Qu.:    220    3rd Qu.:    246  
##  Max.   :4.847                         Max.   :3700000    Max.   :4545000  
##  NA's   :19904                         NA's   :14113      NA's   :14679    
##  no_sex_body_mass_g   egg_width_mm    egg_length_mm    fledging_mass_g  
##  Min.   :        0   Min.   :  2.50   Min.   :  2.50   Min.   :   4.85  
##  1st Qu.:       13   1st Qu.:  8.00   1st Qu.: 10.94   1st Qu.:  14.60  
##  Median :       35   Median : 13.00   Median : 19.98   Median :  24.80  
##  Mean   :    68952   Mean   : 22.99   Mean   : 36.40   Mean   : 452.27  
##  3rd Qu.:      164   3rd Qu.: 35.90   3rd Qu.: 58.92   3rd Qu.: 107.00  
##  Max.   :136000000   Max.   :125.00   Max.   :455.00   Max.   :9992.00  
##  NA's   :11663       NA's   :20727    NA's   :20702    NA's   :21111    
##   adult_svl_cm      male_svl_cm     female_svl_cm      birth_or_hatching_svl_cm
##  Min.   :   1.79   Min.   :  1.57   Min.   :   1.800   Min.   :  0.400         
##  1st Qu.:   9.50   1st Qu.: 21.41   1st Qu.:   5.756   1st Qu.:  2.450         
##  Median :  18.50   Median : 35.85   Median :   8.150   Median :  3.300         
##  Mean   :  38.20   Mean   : 50.44   Mean   :  20.609   Mean   : 12.099         
##  3rd Qu.:  40.50   3rd Qu.: 63.39   3rd Qu.:  17.721   3rd Qu.:  5.256         
##  Max.   :3049.00   Max.   :315.20   Max.   :1125.000   Max.   :759.999         
##  NA's   :14274     NA's   :21040    NA's   :20242      NA's   :20085           
##  female_svl_at_maturity_cm female_body_mass_at_maturity_g no_sex_svl_cm   
##  Min.   :  2.85            Min.   :    30.0               Min.   :   1.7  
##  1st Qu.:  4.90            1st Qu.:    82.5               1st Qu.:   5.7  
##  Median :  6.00            Median : 97050.0               Median :   7.7  
##  Mean   : 18.69            Mean   : 97032.5               Mean   :  20.0  
##  3rd Qu.:  8.40            3rd Qu.:194000.0               3rd Qu.:  11.0  
##  Max.   :580.00            Max.   :194000.0               Max.   :3300.0  
##  NA's   :21120             NA's   :21318                  NA's   :16052   
##  no_sex_maturity_d
##  Min.   :   33.0  
##  1st Qu.:  365.3  
##  Median :  913.1  
##  Mean   : 1604.5  
##  3rd Qu.: 2008.9  
##  Max.   :14610.0  
##  NA's   :20860
```



```r
#Trying to figure out what -30258.71100 is
#amniota_no_nas %>%
#  filter(female_maturity_d >= 50) %>%
#  tabyl(female_maturity_d)
#Hashtagged this out because the output was way too long
#this might be what you were trying to do?
```

```r
#What Min-Yao suggested for getting rid of that one negative value:
amniota_na <- amniota %>% 
  na_if("-999") %>% #converts all -999 values to NA
  mutate(female_maturity_d_new = ifelse(female_maturity_d < 0, NA, female_maturity_d)) %>% 
  select(-female_maturity_d)

amniota_na %>% 
  summarize(number_nas = sum(is.na(amniota_na)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528200
```



**3. Do some exploratory analysis of the `amphibio` data set. Use the function(s) of your choice. Try to get an idea of how NA's are represented in the data.**  


```r
summary(amphibio)
```

```
##       id               Order              Family             Genus          
##  Length:6776        Length:6776        Length:6776        Length:6776       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##    Species               Fos            Ter            Aqu            Arb      
##  Length:6776        Min.   :1      Min.   :1      Min.   :1      Min.   :1     
##  Class :character   1st Qu.:1      1st Qu.:1      1st Qu.:1      1st Qu.:1     
##  Mode  :character   Median :1      Median :1      Median :1      Median :1     
##                     Mean   :1      Mean   :1      Mean   :1      Mean   :1     
##                     3rd Qu.:1      3rd Qu.:1      3rd Qu.:1      3rd Qu.:1     
##                     Max.   :1      Max.   :1      Max.   :1      Max.   :1     
##                     NA's   :6053   NA's   :1104   NA's   :2810   NA's   :4347  
##      Leaves        Flowers      Seeds             Fruits         Arthro    
##  Min.   :1      Min.   :1      Mode:logical   Min.   :1      Min.   :1     
##  1st Qu.:1      1st Qu.:1      TRUE:4         1st Qu.:1      1st Qu.:1     
##  Median :1      Median :1      NA's:6772      Median :1      Median :1     
##  Mean   :1      Mean   :1                     Mean   :1      Mean   :1     
##  3rd Qu.:1      3rd Qu.:1                     3rd Qu.:1      3rd Qu.:1     
##  Max.   :1      Max.   :1                     Max.   :1      Max.   :1     
##  NA's   :6752   NA's   :6772                  NA's   :6774   NA's   :5534  
##       Vert           Diu            Noc           Crepu         Wet_warm   
##  Min.   :1      Min.   :1      Min.   :1      Min.   :1      Min.   :1     
##  1st Qu.:1      1st Qu.:1      1st Qu.:1      1st Qu.:1      1st Qu.:1     
##  Median :1      Median :1      Median :1      Median :1      Median :1     
##  Mean   :1      Mean   :1      Mean   :1      Mean   :1      Mean   :1     
##  3rd Qu.:1      3rd Qu.:1      3rd Qu.:1      3rd Qu.:1      3rd Qu.:1     
##  Max.   :1      Max.   :1      Max.   :1      Max.   :1      Max.   :1     
##  NA's   :6657   NA's   :5876   NA's   :5156   NA's   :6608   NA's   :5997  
##     Wet_cold       Dry_warm       Dry_cold     Body_mass_g      
##  Min.   :1      Min.   :1      Min.   :1      Min.   :    0.16  
##  1st Qu.:1      1st Qu.:1      1st Qu.:1      1st Qu.:    2.60  
##  Median :1      Median :1      Median :1      Median :    9.29  
##  Mean   :1      Mean   :1      Mean   :1      Mean   :   94.56  
##  3rd Qu.:1      3rd Qu.:1      3rd Qu.:1      3rd Qu.:   31.82  
##  Max.   :1      Max.   :1      Max.   :1      Max.   :26000.00  
##  NA's   :6625   NA's   :6572   NA's   :6735   NA's   :6185      
##  Age_at_maturity_min_y Age_at_maturity_max_y  Body_size_mm    
##  Min.   :0.25          Min.   : 0.300        Min.   :   8.40  
##  1st Qu.:1.00          1st Qu.: 2.000        1st Qu.:  29.00  
##  Median :2.00          Median : 3.000        Median :  43.00  
##  Mean   :2.14          Mean   : 2.964        Mean   :  66.65  
##  3rd Qu.:3.00          3rd Qu.: 4.000        3rd Qu.:  69.15  
##  Max.   :7.00          Max.   :12.000        Max.   :1520.00  
##  NA's   :6392          NA's   :6392          NA's   :1549     
##  Size_at_maturity_min_mm Size_at_maturity_max_mm Longevity_max_y 
##  Min.   :  8.80          Min.   : 10.10          Min.   :  0.17  
##  1st Qu.: 27.50          1st Qu.: 32.00          1st Qu.:  6.00  
##  Median : 43.00          Median : 50.00          Median : 10.00  
##  Mean   : 56.63          Mean   : 67.46          Mean   : 11.68  
##  3rd Qu.: 58.00          3rd Qu.: 75.50          3rd Qu.: 15.00  
##  Max.   :350.00          Max.   :400.00          Max.   :121.80  
##  NA's   :6529            NA's   :6528            NA's   :6417    
##  Litter_size_min_n Litter_size_max_n Reproductive_output_y
##  Min.   :    1.0   Min.   :    1     Min.   : 0.080       
##  1st Qu.:   18.0   1st Qu.:   30     1st Qu.: 1.000       
##  Median :   80.0   Median :  186     Median : 1.000       
##  Mean   :  530.9   Mean   : 1034     Mean   : 1.034       
##  3rd Qu.:  300.0   3rd Qu.:  700     3rd Qu.: 1.000       
##  Max.   :25000.0   Max.   :45054     Max.   :15.000       
##  NA's   :5153      NA's   :5153      NA's   :2344         
##  Offspring_size_min_mm Offspring_size_max_mm      Dir              Lar        
##  Min.   : 0.200        Min.   : 0.400        Min.   :0.0000   Min.   :0.0000  
##  1st Qu.: 1.400        1st Qu.: 1.600        1st Qu.:0.0000   1st Qu.:0.0000  
##  Median : 2.000        Median : 2.300        Median :0.0000   Median :1.0000  
##  Mean   : 2.455        Mean   : 2.857        Mean   :0.2984   Mean   :0.6921  
##  3rd Qu.: 3.000        3rd Qu.: 3.500        3rd Qu.:1.0000   3rd Qu.:1.0000  
##  Max.   :20.000        Max.   :25.000        Max.   :1.0000   Max.   :1.0000  
##  NA's   :5446          NA's   :5446          NA's   :1079     NA's   :1079    
##       Viv           OBS         
##  Min.   :0.0000   Mode:logical  
##  1st Qu.:0.0000   NA's:6776     
##  Median :0.0000                 
##  Mean   :0.0095                 
##  3rd Qu.:0.0000                 
##  Max.   :1.0000                 
##  NA's   :1079
```

```r
glimpse(amphibio)
```

```
## Rows: 6,776
## Columns: 38
## $ id                      <chr> "Anf0001", "Anf0002", "Anf0003", "Anf0004", "A…
## $ Order                   <chr> "Anura", "Anura", "Anura", "Anura", "Anura", "…
## $ Family                  <chr> "Allophrynidae", "Alytidae", "Alytidae", "Alyt…
## $ Genus                   <chr> "Allophryne", "Alytes", "Alytes", "Alytes", "A…
## $ Species                 <chr> "Allophryne ruthveni", "Alytes cisternasii", "…
## $ Fos                     <dbl> NA, NA, NA, NA, NA, 1, 1, 1, 1, 1, 1, 1, 1, NA…
## $ Ter                     <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ Aqu                     <dbl> 1, 1, 1, 1, NA, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ Arb                     <dbl> 1, 1, 1, 1, 1, 1, NA, NA, NA, NA, NA, NA, NA, …
## $ Leaves                  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Flowers                 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Seeds                   <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Fruits                  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Arthro                  <dbl> 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, 1, 1, NA, NA, …
## $ Vert                    <dbl> NA, NA, NA, NA, NA, NA, 1, NA, NA, NA, 1, 1, N…
## $ Diu                     <dbl> 1, NA, NA, NA, NA, NA, 1, 1, 1, NA, 1, 1, NA, …
## $ Noc                     <dbl> 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, 1, 1, 1, NA, N…
## $ Crepu                   <dbl> 1, NA, NA, NA, NA, 1, NA, NA, NA, NA, NA, NA, …
## $ Wet_warm                <dbl> NA, NA, NA, NA, 1, 1, NA, NA, NA, NA, 1, NA, N…
## $ Wet_cold                <dbl> 1, NA, NA, NA, NA, NA, 1, NA, NA, NA, NA, NA, …
## $ Dry_warm                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Dry_cold                <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ Body_mass_g             <dbl> 31.00, 6.10, NA, NA, 2.31, 13.40, 21.80, NA, N…
## $ Age_at_maturity_min_y   <dbl> NA, 2.0, 2.0, NA, 3.0, 2.0, 3.0, NA, NA, NA, 4…
## $ Age_at_maturity_max_y   <dbl> NA, 2.0, 2.0, NA, 3.0, 3.0, 5.0, NA, NA, NA, 4…
## $ Body_size_mm            <dbl> 31.0, 50.0, 55.0, NA, 40.0, 55.0, 80.0, 60.0, …
## $ Size_at_maturity_min_mm <dbl> NA, 27, NA, NA, NA, 35, NA, NA, NA, NA, NA, NA…
## $ Size_at_maturity_max_mm <dbl> NA, 36.0, NA, NA, NA, 40.5, NA, NA, NA, NA, NA…
## $ Longevity_max_y         <dbl> NA, 6, NA, NA, NA, 7, 9, NA, NA, NA, NA, NA, N…
## $ Litter_size_min_n       <dbl> 300, 60, 40, NA, 7, 53, 300, 1500, 1000, NA, 2…
## $ Litter_size_max_n       <dbl> 300, 180, 40, NA, 20, 171, 1500, 1500, 1000, N…
## $ Reproductive_output_y   <dbl> 1, 4, 1, 4, 1, 4, 6, 1, 1, 1, 1, 1, 1, 1, NA, …
## $ Offspring_size_min_mm   <dbl> NA, 2.6, NA, NA, 5.4, 2.6, 1.5, NA, 1.5, NA, 1…
## $ Offspring_size_max_mm   <dbl> NA, 3.5, NA, NA, 7.0, 5.0, 2.0, NA, 1.5, NA, 1…
## $ Dir                     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, N…
## $ Lar                     <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, N…
## $ Viv                     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, N…
## $ OBS                     <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```

The data for the amphibio dataset seems to be represented by NAs.




```r
naniar::miss_var_summary(amphibio)
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 OBS        6776    100  
##  2 Fruits     6774    100. 
##  3 Flowers    6772     99.9
##  4 Seeds      6772     99.9
##  5 Leaves     6752     99.6
##  6 Dry_cold   6735     99.4
##  7 Vert       6657     98.2
##  8 Wet_cold   6625     97.8
##  9 Crepu      6608     97.5
## 10 Dry_warm   6572     97.0
## # … with 28 more rows
```


**4. How many total NA's are in each data set? Do these values make sense? Are NA's represented by values?**   


```r
amniota %>% 
  summarize(number_nas = sum(is.na(amniota)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1          0
```
No, the values don't make sense for amniota.

(Answer on Professor's key: For such a large data set, it is unlikely that there are no NA's. It appears that NA's are represented by "-999".)



```r
amphibio %>% 
  summarize(number_nas = sum(is.na(amphibio)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     170691
```
Yes, in the case of amphibio.

(Answer on Professor's key: In this data set, NA's are represented by NA and not values.)

**5. Make any necessary replacements in the data such that all NA's appear as "NA".**  

For some reason I only did amphibio beforehand:

```r
#amphibio_na <- amphibio %>%
#  na_if("0")
#amphibio_na %>% 
#  summarize(number_nas = sum(is.na(amphibio_na)))
```


The following is mostly following professor's key:

```r
amniota_na_b <- amniota %>%
  na_if("-999")
```


```r
amniota_na_b %>% 
  summarize(number_nas = sum(is.na(amniota_na_b)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528196
```

```r
amniota_na_b %>% 
  filter(female_maturity_d=="-30258.711") 
```

```
## # A tibble: 4 x 36
##   class order   family   genus  species subspecies common_name  female_maturity…
##   <chr> <chr>   <chr>    <chr>  <chr>        <dbl> <chr>                   <dbl>
## 1 Aves  Accipi… Accipit… Circus melano…         NA Pied Harrier          -30259.
## 2 Aves  Passer… Viduidae Vidua  funerea         NA Dusky Indig…          -30259.
## 3 Aves  Passer… Viduidae Vidua  nigeri…         NA Quailfinch …          -30259.
## 4 Aves  Passer… Viduidae Vidua  purpur…         NA Purple Indi…          -30259.
## # … with 28 more variables: litter_or_clutch_size_n <dbl>,
## #   litters_or_clutches_per_y <dbl>, adult_body_mass_g <dbl>,
## #   maximum_longevity_y <dbl>, gestation_d <dbl>, weaning_d <dbl>,
## #   birth_or_hatching_weight_g <dbl>, weaning_weight_g <dbl>, egg_mass_g <dbl>,
## #   incubation_d <dbl>, fledging_age_d <dbl>, longevity_y <dbl>,
## #   male_maturity_d <dbl>, inter_litter_or_interbirth_interval_y <dbl>,
## #   female_body_mass_g <dbl>, male_body_mass_g <dbl>, no_sex_body_mass_g <dbl>,
## #   egg_width_mm <dbl>, egg_length_mm <dbl>, fledging_mass_g <dbl>,
## #   adult_svl_cm <dbl>, male_svl_cm <dbl>, female_svl_cm <dbl>,
## #   birth_or_hatching_svl_cm <dbl>, female_svl_at_maturity_cm <dbl>,
## #   female_body_mass_at_maturity_g <dbl>, no_sex_svl_cm <dbl>,
## #   no_sex_maturity_d <dbl>
```


```r
names(amniota_na_b)
```

```
##  [1] "class"                                
##  [2] "order"                                
##  [3] "family"                               
##  [4] "genus"                                
##  [5] "species"                              
##  [6] "subspecies"                           
##  [7] "common_name"                          
##  [8] "female_maturity_d"                    
##  [9] "litter_or_clutch_size_n"              
## [10] "litters_or_clutches_per_y"            
## [11] "adult_body_mass_g"                    
## [12] "maximum_longevity_y"                  
## [13] "gestation_d"                          
## [14] "weaning_d"                            
## [15] "birth_or_hatching_weight_g"           
## [16] "weaning_weight_g"                     
## [17] "egg_mass_g"                           
## [18] "incubation_d"                         
## [19] "fledging_age_d"                       
## [20] "longevity_y"                          
## [21] "male_maturity_d"                      
## [22] "inter_litter_or_interbirth_interval_y"
## [23] "female_body_mass_g"                   
## [24] "male_body_mass_g"                     
## [25] "no_sex_body_mass_g"                   
## [26] "egg_width_mm"                         
## [27] "egg_length_mm"                        
## [28] "fledging_mass_g"                      
## [29] "adult_svl_cm"                         
## [30] "male_svl_cm"                          
## [31] "female_svl_cm"                        
## [32] "birth_or_hatching_svl_cm"             
## [33] "female_svl_at_maturity_cm"            
## [34] "female_body_mass_at_maturity_g"       
## [35] "no_sex_svl_cm"                        
## [36] "no_sex_maturity_d"
```


```r
amniota_na_b %>% 
  select(genus, species, female_maturity_d) %>% 
  mutate(female_maturity_d2=ifelse(female_maturity_d<0, NA, female_maturity_d))%>% 
  arrange(female_maturity_d2)
```

```
## # A tibble: 21,322 x 4
##    genus        species       female_maturity_d female_maturity_d2
##    <chr>        <chr>                     <dbl>              <dbl>
##  1 Microtus     californicus               23.8               23.8
##  2 Lemmus       lemmus                     24                 24  
##  3 Microtus     canicaudus                 24.9               24.9
##  4 Microtus     montanus                   24.9               24.9
##  5 Eolagurus    luteus                     27.2               27.2
##  6 Oligoryzomys destructor                 27.7               27.7
##  7 Oligoryzomys longicaudatus              27.7               27.7
##  8 Oligoryzomys magellanicus               27.7               27.7
##  9 Akodon       molinae                    28.1               28.1
## 10 Ototylomys   phyllotis                  28.2               28.2
## # … with 21,312 more rows
```



```r
#What Min-Yao suggested for getting rid of that one negative value:
amniota_na_my <- amniota %>% 
  na_if("-999") %>% #converts all -999 values to NA
  mutate(female_maturity_d_new = ifelse(female_maturity_d < 0, NA, female_maturity_d)) %>% 
  select(-female_maturity_d)

amniota_na %>% 
  summarize(number_nas = sum(is.na(amniota_na)))
```

```
## # A tibble: 1 x 1
##   number_nas
##        <int>
## 1     528200
```

**6. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amniota` data.**  

```r
naniar::miss_var_summary(amniota_na_b)
```

```
## # A tibble: 36 x 3
##    variable                       n_miss pct_miss
##    <chr>                           <int>    <dbl>
##  1 subspecies                      21322    100  
##  2 female_body_mass_at_maturity_g  21318    100. 
##  3 female_svl_at_maturity_cm       21120     99.1
##  4 fledging_mass_g                 21111     99.0
##  5 male_svl_cm                     21040     98.7
##  6 no_sex_maturity_d               20860     97.8
##  7 egg_width_mm                    20727     97.2
##  8 egg_length_mm                   20702     97.1
##  9 weaning_weight_g                20258     95.0
## 10 female_svl_cm                   20242     94.9
## # … with 26 more rows
```

**7. Use the package `naniar` to produce a summary, including percentages, of missing data in each column for the `amphibio` data.**

```r
naniar::miss_var_summary(amphibio)
```

```
## # A tibble: 38 x 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 OBS        6776    100  
##  2 Fruits     6774    100. 
##  3 Flowers    6772     99.9
##  4 Seeds      6772     99.9
##  5 Leaves     6752     99.6
##  6 Dry_cold   6735     99.4
##  7 Vert       6657     98.2
##  8 Wet_cold   6625     97.8
##  9 Crepu      6608     97.5
## 10 Dry_warm   6572     97.0
## # … with 28 more rows
```

## I think for the most part I followed the key from here. I had used amphibio_na for the next few problems when it wasn't needed, so I replaced it with the original amphibio dataset, as no alterations were needed.

**8. For the `amniota` data, calculate the number of NAs in the `egg_mass_g` column sorted by taxonomic class; i.e. how many NA's are present in the `egg_mass_g` column in birds, mammals, and reptiles? Does this results make sense biologically? How do these results affect your interpretation of NA's?**  


```r
amniota_na %>% 
  select(class, egg_mass_g) %>%
  naniar::miss_var_summary(order=T)
```

```
## # A tibble: 2 x 3
##   variable   n_miss pct_miss
##   <chr>       <int>    <dbl>
## 1 egg_mass_g  15907     74.6
## 2 class           0      0
```


**9. The `amphibio` data have variables that classify species as fossorial (burrowing), terrestrial, aquatic, or arboreal. Calculate the number of NA's in each of these variables. Do you think that the authors intend us to think that there are NA's in these columns or could they represent something else? Explain.**

```r
amphibio
```

```
## # A tibble: 6,776 x 38
##    id    Order Family Genus Species   Fos   Ter   Aqu   Arb Leaves Flowers Seeds
##    <chr> <chr> <chr>  <chr> <chr>   <dbl> <dbl> <dbl> <dbl>  <dbl>   <dbl> <lgl>
##  1 Anf0… Anura Allop… Allo… Alloph…    NA     1     1     1     NA      NA NA   
##  2 Anf0… Anura Alyti… Alyt… Alytes…    NA     1     1     1     NA      NA NA   
##  3 Anf0… Anura Alyti… Alyt… Alytes…    NA     1     1     1     NA      NA NA   
##  4 Anf0… Anura Alyti… Alyt… Alytes…    NA     1     1     1     NA      NA NA   
##  5 Anf0… Anura Alyti… Alyt… Alytes…    NA     1    NA     1     NA      NA NA   
##  6 Anf0… Anura Alyti… Alyt… Alytes…     1     1     1     1     NA      NA NA   
##  7 Anf0… Anura Alyti… Disc… Discog…     1     1     1    NA     NA      NA NA   
##  8 Anf0… Anura Alyti… Disc… Discog…     1     1     1    NA     NA      NA NA   
##  9 Anf0… Anura Alyti… Disc… Discog…     1     1     1    NA     NA      NA NA   
## 10 Anf0… Anura Alyti… Disc… Discog…     1     1     1    NA     NA      NA NA   
## # … with 6,766 more rows, and 26 more variables: Fruits <dbl>, Arthro <dbl>,
## #   Vert <dbl>, Diu <dbl>, Noc <dbl>, Crepu <dbl>, Wet_warm <dbl>,
## #   Wet_cold <dbl>, Dry_warm <dbl>, Dry_cold <dbl>, Body_mass_g <dbl>,
## #   Age_at_maturity_min_y <dbl>, Age_at_maturity_max_y <dbl>,
## #   Body_size_mm <dbl>, Size_at_maturity_min_mm <dbl>,
## #   Size_at_maturity_max_mm <dbl>, Longevity_max_y <dbl>,
## #   Litter_size_min_n <dbl>, Litter_size_max_n <dbl>,
## #   Reproductive_output_y <dbl>, Offspring_size_min_mm <dbl>,
## #   Offspring_size_max_mm <dbl>, Dir <dbl>, Lar <dbl>, Viv <dbl>, OBS <lgl>
```

```r
amphibio %>% 
  select(Fos, Ter, Aqu, Arb) %>%
  naniar::miss_var_summary(order=T)
```

```
## # A tibble: 4 x 3
##   variable n_miss pct_miss
##   <chr>     <int>    <dbl>
## 1 Fos        6053     89.3
## 2 Arb        4347     64.2
## 3 Aqu        2810     41.5
## 4 Ter        1104     16.3
```

I think that the NAs could also mean exactly that: 'Not applicable." Some species aren't aquatic, others aren't terrestrial and so on, so they don't apply to certain classifications.

**10. Now that we know how NA's are represented in the `amniota` data, how would you load the data such that the values which represent NA's are automatically converted?**

```r
amniota_converted_na <- 
  readr::read_csv(file = "data/amniota.csv", na = c("-999"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   subspecies = col_logical(),
##   common_name = col_character(),
##   gestation_d = col_logical(),
##   weaning_d = col_logical(),
##   weaning_weight_g = col_logical(),
##   male_svl_cm = col_logical(),
##   female_svl_cm = col_logical(),
##   birth_or_hatching_svl_cm = col_logical(),
##   female_svl_at_maturity_cm = col_logical(),
##   female_body_mass_at_maturity_g = col_logical(),
##   no_sex_svl_cm = col_logical()
## )
## ℹ Use `spec()` for the full column specifications.
```

```
## Warning: 13577 parsing failures.
##  row                      col           expected actual               file
## 9803 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9804 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9805 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9806 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## 9807 birth_or_hatching_svl_cm 1/0/T/F/TRUE/FALSE    4.7 'data/amniota.csv'
## .... ........................ .................. ...... ..................
## See problems(...) for more details.
```
</div>

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
