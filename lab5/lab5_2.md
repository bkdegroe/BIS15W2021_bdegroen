---
title: "dplyr Superhero"
date: "2021-01-21"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to the HW in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab 5 today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. We will spend most of the time in our breakout rooms. Your lab 5 homework will be to knit and push this file to your repository.  

## Load the tidyverse

```r
library("tidyverse")
```

```
## ── Attaching packages ────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
## ✓ tibble  3.0.3     ✓ dplyr   1.0.1
## ✓ tidyr   1.1.1     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
```

```
## ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- readr::read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Parsed with column specification:
## cols(
##   name = col_character(),
##   Gender = col_character(),
##   `Eye color` = col_character(),
##   Race = col_character(),
##   `Hair color` = col_character(),
##   Height = col_double(),
##   Publisher = col_character(),
##   `Skin color` = col_character(),
##   Alignment = col_character(),
##   Weight = col_double()
## )
```

```r
superhero_powers <- readr::read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Parsed with column specification:
## cols(
##   .default = col_logical(),
##   hero_names = col_character()
## )
```

```
## See spec(...) for full column specifications.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here.  

```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```

```r
superhero_info_rename <- rename(superhero_info, gender="Gender", eye_color="Eye color", race="Race", hair_color="Hair color", height="Height", publisher="Publisher", skin_color="Skin color", alignment="Alignment", weight="Weight")
superhero_info_rename
```

```
## # A tibble: 734 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  5 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  6 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  7 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  8 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  9 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
## 10 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
## # … with 724 more rows, and 1 more variable: weight <dbl>
```

Yikes! `superhero_powers` has a lot of variables that are poorly named. We need some R superpowers...

```r
head(superhero_powers)
```

```
## # A tibble: 6 x 168
##   hero_names Agility `Accelerated He… `Lantern Power … `Dimensional Aw…
##   <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
## 1 3-D Man    TRUE    FALSE            FALSE            FALSE           
## 2 A-Bomb     FALSE   TRUE             FALSE            FALSE           
## 3 Abe Sapien TRUE    TRUE             FALSE            FALSE           
## 4 Abin Sur   FALSE   FALSE            TRUE             FALSE           
## 5 Abominati… FALSE   TRUE             FALSE            FALSE           
## 6 Abraxas    FALSE   FALSE            FALSE            TRUE            
## # … with 163 more variables: `Cold Resistance` <lgl>, Durability <lgl>,
## #   Stealth <lgl>, `Energy Absorption` <lgl>, Flight <lgl>, `Danger
## #   Sense` <lgl>, `Underwater breathing` <lgl>, Marksmanship <lgl>, `Weapons
## #   Master` <lgl>, `Power Augmentation` <lgl>, `Animal Attributes` <lgl>,
## #   Longevity <lgl>, Intelligence <lgl>, `Super Strength` <lgl>,
## #   Cryokinesis <lgl>, Telepathy <lgl>, `Energy Armor` <lgl>, `Energy
## #   Blasts` <lgl>, Duplication <lgl>, `Size Changing` <lgl>, `Density
## #   Control` <lgl>, Stamina <lgl>, `Astral Travel` <lgl>, `Audio
## #   Control` <lgl>, Dexterity <lgl>, Omnitrix <lgl>, `Super Speed` <lgl>,
## #   Possession <lgl>, `Animal Oriented Powers` <lgl>, `Weapon-based
## #   Powers` <lgl>, Electrokinesis <lgl>, `Darkforce Manipulation` <lgl>, `Death
## #   Touch` <lgl>, Teleportation <lgl>, `Enhanced Senses` <lgl>,
## #   Telekinesis <lgl>, `Energy Beams` <lgl>, Magic <lgl>, Hyperkinesis <lgl>,
## #   Jump <lgl>, Clairvoyance <lgl>, `Dimensional Travel` <lgl>, `Power
## #   Sense` <lgl>, Shapeshifting <lgl>, `Peak Human Condition` <lgl>,
## #   Immortality <lgl>, Camouflage <lgl>, `Element Control` <lgl>,
## #   Phasing <lgl>, `Astral Projection` <lgl>, `Electrical Transport` <lgl>,
## #   `Fire Control` <lgl>, Projection <lgl>, Summoning <lgl>, `Enhanced
## #   Memory` <lgl>, Reflexes <lgl>, Invulnerability <lgl>, `Energy
## #   Constructs` <lgl>, `Force Fields` <lgl>, `Self-Sustenance` <lgl>,
## #   `Anti-Gravity` <lgl>, Empathy <lgl>, `Power Nullifier` <lgl>, `Radiation
## #   Control` <lgl>, `Psionic Powers` <lgl>, Elasticity <lgl>, `Substance
## #   Secretion` <lgl>, `Elemental Transmogrification` <lgl>,
## #   `Technopath/Cyberpath` <lgl>, `Photographic Reflexes` <lgl>, `Seismic
## #   Power` <lgl>, Animation <lgl>, Precognition <lgl>, `Mind Control` <lgl>,
## #   `Fire Resistance` <lgl>, `Power Absorption` <lgl>, `Enhanced
## #   Hearing` <lgl>, `Nova Force` <lgl>, Insanity <lgl>, Hypnokinesis <lgl>,
## #   `Animal Control` <lgl>, `Natural Armor` <lgl>, Intangibility <lgl>,
## #   `Enhanced Sight` <lgl>, `Molecular Manipulation` <lgl>, `Heat
## #   Generation` <lgl>, Adaptation <lgl>, Gliding <lgl>, `Power Suit` <lgl>,
## #   `Mind Blast` <lgl>, `Probability Manipulation` <lgl>, `Gravity
## #   Control` <lgl>, Regeneration <lgl>, `Light Control` <lgl>,
## #   Echolocation <lgl>, Levitation <lgl>, `Toxin and Disease Control` <lgl>,
## #   Banish <lgl>, `Energy Manipulation` <lgl>, `Heat Resistance` <lgl>, …
```

## `janitor`
The [janitor](https://garthtarr.github.io/meatR/janitor.html) package is your friend. Make sure to install it and then load the library.  

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

The `clean_names` function takes care of everything in one line! Now that's a superpower!

```r
superhero_powers <- janitor::clean_names(superhero_powers)
superhero_powers
```

```
## # A tibble: 667 x 168
##    hero_names agility accelerated_hea… lantern_power_r… dimensional_awa…
##    <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
##  1 3-D Man    TRUE    FALSE            FALSE            FALSE           
##  2 A-Bomb     FALSE   TRUE             FALSE            FALSE           
##  3 Abe Sapien TRUE    TRUE             FALSE            FALSE           
##  4 Abin Sur   FALSE   FALSE            TRUE             FALSE           
##  5 Abominati… FALSE   TRUE             FALSE            FALSE           
##  6 Abraxas    FALSE   FALSE            FALSE            TRUE            
##  7 Absorbing… FALSE   FALSE            FALSE            FALSE           
##  8 Adam Monr… FALSE   TRUE             FALSE            FALSE           
##  9 Adam Stra… FALSE   FALSE            FALSE            FALSE           
## 10 Agent Bob  FALSE   FALSE            FALSE            FALSE           
## # … with 657 more rows, and 163 more variables: cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>,
## #   energy_blasts <lgl>, duplication <lgl>, size_changing <lgl>,
## #   density_control <lgl>, stamina <lgl>, astral_travel <lgl>,
## #   audio_control <lgl>, dexterity <lgl>, omnitrix <lgl>, super_speed <lgl>,
## #   possession <lgl>, animal_oriented_powers <lgl>, weapon_based_powers <lgl>,
## #   electrokinesis <lgl>, darkforce_manipulation <lgl>, death_touch <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, telekinesis <lgl>,
## #   energy_beams <lgl>, magic <lgl>, hyperkinesis <lgl>, jump <lgl>,
## #   clairvoyance <lgl>, dimensional_travel <lgl>, power_sense <lgl>,
## #   shapeshifting <lgl>, peak_human_condition <lgl>, immortality <lgl>,
## #   camouflage <lgl>, element_control <lgl>, phasing <lgl>,
## #   astral_projection <lgl>, electrical_transport <lgl>, fire_control <lgl>,
## #   projection <lgl>, summoning <lgl>, enhanced_memory <lgl>, reflexes <lgl>,
## #   invulnerability <lgl>, energy_constructs <lgl>, force_fields <lgl>,
## #   self_sustenance <lgl>, anti_gravity <lgl>, empathy <lgl>,
## #   power_nullifier <lgl>, radiation_control <lgl>, psionic_powers <lgl>,
## #   elasticity <lgl>, substance_secretion <lgl>,
## #   elemental_transmogrification <lgl>, technopath_cyberpath <lgl>,
## #   photographic_reflexes <lgl>, seismic_power <lgl>, animation <lgl>,
## #   precognition <lgl>, mind_control <lgl>, fire_resistance <lgl>,
## #   power_absorption <lgl>, enhanced_hearing <lgl>, nova_force <lgl>,
## #   insanity <lgl>, hypnokinesis <lgl>, animal_control <lgl>,
## #   natural_armor <lgl>, intangibility <lgl>, enhanced_sight <lgl>,
## #   molecular_manipulation <lgl>, heat_generation <lgl>, adaptation <lgl>,
## #   gliding <lgl>, power_suit <lgl>, mind_blast <lgl>,
## #   probability_manipulation <lgl>, gravity_control <lgl>, regeneration <lgl>,
## #   light_control <lgl>, echolocation <lgl>, levitation <lgl>,
## #   toxin_and_disease_control <lgl>, banish <lgl>, energy_manipulation <lgl>,
## #   heat_resistance <lgl>, …
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info_rename, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

2. Notice that we have some neutral superheros! Who are they?

```r
superhero_info_rename %>% 
  select(name, alignment) %>% 
  filter(alignment == "neutral")
```

```
## # A tibble: 24 x 2
##    name         alignment
##    <chr>        <chr>    
##  1 Bizarro      neutral  
##  2 Black Flash  neutral  
##  3 Captain Cold neutral  
##  4 Copycat      neutral  
##  5 Deadpool     neutral  
##  6 Deathstroke  neutral  
##  7 Etrigan      neutral  
##  8 Galactus     neutral  
##  9 Gladiator    neutral  
## 10 Indigo       neutral  
## # … with 14 more rows
```

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superhero_info_rename %>% 
  select(name, alignment, race)
```

```
## # A tibble: 734 x 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # … with 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
superhero_info_rename %>% 
  filter(race !="Human")
```

```
## # A tibble: 222 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  2 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  3 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  4 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  7 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  8 Angel Male   <NA>      Vamp… <NA>           NA Dark Hor… <NA>       good     
##  9 Ange… Female yellow    Muta… Black         165 Marvel C… <NA>       good     
## 10 Anti… Male   yellow    God … No Hair        61 DC Comics <NA>       bad      
## # … with 212 more rows, and 1 more variable: weight <dbl>
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good_guys <- superhero_info_rename %>% 
  filter(alignment !="bad")
good_guys
```

```
## # A tibble: 520 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  5 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  6 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
##  7 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
##  8 Agen… Male   <NA>      <NA>  <NA>          191 Marvel C… <NA>       good     
##  9 Alan… Male   blue      <NA>  Blond         180 DC Comics <NA>       good     
## 10 Alex… Male   <NA>      <NA>  <NA>           NA NBC - He… <NA>       good     
## # … with 510 more rows, and 1 more variable: weight <dbl>
```

```r
bad_guys <- superhero_info_rename %>% 
  filter(alignment !="good")
bad_guys
```

```
## # A tibble: 231 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  2 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  3 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  4 Air-… Male   blue      <NA>  White         188 Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alex… Male   <NA>      Human <NA>           NA Wildstorm <NA>       bad      
##  7 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  8 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  9 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
## 10 Ange… Female <NA>      <NA>  <NA>           NA Image Co… <NA>       bad      
## # … with 221 more rows, and 1 more variable: weight <dbl>
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
tabyl(good_guys, race)
```

```
##               race   n     percent valid_percent
##              Alien   4 0.007692308    0.01320132
##              Alpha   5 0.009615385    0.01650165
##             Amazon   2 0.003846154    0.00660066
##            Android   4 0.007692308    0.01320132
##             Animal   2 0.003846154    0.00660066
##          Asgardian   3 0.005769231    0.00990099
##          Atlantean   4 0.007692308    0.01320132
##            Bizarro   1 0.001923077    0.00330033
##         Bolovaxian   1 0.001923077    0.00330033
##              Clone   1 0.001923077    0.00330033
##      Cosmic Entity   3 0.005769231    0.00990099
##             Cyborg   3 0.005769231    0.00990099
##           Czarnian   1 0.001923077    0.00330033
##           Demi-God   2 0.003846154    0.00660066
##              Demon   4 0.007692308    0.01320132
##            Eternal   1 0.001923077    0.00330033
##     Flora Colossus   1 0.001923077    0.00330033
##        Frost Giant   1 0.001923077    0.00330033
##      God / Eternal   7 0.013461538    0.02310231
##             Gungan   1 0.001923077    0.00330033
##              Human 157 0.301923077    0.51815182
##    Human / Altered   2 0.003846154    0.00660066
##     Human / Cosmic   2 0.003846154    0.00660066
##  Human / Radiation   9 0.017307692    0.02970297
##         Human-Kree   2 0.003846154    0.00660066
##      Human-Spartoi   1 0.001923077    0.00330033
##       Human-Vulcan   1 0.001923077    0.00330033
##    Human-Vuldarian   1 0.001923077    0.00330033
##      Icthyo Sapien   1 0.001923077    0.00330033
##            Inhuman   4 0.007692308    0.01320132
##    Kakarantharaian   1 0.001923077    0.00330033
##          Korugaran   1 0.001923077    0.00330033
##         Kryptonian   4 0.007692308    0.01320132
##            Martian   1 0.001923077    0.00330033
##          Metahuman   1 0.001923077    0.00330033
##             Mutant  50 0.096153846    0.16501650
##     Mutant / Clone   1 0.001923077    0.00330033
##             Planet   1 0.001923077    0.00330033
##             Saiyan   1 0.001923077    0.00330033
##          Strontian   1 0.001923077    0.00330033
##           Symbiote   3 0.005769231    0.00990099
##           Talokite   1 0.001923077    0.00330033
##         Tamaranean   1 0.001923077    0.00330033
##            Ungaran   1 0.001923077    0.00330033
##            Vampire   2 0.003846154    0.00660066
##     Yoda's species   1 0.001923077    0.00330033
##      Zen-Whoberian   1 0.001923077    0.00330033
##               <NA> 217 0.417307692            NA
```

7. Among the good guys, Who are the Asgardians?

```r
good_guys %>%
  select(name, race) %>% 
  filter(race == "Asgardian")
```

```
## # A tibble: 3 x 2
##   name      race     
##   <chr>     <chr>    
## 1 Sif       Asgardian
## 2 Thor      Asgardian
## 3 Thor Girl Asgardian
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad_guys %>%
  filter(gender == "Male") %>% 
  filter(height > "200")
```

```
## # A tibble: 29 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair     203   Marvel C… <NA>       bad      
##  2 Alien Male   <NA>      Xeno… No Hair     244   Dark Hor… black      bad      
##  3 Amazo Male   red       Andr… <NA>        257   DC Comics <NA>       bad      
##  4 Anti… Male   yellow    God … No Hair      61   DC Comics <NA>       bad      
##  5 Apoc… Male   red       Muta… Black       213   Marvel C… grey       bad      
##  6 Bane  Male   <NA>      Human <NA>        203   DC Comics <NA>       bad      
##  7 Bloo… Male   white     <NA>  No Hair      30.5 Marvel C… <NA>       bad      
##  8 Dark… Male   red       New … No Hair     267   DC Comics grey       bad      
##  9 Doct… Male   brown     Human Brown       201   Marvel C… <NA>       bad      
## 10 Doct… Male   brown     <NA>  Brown       201   Marvel C… <NA>       bad      
## # … with 19 more rows, and 1 more variable: weight <dbl>
```

9. OK, so are there more good guys or bad guys that are bald (personal interest)?

```r
good_guys %>%
  filter(hair_color == "No Hair")
```

```
## # A tibble: 40 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Beta… Male   <NA>      <NA>  No Hair       201 Marvel C… <NA>       good     
##  5 Bish… Male   brown     Muta… No Hair       198 Marvel C… <NA>       good     
##  6 Blac… Male   brown     <NA>  No Hair       185 DC Comics <NA>       good     
##  7 Blaq… <NA>   black     <NA>  No Hair        NA Marvel C… <NA>       good     
##  8 Bloo… Male   black     Muta… No Hair        NA Marvel C… <NA>       good     
##  9 Crim… Male   brown     <NA>  No Hair       180 Marvel C… <NA>       good     
## 10 Dead… Male   brown     Muta… No Hair       188 Marvel C… <NA>       neutral  
## # … with 30 more rows, and 1 more variable: weight <dbl>
```

```r
bad_guys %>% 
  filter(hair_color == "No Hair")
```

```
## # A tibble: 38 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair     203   Marvel C… <NA>       bad      
##  2 Abso… Male   blue      Human No Hair     193   Marvel C… <NA>       bad      
##  3 Alien Male   <NA>      Xeno… No Hair     244   Dark Hor… black      bad      
##  4 Anni… Male   green     <NA>  No Hair     180   Marvel C… <NA>       bad      
##  5 Anti… Male   yellow    God … No Hair      61   DC Comics <NA>       bad      
##  6 Blac… Male   black     Human No Hair     188   DC Comics <NA>       bad      
##  7 Bloo… Male   white     <NA>  No Hair      30.5 Marvel C… <NA>       bad      
##  8 Brai… Male   green     Andr… No Hair     198   DC Comics green      bad      
##  9 Dark… Male   red       New … No Hair     267   DC Comics grey       bad      
## 10 Dart… Male   yellow    Cybo… No Hair     198   George L… <NA>       bad      
## # … with 28 more rows, and 1 more variable: weight <dbl>
```

There are more good guys than bad guys that have no hair.

Tried to make a tableset without the hashtags, but this command wasn't working:

```r
#good_guys %>%
#  filter(hair_color == "No Hair") %>% 
#  table(good_guys$hair_color)
```


10. Let's explore who the really "big" superheros are. In the `superhero_info` data, which have a height over 200 or weight over 300?

```r
superhero_info_rename %>%
  select(name, height, weight) %>% 
  filter(height > "200" | weight > "300")
```

```
## # A tibble: 405 x 3
##    name              height weight
##    <chr>              <dbl>  <dbl>
##  1 A-Bomb               203    441
##  2 Abe Sapien           191     65
##  3 Abin Sur             185     90
##  4 Abomination          203    441
##  5 Adam Strange         185     88
##  6 Agent 13             173     61
##  7 Agent Bob            178     81
##  8 Ajax                 193     90
##  9 Alan Scott           180     90
## 10 Alfred Pennyworth    178     72
## # … with 395 more rows
```

11. Just to be clear on the `|` operator,  have a look at the superheros over 300 in height...

```r
superhero_info_rename %>% 
  select(name, height) %>% 
  filter(height > "300")
```

```
## # A tibble: 14 x 2
##    name            height
##    <chr>            <dbl>
##  1 Anti-Monitor      61  
##  2 Fin Fang Foom    975  
##  3 Galactus         876  
##  4 Giganta           62.5
##  5 Groot            701  
##  6 Howard the Duck   79  
##  7 Jack-Jack         71  
##  8 Krypto            64  
##  9 MODOK            366  
## 10 Onslaught        305  
## 11 Sasquatch        305  
## 12 Wolfsbane        366  
## 13 Ymir             305. 
## 14 Yoda              66
```

12. ...and the superheros over 450 in weight. Bonus question! Why do we not have 16 rows in question #10?

```r
superhero_info_rename %>% 
  select(name, weight) %>% 
  filter(weight >"450")
```

```
## # A tibble: 339 x 2
##    name              weight
##    <chr>              <dbl>
##  1 Abe Sapien            65
##  2 Abin Sur              90
##  3 Adam Strange          88
##  4 Agent 13              61
##  5 Agent Bob             81
##  6 Ajax                  90
##  7 Alan Scott            90
##  8 Alfred Pennyworth     72
##  9 Angel                 68
## 10 Angel Dust            57
## # … with 329 more rows
```

We do not have 16 rows in question #10 because it includes two factors that are being filtered: height or weight. The filters for questions 12 and 13 only filter one factor, therefore don't take any other "or" factors into consideration for filtering.

## Height to Weight Ratio
13. It's easy to be strong when you are heavy and tall, but who is heavy and short? Which superheros have the highest height to weight ratio?

```r
superhero_info_rename %>%
  mutate(superhero_info_rename_ratio=height/weight) %>% 
  select(name, weight, height, superhero_info_rename_ratio) %>%
  arrange(desc(superhero_info_rename_ratio))
```

```
## # A tibble: 734 x 4
##    name            weight height superhero_info_rename_ratio
##    <chr>            <dbl>  <dbl>                       <dbl>
##  1 Groot                4    701                      175.  
##  2 Galactus            16    876                       54.8 
##  3 Fin Fang Foom       18    975                       54.2 
##  4 Longshot            36    188                        5.22
##  5 Jack-Jack           14     71                        5.07
##  6 Rocket Raccoon      25    122                        4.88
##  7 Dash                27    122                        4.52
##  8 Howard the Duck     18     79                        4.39
##  9 Swarm               47    196                        4.17
## 10 Yoda                17     66                        3.88
## # … with 724 more rows
```

```r
#Mutate adds a column. You name the column first, then = what it's calculcating.
```

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

```r
data_frame(superhero_powers)
```

```
## Warning: `data_frame()` is deprecated as of tibble 1.1.0.
## Please use `tibble()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## # A tibble: 667 x 168
##    hero_names agility accelerated_hea… lantern_power_r… dimensional_awa…
##    <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
##  1 3-D Man    TRUE    FALSE            FALSE            FALSE           
##  2 A-Bomb     FALSE   TRUE             FALSE            FALSE           
##  3 Abe Sapien TRUE    TRUE             FALSE            FALSE           
##  4 Abin Sur   FALSE   FALSE            TRUE             FALSE           
##  5 Abominati… FALSE   TRUE             FALSE            FALSE           
##  6 Abraxas    FALSE   FALSE            FALSE            TRUE            
##  7 Absorbing… FALSE   FALSE            FALSE            FALSE           
##  8 Adam Monr… FALSE   TRUE             FALSE            FALSE           
##  9 Adam Stra… FALSE   FALSE            FALSE            FALSE           
## 10 Agent Bob  FALSE   FALSE            FALSE            FALSE           
## # … with 657 more rows, and 163 more variables: cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>,
## #   energy_blasts <lgl>, duplication <lgl>, size_changing <lgl>,
## #   density_control <lgl>, stamina <lgl>, astral_travel <lgl>,
## #   audio_control <lgl>, dexterity <lgl>, omnitrix <lgl>, super_speed <lgl>,
## #   possession <lgl>, animal_oriented_powers <lgl>, weapon_based_powers <lgl>,
## #   electrokinesis <lgl>, darkforce_manipulation <lgl>, death_touch <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, telekinesis <lgl>,
## #   energy_beams <lgl>, magic <lgl>, hyperkinesis <lgl>, jump <lgl>,
## #   clairvoyance <lgl>, dimensional_travel <lgl>, power_sense <lgl>,
## #   shapeshifting <lgl>, peak_human_condition <lgl>, immortality <lgl>,
## #   camouflage <lgl>, element_control <lgl>, phasing <lgl>,
## #   astral_projection <lgl>, electrical_transport <lgl>, fire_control <lgl>,
## #   projection <lgl>, summoning <lgl>, enhanced_memory <lgl>, reflexes <lgl>,
## #   invulnerability <lgl>, energy_constructs <lgl>, force_fields <lgl>,
## #   self_sustenance <lgl>, anti_gravity <lgl>, empathy <lgl>,
## #   power_nullifier <lgl>, radiation_control <lgl>, psionic_powers <lgl>,
## #   elasticity <lgl>, substance_secretion <lgl>,
## #   elemental_transmogrification <lgl>, technopath_cyberpath <lgl>,
## #   photographic_reflexes <lgl>, seismic_power <lgl>, animation <lgl>,
## #   precognition <lgl>, mind_control <lgl>, fire_resistance <lgl>,
## #   power_absorption <lgl>, enhanced_hearing <lgl>, nova_force <lgl>,
## #   insanity <lgl>, hypnokinesis <lgl>, animal_control <lgl>,
## #   natural_armor <lgl>, intangibility <lgl>, enhanced_sight <lgl>,
## #   molecular_manipulation <lgl>, heat_generation <lgl>, adaptation <lgl>,
## #   gliding <lgl>, power_suit <lgl>, mind_blast <lgl>,
## #   probability_manipulation <lgl>, gravity_control <lgl>, regeneration <lgl>,
## #   light_control <lgl>, echolocation <lgl>, levitation <lgl>,
## #   toxin_and_disease_control <lgl>, banish <lgl>, energy_manipulation <lgl>,
## #   heat_resistance <lgl>, …
```

14. How many superheros have a combination of accelerated healing, durability, and super strength?

```r
superhero_powers %>%
  select(hero_names, accelerated_healing, durability, super_strength) %>%
  filter(accelerated_healing == "TRUE" & durability == "TRUE" & super_strength == "TRUE")
```

```
## # A tibble: 97 x 4
##    hero_names   accelerated_healing durability super_strength
##    <chr>        <lgl>               <lgl>      <lgl>         
##  1 A-Bomb       TRUE                TRUE       TRUE          
##  2 Abe Sapien   TRUE                TRUE       TRUE          
##  3 Angel        TRUE                TRUE       TRUE          
##  4 Anti-Monitor TRUE                TRUE       TRUE          
##  5 Anti-Venom   TRUE                TRUE       TRUE          
##  6 Aquaman      TRUE                TRUE       TRUE          
##  7 Arachne      TRUE                TRUE       TRUE          
##  8 Archangel    TRUE                TRUE       TRUE          
##  9 Ardina       TRUE                TRUE       TRUE          
## 10 Ares         TRUE                TRUE       TRUE          
## # … with 87 more rows
```

Not sure why it's coming up with no rows :/

## `kinesis`
15. We are only interested in the superheros that do some kind of "kinesis". How would we isolate them from the `superhero_powers` data?

```r
#kinesis <- superhero_powers %>%
#  select(hero_names, ends_with("kinesis")) %>%
#  filter(kinesis == "TRUE")
#names(kinesis)
#Not sure why this result isn't giving a table form that includes the hero names
#Also tried knitting this and the code would stop at Line 194, so I "hashtagged" this and used the code below instead
```


```r
kinesis <- superhero_powers %>%
  select(hero_names, ends_with("kinesis")) %>%
  filter_all(any_vars(.=="TRUE"))
kinesis
```

```
## # A tibble: 112 x 10
##    hero_names cryokinesis electrokinesis telekinesis hyperkinesis hypnokinesis
##    <chr>      <lgl>       <lgl>          <lgl>       <lgl>        <lgl>       
##  1 Alan Scott FALSE       FALSE          FALSE       FALSE        TRUE        
##  2 Amazo      TRUE        FALSE          FALSE       FALSE        FALSE       
##  3 Apocalypse FALSE       FALSE          TRUE        FALSE        FALSE       
##  4 Aqualad    TRUE        FALSE          FALSE       FALSE        FALSE       
##  5 Beyonder   FALSE       FALSE          TRUE        FALSE        FALSE       
##  6 Bizarro    TRUE        FALSE          FALSE       FALSE        TRUE        
##  7 Black Abb… FALSE       FALSE          TRUE        FALSE        FALSE       
##  8 Black Adam FALSE       FALSE          TRUE        FALSE        FALSE       
##  9 Black Lig… FALSE       TRUE           FALSE       FALSE        FALSE       
## 10 Black Mam… FALSE       FALSE          FALSE       FALSE        TRUE        
## # … with 102 more rows, and 4 more variables: thirstokinesis <lgl>,
## #   biokinesis <lgl>, terrakinesis <lgl>, vitakinesis <lgl>
```

```r
#Make sure to use filter_all for this, not just filter
```


Tried this code without the hashtags, but not working:

```r
#kinesis <- superhero_powers %>%
#  select(hero_names, ends_with(kinesis)) %>% 
#  filter(kinesis == "TRUE")
```


16. Pick your favorite superhero and let's see their powers!

```r
superhero_powers %>%
  filter(hero_names == "Darth Vader") %>%
  select_if(all_vars(.=="TRUE"))
```

```
## Warning: The `.predicate` argument of `select_if()` can't contain quosures. as of dplyr 0.8.3.
## Please use a one-sided formula, a function, or a function name.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## # A tibble: 1 x 26
##   agility accelerated_hea… durability stealth danger_sense marksmanship
##   <lgl>   <lgl>            <lgl>      <lgl>   <lgl>        <lgl>       
## 1 TRUE    TRUE             TRUE       TRUE    TRUE         TRUE        
## # … with 20 more variables: weapons_master <lgl>, intelligence <lgl>,
## #   telepathy <lgl>, energy_blasts <lgl>, super_speed <lgl>,
## #   electrokinesis <lgl>, enhanced_senses <lgl>, telekinesis <lgl>, jump <lgl>,
## #   astral_projection <lgl>, reflexes <lgl>, force_fields <lgl>,
## #   psionic_powers <lgl>, precognition <lgl>, enhanced_hearing <lgl>,
## #   hypnokinesis <lgl>, light_control <lgl>, illusions <lgl>, cloaking <lgl>,
## #   the_force <lgl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
