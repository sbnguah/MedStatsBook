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
        file = "data1.txt", 
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
<div class="tabwid"><style>.cl-3eac2f56{}.cl-3ea11b7a{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-3ea66eb8{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-3ea6840c{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ea68416{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-3eac2f56'><thead><tr style="overflow-wrap:break-word;"><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">n</span></p></th><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">mean</span></p></th><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">sd</span></p></th><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">se</span></p></th><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">lower95ci</span></p></th><th class="cl-3ea6840c"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">upper95ci</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">139</span></p></td><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">90.85612</span></p></td><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">21.34179</span></p></td><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">1.810187</span></p></td><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">87.27683</span></p></td><td class="cl-3ea68416"><p class="cl-3ea66eb8"><span class="cl-3ea11b7a">94.4354</span></p></td></tr></tbody></table></div>
```


```r
df_data1 %>% 
    meantables::mean_table(height) %>% 
    flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-3ec7cf22{}.cl-3ebed264{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-3ec2664a{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-3ec26654{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-3ec27964{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ec27965{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ec2796e{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ec2796f{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-3ec7cf22'><thead><tr style="overflow-wrap:break-word;"><th class="cl-3ec27964"><p class="cl-3ec2664a"><span class="cl-3ebed264">response_var</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">n</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">mean</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">sd</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">sem</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">lcl</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">ucl</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">min</span></p></th><th class="cl-3ec27965"><p class="cl-3ec26654"><span class="cl-3ebed264">max</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-3ec2796e"><p class="cl-3ec2664a"><span class="cl-3ebed264">height</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">139</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">90.86</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">21.34</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">1.810187</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">87.28</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">94.44</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">49</span></p></td><td class="cl-3ec2796f"><p class="cl-3ec26654"><span class="cl-3ebed264">137</span></p></td></tr></tbody></table></div>
```

For sex stratified confidence intervals we have


```r
df_data1 %>% 
    group_by(sex) %>% 
    meantables::mean_table(height)%>% 
    flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-3ee5d274{}.cl-3edc995c{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-3ee04e76{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-3ee04e8a{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-3ee06ad2{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ee06adc{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ee06add{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ee06ae6{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ee06af0{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-3ee06af1{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-3ee5d274'><thead><tr style="overflow-wrap:break-word;"><th class="cl-3ee06ad2"><p class="cl-3ee04e76"><span class="cl-3edc995c">response_var</span></p></th><th class="cl-3ee06ad2"><p class="cl-3ee04e76"><span class="cl-3edc995c">group_var</span></p></th><th class="cl-3ee06ad2"><p class="cl-3ee04e76"><span class="cl-3edc995c">group_cat</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">n</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">mean</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">sd</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">sem</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">lcl</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">ucl</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">min</span></p></th><th class="cl-3ee06adc"><p class="cl-3ee04e8a"><span class="cl-3edc995c">max</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-3ee06add"><p class="cl-3ee04e76"><span class="cl-3edc995c">height</span></p></td><td class="cl-3ee06add"><p class="cl-3ee04e76"><span class="cl-3edc995c">sex</span></p></td><td class="cl-3ee06add"><p class="cl-3ee04e76"><span class="cl-3edc995c">Female</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">63</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">92.16</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">22.98</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">2.894829</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">86.37</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">97.95</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">49</span></p></td><td class="cl-3ee06ae6"><p class="cl-3ee04e8a"><span class="cl-3edc995c">137</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-3ee06af0"><p class="cl-3ee04e76"><span class="cl-3edc995c">height</span></p></td><td class="cl-3ee06af0"><p class="cl-3ee04e76"><span class="cl-3edc995c">sex</span></p></td><td class="cl-3ee06af0"><p class="cl-3ee04e76"><span class="cl-3edc995c">Male</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">76</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">89.78</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">19.98</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">2.291372</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">85.21</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">94.34</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">55</span></p></td><td class="cl-3ee06af1"><p class="cl-3ee04e8a"><span class="cl-3edc995c">131</span></p></td></tr></tbody></table></div>
```


To test the H0: The mean height is 100cm whiles generating the confidence 
interval as well we use
