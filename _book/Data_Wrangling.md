# Data wrangling




In this chapter we begin to delve into manipulation of data in the form of a 
data frame or tibble. In so doing, we will introduce the `tidyverse` package 
and the various verbs (function) it provides.

The `tidyverse` package is not just a single package but a composit of a group 
of packages. There include among others the `dplyr` package. Most of the function 
we will be employing in this chapter comes from `dplyr`.


We begin by reading in the `blood_donors.xls`

```r
df_blood <- readxl::read_xls("blood_donors_1.xls")
df_blood
# A tibble: 25 × 6
      id    hb   hct sex   bldgrp pdonor
   <dbl> <dbl> <dbl> <chr> <chr>   <dbl>
 1     1 10.5   31.8 Male  O           3
 2     2 11.9   37.2 Male  AB          0
 3     3  1     26   Male  A           1
 4     4  8.90  26.8 Male  A           3
 5     5  7.80  24.2 Male  A           2
 6     6 10     30.9 Male  B           1
 7     7 10.4   33.9 Male  B           0
 8     8 11.3   35   Male  O           1
 9     9 16.4   NA   Male  AB          1
10    10 14.4   43.6 Male  AB          1
# ℹ 15 more rows
```

The output shows we have a 25 row and 6 column tibble. 

## Renaming variables
Below we rename the variables `hb` to `hemog` and `id` to `studyid` using he 
`rename` function, and then show the first 5 records with the `head` function.


```r
df_blood %>% 
    rename(hemog = hb, studyid = id) %>% 
    head(5)
# A tibble: 5 × 6
  studyid hemog   hct sex   bldgrp pdonor
    <dbl> <dbl> <dbl> <chr> <chr>   <dbl>
1       1 10.5   31.8 Male  O           3
2       2 11.9   37.2 Male  AB          0
3       3  1     26   Male  A           1
4       4  8.90  26.8 Male  A           3
5       5  7.80  24.2 Male  A           2
```
## Sorting data
Below we use the `arrange` function to sort the `bldgrp` in ascending order and 
`hb` by descending order.


```r
df_blood %>% 
    arrange(bldgrp, desc(hb))
# A tibble: 25 × 6
      id    hb   hct sex    bldgrp pdonor
   <dbl> <dbl> <dbl> <chr>  <chr>   <dbl>
 1    17  9.80  30.5 Female A           4
 2    21  9.10  28.0 <NA>   A           3
 3     4  8.90  26.8 Male   A           3
 4     5  7.80  24.2 Male   A           2
 5     3  1     26   Male   A           1
 6     9 16.4   NA   Male   AB          1
 7    10 14.4   43.6 Male   AB          1
 8    16 12.7   99   Female AB          0
 9    24 12.3   38.2 <NA>   AB          2
10    14 12.2   36.8 Female AB          1
# ℹ 15 more rows
```

## Subsetting data
In this subsection we demonstrate the use of the `filter` and `select` function 
to select specific records and variables in a tibble. Below we filter to select 
all records with `hb` > 12g/dl and the keep only the `id`, `hb` and `sex`
columns.

```r
df_blood %>% 
    filter(hb > 12) %>% 
    select(id, hb, sex)
# A tibble: 6 × 3
     id    hb sex   
  <dbl> <dbl> <chr> 
1     9  16.4 Male  
2    10  14.4 Male  
3    14  12.2 Female
4    14  16.4 Female
5    16  12.7 Female
6    24  12.3 <NA>  
```

## Generating new variables
To enerate new variables we use the `mutate` function. Based on our knowledge 
that the hemotocrit is approximately three times the hemoglobn we generate a 
new variable, `hb_from_hct`. 

```r
df_blood %>% 
    mutate(hb_from_hct = hct/3)
# A tibble: 25 × 7
      id    hb   hct sex   bldgrp pdonor hb_from_hct
   <dbl> <dbl> <dbl> <chr> <chr>   <dbl>       <dbl>
 1     1 10.5   31.8 Male  O           3       10.6 
 2     2 11.9   37.2 Male  AB          0       12.4 
 3     3  1     26   Male  A           1        8.67
 4     4  8.90  26.8 Male  A           3        8.93
 5     5  7.80  24.2 Male  A           2        8.07
 6     6 10     30.9 Male  B           1       10.3 
 7     7 10.4   33.9 Male  B           0       11.3 
 8     8 11.3   35   Male  O           1       11.7 
 9     9 16.4   NA   Male  AB          1       NA   
10    10 14.4   43.6 Male  AB          1       14.5 
# ℹ 15 more rows
```


## Aggregating data

## Reshaping data

## Combiing data
