# Ordinal logistic regression



## Importing data

In this presentation, we analyse a dataset using ordinal logistic regression. 
We begin by reading the data and selecting our desired subset.


```r
dataF <- 
    dget("./Data/anemia_data") %>% 
    select(sid, anemia_cat, community, fever, sex,
           famsize, moccup2, foccup2, hosp_visit)
```

We then view a summary of the data


```r
dataF %>% glimpse()
Rows: 476
Columns: 9
$ sid        <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, …
$ anemia_cat <fct> Mild, Moderate, Normal, Severe, Mild, M…
$ community  <fct> Kasei, Kasei, Kasei, Kasei, Kasei, Kase…
$ fever      <fct> Yes, Yes, Yes, Yes, Yes, No, No, Yes, Y…
$ sex        <fct> Female, Female, Female, Male, Male, Fem…
$ famsize    <dbl> 4, 4, 2, 3, 5, 4, 9, 4, 4, 10, 3, 4, 3,…
$ moccup2    <fct> Farmer, Farmer, Other, Other, Farmer, F…
$ foccup2    <fct> Farmer, Farmer, Other, Farmer, Farmer, …
$ hosp_visit <fct> No, No, No, Yes, Yes, No, No, No, No, Y…
```

Note that the `anemia_cat` variable is an ordered factor variable. 
For completeness the single missing observation for the variable `hosp_adm` 
will be recoded to `No`.


```r
dataF <- dataF %>% 
    mutate(hosp_visit = forcats::fct_explicit_na(hosp_visit, na_level = "No"))
Warning: There was 1 warning in `mutate()`.
ℹ In argument: `hosp_visit =
  forcats::fct_explicit_na(hosp_visit, na_level = "No")`.
Caused by warning:
! `fct_explicit_na()` was deprecated in forcats 1.0.0.
ℹ Please use `fct_na_value_to_level()` instead.
summary(dataF)
      sid           anemia_cat       community   fever    
 Min.   :  1.0   Normal  : 92   Asuogya   : 61   No :160  
 1st Qu.:119.8   Mild    :143   Sunkwae   : 62   Yes:316  
 Median :240.5   Moderate:226   Dromankoma:229            
 Mean   :240.2   Severe  : 15   Kasei     :124            
 3rd Qu.:360.2                                            
 Max.   :501.0                                            
     sex         famsize         moccup2      foccup2   
 Male  :252   Min.   : 0.000   Farmer:314   Farmer:355  
 Female:224   1st Qu.: 4.000   Other :162   Other :121  
              Median : 5.000                            
              Mean   : 5.151                            
              3rd Qu.: 6.000                            
              Max.   :11.000                            
 hosp_visit
 No :320   
 Yes:156   
           
           
           
           
```

## Model specification

Now we begin the ordinal regression by fixing the first model, the Null model.


```r
Model_0 <- ordinal::clm(anemia_cat ~ 1, data = dataF, link = "logit")
summary(Model_0)
formula: anemia_cat ~ 1
data:    dataF

 link  threshold nobs logLik  AIC     niter max.grad
 logit flexible  476  -543.39 1092.77 7(0)  2.15e-13
 cond.H 
 1.4e+01

Threshold coefficients:
                Estimate Std. Error z value
Normal|Mild     -1.42885    0.11608 -12.310
Mild|Moderate   -0.02521    0.09168  -0.275
Moderate|Severe  3.42535    0.26237  13.056
```

Subsequently, we introduce the fever variable as independent and express the 
results as OR with 95%CI


```r
Model_1 <- ordinal::clm(anemia_cat ~ fever, data = dataF, link = "logit")

broom::tidy(Model_1, conf.int = TRUE, exponentiate = TRUE)%>% 
    flextable::as_flextable() %>% 
    flextable::colformat_double(
        j = c("estimate", "std.error", "statistic", "p.value", 
              "conf.low", "conf.high"), 
        digits = 3)
```


```{=html}
<div class="tabwid"><style>.cl-1b71dfc2{}.cl-1b67697a{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-1b676998{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(153, 153, 153, 1.00);background-color:transparent;}.cl-1b6b7a4c{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-1b6b7a56{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-1b6b92ac{width:1.454in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92ad{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92b6{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92b7{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92c0{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92ca{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92cb{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92d4{width:1.454in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92d5{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92de{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92df{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92e0{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92e8{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92e9{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92ea{width:1.454in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92f2{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92f3{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92f4{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92f5{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b92fc{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9306{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9307{width:1.454in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9310{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9311{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9312{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b931a{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b931b{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1b6b9324{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-1b71dfc2'><thead><tr style="overflow-wrap:break-word;"><th class="cl-1b6b92ac"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">term</span></p></th><th class="cl-1b6b92ad"><p class="cl-1b6b7a56"><span class="cl-1b67697a">estimate</span></p></th><th class="cl-1b6b92b6"><p class="cl-1b6b7a56"><span class="cl-1b67697a">std.error</span></p></th><th class="cl-1b6b92b7"><p class="cl-1b6b7a56"><span class="cl-1b67697a">statistic</span></p></th><th class="cl-1b6b92b7"><p class="cl-1b6b7a56"><span class="cl-1b67697a">p.value</span></p></th><th class="cl-1b6b92c0"><p class="cl-1b6b7a56"><span class="cl-1b67697a">conf.low</span></p></th><th class="cl-1b6b92ca"><p class="cl-1b6b7a56"><span class="cl-1b67697a">conf.high</span></p></th><th class="cl-1b6b92cb"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">coef.type</span></p></th></tr><tr style="overflow-wrap:break-word;"><th class="cl-1b6b92d4"><p class="cl-1b6b7a4c"><span class="cl-1b676998">character</span></p></th><th class="cl-1b6b92d5"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92de"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92df"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92df"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92e0"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92e8"><p class="cl-1b6b7a56"><span class="cl-1b676998">numeric</span></p></th><th class="cl-1b6b92e9"><p class="cl-1b6b7a4c"><span class="cl-1b676998">character</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-1b6b92ea"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">Normal|Mild</span></p></td><td class="cl-1b6b92f2"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.306</span></p></td><td class="cl-1b6b92f3"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.163</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">-7.268</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.000</span></p></td><td class="cl-1b6b92f5"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b92fc"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b9306"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1b6b92ea"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">Mild|Moderate</span></p></td><td class="cl-1b6b92f2"><p class="cl-1b6b7a56"><span class="cl-1b67697a">1.257</span></p></td><td class="cl-1b6b92f3"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.152</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">1.505</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.132</span></p></td><td class="cl-1b6b92f5"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b92fc"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b9306"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1b6b92ea"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">Moderate|Severe</span></p></td><td class="cl-1b6b92f2"><p class="cl-1b6b7a56"><span class="cl-1b67697a">40.111</span></p></td><td class="cl-1b6b92f3"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.293</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">12.601</span></p></td><td class="cl-1b6b92f4"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.000</span></p></td><td class="cl-1b6b92f5"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b92fc"><p class="cl-1b6b7a56"><span class="cl-1b67697a"></span></p></td><td class="cl-1b6b9306"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1b6b9307"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">feverYes</span></p></td><td class="cl-1b6b9310"><p class="cl-1b6b7a56"><span class="cl-1b67697a">1.461</span></p></td><td class="cl-1b6b9311"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.181</span></p></td><td class="cl-1b6b9312"><p class="cl-1b6b7a56"><span class="cl-1b67697a">2.090</span></p></td><td class="cl-1b6b9312"><p class="cl-1b6b7a56"><span class="cl-1b67697a">0.037</span></p></td><td class="cl-1b6b931a"><p class="cl-1b6b7a56"><span class="cl-1b67697a">1.024</span></p></td><td class="cl-1b6b931b"><p class="cl-1b6b7a56"><span class="cl-1b67697a">2.086</span></p></td><td class="cl-1b6b9324"><p class="cl-1b6b7a4c"><span class="cl-1b67697a">location</span></p></td></tr></tbody></table></div>
```


Results indicate a significant association between fever and the degree of anaemia (OR=1.46, 95%CI: 1.02 to 2.09). Performing an ANOVA test to see if there exists a difference between the 2 models.


```r
anova(Model_0, Model_1)
```


```{=html}
<table class="huxtable" style="border-collapse: collapse; border: 0px; margin-bottom: 2em; margin-top: 2em; ; margin-left: auto; margin-right: auto;  " id="tab:unnamed-chunk-7">
<caption style="caption-side: top; text-align: center;">(#tab:unnamed-chunk-7) </caption><col><col><col><col><col><col><tr>
<th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">no.par</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">AIC</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">logLik</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">LR.stat</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">df</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Pr(&gt;Chisq)</th></tr>
<tr>
<td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">3</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1.09e+03</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">-543</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">&nbsp;&nbsp;&nbsp;</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;"></td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
<td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">4</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1.09e+03</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">-541</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">4.37</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">0.0367</td></tr>
</table>

```


The results indicate adding fever to the Null model significantly improves the null model.

Next, we add the community variable


```r
Model_2 <- 
     ordinal::clm(anemia_cat ~ fever + community, data = dataF, link = "logit")

broom::tidy(Model_2, conf.int = TRUE, exponentiate = TRUE)%>% 
    flextable::as_flextable() %>% 
    flextable::colformat_double(
        j = c("estimate", "std.error", "statistic", "p.value", 
              "conf.low", "conf.high"), 
        digits = 3)
```


```{=html}
<div class="tabwid"><style>.cl-1bc93c7c{}.cl-1bbefd52{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-1bbefd5c{font-family:'Arial';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(153, 153, 153, 1.00);background-color:transparent;}.cl-1bc2c388{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-1bc2c392{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-1bc2d972{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d97c{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d97d{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d986{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d990{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d99a{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d99b{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9a4{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9a5{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9a6{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9ae{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9af{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9b8{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9b9{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9ba{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9c2{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9cc{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9cd{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9d6{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9d7{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9d8{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9e0{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9ea{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9eb{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9f4{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9f5{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9f6{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9f7{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9fe{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2d9ff{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da00{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da08{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da12{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da13{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da14{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da1c{width:1.941in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da1d{width:0.863in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da26{width:0.854in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da27{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da30{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da31{width:0.905in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-1bc2da3a{width:0.922in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-1bc93c7c'><thead><tr style="overflow-wrap:break-word;"><th class="cl-1bc2d972"><p class="cl-1bc2c388"><span class="cl-1bbefd52">term</span></p></th><th class="cl-1bc2d97c"><p class="cl-1bc2c392"><span class="cl-1bbefd52">estimate</span></p></th><th class="cl-1bc2d97d"><p class="cl-1bc2c392"><span class="cl-1bbefd52">std.error</span></p></th><th class="cl-1bc2d986"><p class="cl-1bc2c392"><span class="cl-1bbefd52">statistic</span></p></th><th class="cl-1bc2d986"><p class="cl-1bc2c392"><span class="cl-1bbefd52">p.value</span></p></th><th class="cl-1bc2d990"><p class="cl-1bc2c392"><span class="cl-1bbefd52">conf.low</span></p></th><th class="cl-1bc2d99a"><p class="cl-1bc2c392"><span class="cl-1bbefd52">conf.high</span></p></th><th class="cl-1bc2d99b"><p class="cl-1bc2c388"><span class="cl-1bbefd52">coef.type</span></p></th></tr><tr style="overflow-wrap:break-word;"><th class="cl-1bc2d9a4"><p class="cl-1bc2c388"><span class="cl-1bbefd5c">character</span></p></th><th class="cl-1bc2d9a5"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9a6"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9ae"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9ae"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9af"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9b8"><p class="cl-1bc2c392"><span class="cl-1bbefd5c">numeric</span></p></th><th class="cl-1bc2d9b9"><p class="cl-1bc2c388"><span class="cl-1bbefd5c">character</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9ba"><p class="cl-1bc2c388"><span class="cl-1bbefd52">Normal|Mild</span></p></td><td class="cl-1bc2d9c2"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.191</span></p></td><td class="cl-1bc2d9cc"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.286</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">-5.789</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.000</span></p></td><td class="cl-1bc2d9d6"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d7"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d8"><p class="cl-1bc2c388"><span class="cl-1bbefd52">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9ba"><p class="cl-1bc2c388"><span class="cl-1bbefd52">Mild|Moderate</span></p></td><td class="cl-1bc2d9c2"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.808</span></p></td><td class="cl-1bc2d9cc"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.274</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">-0.775</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.438</span></p></td><td class="cl-1bc2d9d6"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d7"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d8"><p class="cl-1bc2c388"><span class="cl-1bbefd52">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9ba"><p class="cl-1bc2c388"><span class="cl-1bbefd52">Moderate|Severe</span></p></td><td class="cl-1bc2d9c2"><p class="cl-1bc2c392"><span class="cl-1bbefd52">27.058</span></p></td><td class="cl-1bc2d9cc"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.367</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">8.985</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.000</span></p></td><td class="cl-1bc2d9d6"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d7"><p class="cl-1bc2c392"><span class="cl-1bbefd52"></span></p></td><td class="cl-1bc2d9d8"><p class="cl-1bc2c388"><span class="cl-1bbefd52">intercept</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9e0"><p class="cl-1bc2c388"><span class="cl-1bbefd52">feverYes</span></p></td><td class="cl-1bc2d9ea"><p class="cl-1bc2c392"><span class="cl-1bbefd52">1.373</span></p></td><td class="cl-1bc2d9eb"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.183</span></p></td><td class="cl-1bc2d9f4"><p class="cl-1bc2c392"><span class="cl-1bbefd52">1.728</span></p></td><td class="cl-1bc2d9f4"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.084</span></p></td><td class="cl-1bc2d9f5"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.958</span></p></td><td class="cl-1bc2d9f6"><p class="cl-1bc2c392"><span class="cl-1bbefd52">1.966</span></p></td><td class="cl-1bc2d9f7"><p class="cl-1bc2c388"><span class="cl-1bbefd52">location</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9ba"><p class="cl-1bc2c388"><span class="cl-1bbefd52">communitySunkwae</span></p></td><td class="cl-1bc2d9c2"><p class="cl-1bc2c392"><span class="cl-1bbefd52">1.179</span></p></td><td class="cl-1bc2d9cc"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.343</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.479</span></p></td><td class="cl-1bc2d9cd"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.632</span></p></td><td class="cl-1bc2d9d6"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.602</span></p></td><td class="cl-1bc2d9d7"><p class="cl-1bc2c392"><span class="cl-1bbefd52">2.314</span></p></td><td class="cl-1bc2d9d8"><p class="cl-1bc2c388"><span class="cl-1bbefd52">location</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2d9fe"><p class="cl-1bc2c388"><span class="cl-1bbefd52">communityDromankoma</span></p></td><td class="cl-1bc2d9ff"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.626</span></p></td><td class="cl-1bc2da00"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.268</span></p></td><td class="cl-1bc2da08"><p class="cl-1bc2c392"><span class="cl-1bbefd52">-1.747</span></p></td><td class="cl-1bc2da08"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.081</span></p></td><td class="cl-1bc2da12"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.368</span></p></td><td class="cl-1bc2da13"><p class="cl-1bc2c392"><span class="cl-1bbefd52">1.054</span></p></td><td class="cl-1bc2da14"><p class="cl-1bc2c388"><span class="cl-1bbefd52">location</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-1bc2da1c"><p class="cl-1bc2c388"><span class="cl-1bbefd52">communityKasei</span></p></td><td class="cl-1bc2da1d"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.463</span></p></td><td class="cl-1bc2da26"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.289</span></p></td><td class="cl-1bc2da27"><p class="cl-1bc2c392"><span class="cl-1bbefd52">-2.659</span></p></td><td class="cl-1bc2da27"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.008</span></p></td><td class="cl-1bc2da30"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.261</span></p></td><td class="cl-1bc2da31"><p class="cl-1bc2c392"><span class="cl-1bbefd52">0.813</span></p></td><td class="cl-1bc2da3a"><p class="cl-1bc2c388"><span class="cl-1bbefd52">location</span></p></td></tr></tbody></table></div>
```


## Checking proportional odds assumption for the model

Here we check the proportional odd assumption for our second model


```r
ordinal::nominal_test(Model_2)
```


```{=html}
<table class="huxtable" style="border-collapse: collapse; border: 0px; margin-bottom: 2em; margin-top: 2em; ; margin-left: auto; margin-right: auto;  " id="tab:unnamed-chunk-9">
<caption style="caption-side: top; text-align: center;">(#tab:unnamed-chunk-9) </caption><col><col><col><col><col><tr>
<th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Df</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">logLik</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">AIC</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">LRT</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Pr(&gt;Chi)</th></tr>
<tr>
<td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;"></td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">-535</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1.08e+03</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
<td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">2</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">-534</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1.09e+03</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">0.379</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">0.827&nbsp;&nbsp;</td></tr>
<tr>
<td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">6</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">-525</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">1.08e+03</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">18.7&nbsp;&nbsp;</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">0.00468</td></tr>
</table>

```


The significant p-value for the `community` variable indicates a breach of the proportional odd assumption

## Prediction
In this section, we will use the model created above to predict an observation in a specific anaemia severity group. First, we begin by forming the prediction data we call `newData`.


```r
NewData <- expand.grid(community = levels(dataF$community),
                       fever = levels(dataF$fever))
NewData
```


```{=html}
<table class="huxtable" style="border-collapse: collapse; border: 0px; margin-bottom: 2em; margin-top: 2em; ; margin-left: auto; margin-right: auto;  " id="tab:unnamed-chunk-10">
<caption style="caption-side: top; text-align: center;">(#tab:unnamed-chunk-10) </caption><col><col><tr>
<th style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">community</th><th style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: bold; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">fever</th></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Asuogya</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">No</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Sunkwae</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">No</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Dromankoma</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">No</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Kasei</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">No</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Asuogya</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Yes</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Sunkwae</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Yes</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Dromankoma</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Yes</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 6pt 2pt 0pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Kasei</td><td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 2pt 0pt 2pt 6pt; font-weight: normal; font-family: Arial, Times New Roman, Times, Serif; font-size: 11pt;">Yes</td></tr>
</table>

```


We now predict the probability that the specific predictor combination falls within the specific outcome category (anaemia category)


```r
(preds <- predict(Model_2, newdata = NewData, type = "prob"))
$fit
     Normal      Mild  Moderate     Severe
1 0.1601782 0.2868320 0.5173493 0.03564053
2 0.1392894 0.2675468 0.5514246 0.04173921
3 0.2335081 0.3300308 0.4138463 0.02261481
4 0.2915487 0.3440404 0.3475709 0.01684010
5 0.1220012 0.2486393 0.5810802 0.04827929
6 0.1054658 0.2277287 0.6103913 0.05641416
7 0.1816335 0.3030775 0.4845071 0.03078186
8 0.2306604 0.3289444 0.4174245 0.02297070
```

For better visualisation, we bind the original data with the predictions


```r
bind_cols(NewData, preds$fit) %>% 
    kableExtra::kbl(caption = "Probabilities", booktabs = T, digits = 3) %>%
    kableExtra::kable_classic(full_width = F, html_font = "Cambria") %>% 
    kableExtra::kable_styling(bootstrap_options = c("striped", "hover"))
```

<table class=" lightable-classic table table-striped table-hover" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-12)Probabilities</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> community </th>
   <th style="text-align:left;"> fever </th>
   <th style="text-align:right;"> Normal </th>
   <th style="text-align:right;"> Mild </th>
   <th style="text-align:right;"> Moderate </th>
   <th style="text-align:right;"> Severe </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Asuogya </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0.160 </td>
   <td style="text-align:right;"> 0.287 </td>
   <td style="text-align:right;"> 0.517 </td>
   <td style="text-align:right;"> 0.036 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sunkwae </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0.139 </td>
   <td style="text-align:right;"> 0.268 </td>
   <td style="text-align:right;"> 0.551 </td>
   <td style="text-align:right;"> 0.042 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dromankoma </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0.234 </td>
   <td style="text-align:right;"> 0.330 </td>
   <td style="text-align:right;"> 0.414 </td>
   <td style="text-align:right;"> 0.023 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kasei </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0.292 </td>
   <td style="text-align:right;"> 0.344 </td>
   <td style="text-align:right;"> 0.348 </td>
   <td style="text-align:right;"> 0.017 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Asuogya </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 0.122 </td>
   <td style="text-align:right;"> 0.249 </td>
   <td style="text-align:right;"> 0.581 </td>
   <td style="text-align:right;"> 0.048 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sunkwae </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 0.105 </td>
   <td style="text-align:right;"> 0.228 </td>
   <td style="text-align:right;"> 0.610 </td>
   <td style="text-align:right;"> 0.056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dromankoma </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 0.182 </td>
   <td style="text-align:right;"> 0.303 </td>
   <td style="text-align:right;"> 0.485 </td>
   <td style="text-align:right;"> 0.031 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kasei </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 0.231 </td>
   <td style="text-align:right;"> 0.329 </td>
   <td style="text-align:right;"> 0.417 </td>
   <td style="text-align:right;"> 0.023 </td>
  </tr>
</tbody>
</table>



## Visualising the model

Below we visualize the model by using the `MASS` and `effects` packages. We begin by fitting the model again with `polr` function.


```r
pol_model.1 <- MASS::polr(anemia_cat ~ community, data = dataF)
pol_model.2 <- MASS::polr(anemia_cat ~ fever*community, data = dataF)
```

And then we visualise the probability of having various forms of anaemia giving one belonging to the various groups.



```r
M1 <- effects::Effect(focal.predictors = "community", mod=pol_model.1)

Re-fitting to get Hessian
M2 <- effects::Effect(focal.predictors = c("community", "fever"), mod=pol_model.2)

Re-fitting to get Hessian
plot(M1)
```

<img src="Ordinal-Logistic-Regression_files/figure-html/unnamed-chunk-14-1.png" width="672" />

```r
plot(M2)
```

<img src="Ordinal-Logistic-Regression_files/figure-html/unnamed-chunk-14-2.png" width="672" />
