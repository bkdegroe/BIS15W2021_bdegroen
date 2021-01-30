---
title: "Synthwave85"
output: 
  html_document: 
    keep_md: yes
---



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

## Including Plots

You can also embed plots, for example:

![](RStudio-Themes_files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


```r
rstudioapi::addTheme("https://raw.githubusercontent.com/jnolis/synthwave85/master/Synthwave85.rstheme", TRUE, TRUE, FALSE)
```

```
## [1] "Synthwave85"
```


```r
rstudioapi::removeTheme("Synthwave85")
```

```
## NULL
```


```r
#Hacker theme
rstudioapi::addTheme("https://raw.githubusercontent.com/jsta/hacker_green/master/hacker_green.rstheme", apply = TRUE)
```

```
## [1] "Hacker green"
```

```r
rstudioapi::removeTheme("Hacker green")
```

```
## NULL
```


```r
rstudioapi::addTheme("https://raw.githubusercontent.com/daylerees/colour-schemes/master/sublime/contrast/tron-contrast.tmTheme", apply = TRUE)
```

```
## [1] "Tron Contrast"
```

```r
rstudioapi::removeTheme("Tron Contrast")
```

```
## NULL
```

