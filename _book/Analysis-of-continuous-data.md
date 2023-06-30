# Analysis of numeric data



So far, we have dealt with descriptive statistics and the analysis of the sample 
data collected. However, the bane of most statistical analysis is to make 
inferences about the population as a whole. In this section, we mainly do an 
inferential analysis of continuous variables.

## Confidence interval of a mean
To determine the confidence interval of the mean of a numeric variable in R, we 
use the One Sample Student's T-test. The assumptions for the validity of this 
test are:

1. The sample should have been randomly chosen
1. The population distribution of the variable should be normal. This can be 
assumed to be present if
    - The distribution of the population is known to be normally distributed
    - The population distribution should have one mode, symmetric, without 
    outliers and a sample size of 15 or less
    - The population distribution should be moderately skewed, without outliers, 
    and have one mode and with a sample size between 16 and 40
    - The sample size is more than 40 and the data has no outliers.

With our sample considered to be randomly selected and a sample size of 140, we 
apply the One-sample T-test as below. 

We first import the data 

```r
df_data1 <- 
    read_delim(
        file = "./Data/data1.txt", 
        delim = "\t",
        col_types = c("c", "f", "i","i")
    )

glimpse(df_data1)
Rows: 140
Columns: 4
$ id     <chr> "125", "62", "112", "29", "27", "131", "83"…
$ sex    <chr> "Male", "Female", "Female", "Female", "Male…
$ weight <dbl> 7, 11, 13, 20, 12, 9, 9, 4, 14, 13, 14, 22,…
$ height <dbl> 64, 96, 115, 106, 94, 78, 77, 59, 96, 92, 9…
```




```r
df_data1 %$% 
    epiDisplay::ci(height)%>% 
    flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-df19045a{}.cl-df0d7446{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-df132e0e{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-df1343c6{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df1343d0{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-df19045a'><thead><tr style="overflow-wrap:break-word;"><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">n</span></p></th><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">mean</span></p></th><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">sd</span></p></th><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">se</span></p></th><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">lower95ci</span></p></th><th class="cl-df1343c6"><p class="cl-df132e0e"><span class="cl-df0d7446">upper95ci</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">139</span></p></td><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">90.85612</span></p></td><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">21.34179</span></p></td><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">1.810187</span></p></td><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">87.27683</span></p></td><td class="cl-df1343d0"><p class="cl-df132e0e"><span class="cl-df0d7446">94.4354</span></p></td></tr></tbody></table></div>
```


```r
df_data1 %>% 
    meantables::mean_table(height) %>% 
    flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-df356cf8{}.cl-df2c6c66{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-df2fd86a{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-df2fd874{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-df2fef76{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df2fef80{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df2fef8a{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df2fef8b{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-df356cf8'><thead><tr style="overflow-wrap:break-word;"><th class="cl-df2fef76"><p class="cl-df2fd86a"><span class="cl-df2c6c66">response_var</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">n</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">mean</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">sd</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">sem</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">lcl</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">ucl</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">min</span></p></th><th class="cl-df2fef80"><p class="cl-df2fd874"><span class="cl-df2c6c66">max</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-df2fef8a"><p class="cl-df2fd86a"><span class="cl-df2c6c66">height</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">139</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">90.86</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">21.34</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">1.810187</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">87.28</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">94.44</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">49</span></p></td><td class="cl-df2fef8b"><p class="cl-df2fd874"><span class="cl-df2c6c66">137</span></p></td></tr></tbody></table></div>
```

For sex stratified confidence intervals we have


```r
df_data1 %>% 
    group_by(sex) %>% 
    meantables::mean_table(height)%>% 
    flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-df546fcc{}.cl-df4ae9ca{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-df4ea7d6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-df4ea7ea{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-df4ebeb0{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df4ebeb1{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df4ebeba{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df4ebec4{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df4ebec5{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-df4ebece{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-df546fcc'><thead><tr style="overflow-wrap:break-word;"><th class="cl-df4ebeb0"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">response_var</span></p></th><th class="cl-df4ebeb0"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">group_var</span></p></th><th class="cl-df4ebeb0"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">group_cat</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">n</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">mean</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">sd</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">sem</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">lcl</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">ucl</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">min</span></p></th><th class="cl-df4ebeb1"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">max</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-df4ebeba"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">height</span></p></td><td class="cl-df4ebeba"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">sex</span></p></td><td class="cl-df4ebeba"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">Female</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">63</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">92.16</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">22.98</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">2.894829</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">86.37</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">97.95</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">49</span></p></td><td class="cl-df4ebec4"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">137</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-df4ebec5"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">height</span></p></td><td class="cl-df4ebec5"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">sex</span></p></td><td class="cl-df4ebec5"><p class="cl-df4ea7d6"><span class="cl-df4ae9ca">Male</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">76</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">89.78</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">19.98</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">2.291372</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">85.21</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">94.34</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">55</span></p></td><td class="cl-df4ebece"><p class="cl-df4ea7ea"><span class="cl-df4ae9ca">131</span></p></td></tr></tbody></table></div>
```


To test the H0: The mean height is 100cm whiles generating the confidence 
interval as well we use
