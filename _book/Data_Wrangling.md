# Data wrangling




In this chapter, we begin to delve into the manipulation of data in the form of a 
data frame or tibble. In so doing, we will introduce the `tidyverse` package 
and the various verbs (function) it provides.

The `tidyverse` package is not just a single package but a composite of a group 
of packages. These include among others the `dplyr` package. Most of the function 
we will be employing in this chapter comes from `dplyr`.


We begin by reading in the `blood_donors.xls`

```r
df_blood <- readxl::read_xls("./Data/blood_donors_1.xls")
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

The output shows we have a 25-row and 6-column tibble. 

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
In this subsection, we demonstrate the use of the `filter` and `select` function 
to select specific records and variables in a tibble. Below we filter to select 
all records with `hb` > 12g/dl and keep only the `id`, `hb` and `sex`
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
To generate new variables we use the `mutate` function. Based on our knowledge 
that the hematocrit is approximately three times the haemoglobin we generate 
a new variable, `hb_from_hct`. 

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
Data can be aggregated in R using the `summarize` function. Below we determine 
the mean and standard deviation of the haemoglobin for the patient in the data.

```r
df_blood %>% 
    summarize(mean_hb = mean(hb), sd_hb = sd(hb))
# A tibble: 1 × 2
  mean_hb sd_hb
    <dbl> <dbl>
1    11.0  2.89
```

Grouping the data by the "bldgrp" before the aggregation yields the aggregated 
means and standard deviations for the various blood groups.

```r
df_blood %>% 
    group_by(bldgrp) %>% 
    summarize(mean_hb = mean(hb), sd_hb = sd(hb))
# A tibble: 5 × 3
  bldgrp mean_hb  sd_hb
  <chr>    <dbl>  <dbl>
1 A         7.32  3.61 
2 AB       13.1   1.69 
3 B        10.2   0.283
4 O        11.0   0.427
5 P        16.4  NA    
```

## Reshaping data
In longitudinal studies, data is captured from the same individual repeatedly. 
Such data is recorded either in long or wide formats. A typical example of a 
data frame in the long form is bpB below. 


```r
bp_long <- read_csv(
    file = "./Data/bp_long.txt",
    col_names = TRUE, 
    col_types = c("c", "c", "i")
    )

bp_long
# A tibble: 5 × 3
  id    measure   sbp
  <chr> <chr>   <dbl>
1 B01   sbp1      141
2 B01   sbp2      137
3 B02   sbp1      155
4 B02   sbp2      153
5 B03   sbp1      153
```
In this format, each visit or round of data taking is captured as a new row, but 
with the appropriate study ID and period of record, captured as the variable 
measure above. Measurement of systolic blood pressure on day 1 is indicated by 
sbp1 in the measure variable. Day 2 measurements are indicated as sbp2.

The wide format of the same data can be obtained as below.


```r
bp_wide <- 
    bp_long %>% 
    pivot_wider(
        id_cols = id, 
        names_from = measure, 
        values_from = sbp
    )

bp_wide
# A tibble: 3 × 3
  id     sbp1  sbp2
  <chr> <dbl> <dbl>
1 B01     141   137
2 B02     155   153
3 B03     153    NA
```

Here, each study participant's record for the whole study is on one row of the data and the different measurements of systolic blood pressure are captured as different variables. Next, we convert the wide back to the long format.


```r
bp_wide %>% 
    pivot_longer(
        cols = c(sbp1, sbp2),
        names_to = "time",
        values_to = "syst_bp"
    )
# A tibble: 6 × 3
  id    time  syst_bp
  <chr> <chr>   <dbl>
1 B01   sbp1      141
2 B01   sbp2      137
3 B02   sbp1      155
4 B02   sbp2      153
5 B03   sbp1      153
6 B03   sbp2       NA
```


## Combining data

In a study to determine the change in weight of athletes running a marathon, 
data about the athletes were obtained by the investigators. Since the marathon 
starts in town A and ends in town B, the investigators decided to weigh the 
athletes just before starting the race. Here they took records of the ID of the 
athlete's sid, sex, age and weight at the start (wgtst). The records of five of 
these athletes are in the data marathonA. At the end point of the marathon, 
another member of the investigation team recorded their IDs (eid), weight upon 
completion (wgtend) and the time it took the athletes to complete the marathon 
(dura).


```r
dataA <- 
    read_delim(
        file = "./Data/marathonA.txt",
        col_names = TRUE,
        delim = "\t",
        col_types = c("c","c","i","d")
    )

dataB <- 
    read_delim(
        file = "./Data/marathonB.txt",
        col_names = TRUE,
        delim = "\t",
        col_types = c("c","c","i","d")
    )

dataA
# A tibble: 5 × 4
  sid   sex     age wgtst
  <chr> <chr> <dbl> <dbl>
1 C001  M        23  57.1
2 C002  F        27  62.3
3 C003  M        19  54.5
4 C004  M        21  59.4
5 C005  F        32  53.4

dataB
# A tibble: 4 × 3
  eid   wgtend  dura
  <chr>  <dbl> <dbl>
1 C003    53.9   189
2 C005    53     197
3 C002    62.2   201
4 C001    56.8   209
```

We can determine the weight change only by matching the before and after 
weight of each individual. This is where merging is very useful. Below, we 
merge the two data into one. This is done below.


```r
dataA %>% 
    full_join(dataB, by = join_by(sid==eid))
# A tibble: 5 × 6
  sid   sex     age wgtst wgtend  dura
  <chr> <chr> <dbl> <dbl>  <dbl> <dbl>
1 C001  M        23  57.1   56.8   209
2 C002  F        27  62.3   62.2   201
3 C003  M        19  54.5   53.9   189
4 C004  M        21  59.4   NA      NA
5 C005  F        32  53.4   53     197
```

