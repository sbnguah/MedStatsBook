
```
Warning: package 'huxtable' was built under R version 4.3.1
```

# Logistic Regression

Up until now, we have dealt with linear regression which requires a continuous 
dependent variable. However in research, especially medical research, lots of 
outcome variables are binary such as disease present or absent, death or 
survival and cured or not cured. Modelling binary outcome data usually requires 
logistic regression and this is done in R using the `glm()` function with the 
family specified as binomial.

In this section, we go back to the `ANCdata` used previously.


```r
df_anc <- 
    readstata13::read.dta13(".\\Data\\ANCdata.dta")
```

And summarize as below




```r
df_anc %>% summarytools::dfSummary(graph.col = F)
Data Frame Summary  
df_anc  
Dimensions: 755 x 3  
Duplicates: 747  

--------------------------------------------------------------------------
No   Variable   Stats / Values   Freqs (% of Valid)   Valid      Missing  
---- ---------- ---------------- -------------------- ---------- ---------
1    death      1. no            689 (91.3%)          755        0        
     [factor]   2. yes            66 ( 8.7%)          (100.0%)   (0.0%)   

2    anc        1. old           419 (55.5%)          755        0        
     [factor]   2. new           336 (44.5%)          (100.0%)   (0.0%)   

3    clinic     1. A             497 (65.8%)          755        0        
     [factor]   2. B             258 (34.2%)          (100.0%)   (0.0%)   
--------------------------------------------------------------------------
```



## Logistic regression with a single binary predictor
Our mission is to determine the relationship between the anc (anc) type used for 
managing pregnant women and the outcome of the pregnancy (death). To answer this 
question we run a logistic regression model in its simplest form as below


```r
df_anc %>% 
    glm(death ~ anc, family=binomial, data=.) %>% 
    broom::tidy()
```


```{=html}
<table class="huxtable" style="border-collapse: collapse; border: 0px; margin-bottom: 2em; margin-top: 2em; ; margin-left: auto; margin-right: auto;  " id="tab:unnamed-chunk-6">
<caption style="caption-side: top; text-align: center;">(#tab:unnamed-chunk-6) </caption><col><col><col><col><col><tr>
<th style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0.4pt;    padding: 6pt 6pt 6pt 6pt; font-weight: bold;">term</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: bold;">estimate</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: bold;">std.error</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: bold;">statistic</th><th style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0.4pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: bold;">p.value</th></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0.4pt;    padding: 6pt 6pt 6pt 6pt; background-color: rgb(242, 242, 242); font-weight: normal;">(Intercept)</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 6pt 6pt 6pt 6pt; background-color: rgb(242, 242, 242); font-weight: normal;">-2.09&nbsp;</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 6pt 6pt 6pt 6pt; background-color: rgb(242, 242, 242); font-weight: normal;">0.156</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0pt 0pt 0pt;    padding: 6pt 6pt 6pt 6pt; background-color: rgb(242, 242, 242); font-weight: normal;">-13.4&nbsp;</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0.4pt 0.4pt 0pt 0pt;    padding: 6pt 6pt 6pt 6pt; background-color: rgb(242, 242, 242); font-weight: normal;">6.63e-41</td></tr>
<tr>
<td style="vertical-align: top; text-align: left; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0.4pt;    padding: 6pt 6pt 6pt 6pt; font-weight: normal;">ancnew</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: normal;">-0.667</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: normal;">0.279</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: normal;">-2.39</td><td style="vertical-align: top; text-align: right; white-space: normal; border-style: solid solid solid solid; border-width: 0pt 0.4pt 0.4pt 0pt;    padding: 6pt 6pt 6pt 6pt; font-weight: normal;">0.0166&nbsp;&nbsp;</td></tr>
</table>

```



The object that results from a glm() model is of class glm and lm. lm because it could also
be used for linear modelling as we did using the lm() function.

