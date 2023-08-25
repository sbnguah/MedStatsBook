# Risk and Odds 




The analysis of the effects above depends mainly on the p-values and confidence 
intervals of difference in proportions. There is a more common and often better 
way of expressing these using Risk and Odds. In this chapter, we will use the 
`ANCData.txt` data to illustrate these. First, we read the data


```r
df_anc <- 
    read.delim("./Data/ANCData.txt") %>% 
    mutate(
        death = factor(death, levels = c("no","yes"), labels = c("No", "Yes")),
        clinic = factor(clinic),
        anc = factor(anc, levels = c("old", "new"), labels = c("Old", "New")))
```

And summarize the data




```r
df_anc %>% 
    summarytools::dfSummary(graph.col = FALSE)
Data Frame Summary  
df_anc  
Dimensions: 755 x 3  
Duplicates: 747  

--------------------------------------------------------------------------
No   Variable   Stats / Values   Freqs (% of Valid)   Valid      Missing  
---- ---------- ---------------- -------------------- ---------- ---------
1    death      1. No            689 (91.3%)          755        0        
     [factor]   2. Yes            66 ( 8.7%)          (100.0%)   (0.0%)   

2    anc        1. Old           419 (55.5%)          755        0        
     [factor]   2. New           336 (44.5%)          (100.0%)   (0.0%)   

3    clinic     1. A             497 (65.8%)          755        0        
     [factor]   2. B             258 (34.2%)          (100.0%)   (0.0%)   
--------------------------------------------------------------------------
```



## Risk
Risk is defined as the probability of having an outcome. Therefore, if in a 
the population of 100, 35 develop diabetes mellitus after a specified period of 
follow-up, the risk of developing diabetes in the population is

$$\frac{35}{100} = 0.35$$
Tabulation of the ANC method and the occurrence of death below, we can conclude 
that the risk of perinatal mortality when one uses the old method is 0.11 (11.0%) 
and that for the new method is 0.06 (5.9%).



```r
df_anc %>% 
    tbl_cross(percent = "col",
        row = death, 
        col = anc, 
        label = list(death ~ "Death", anc = "ANC"),
        digits = c(0,2)) %>% 
    bold_labels()
```


```{=html}
<div id="ofihhmqmww" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ofihhmqmww table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ofihhmqmww thead, #ofihhmqmww tbody, #ofihhmqmww tfoot, #ofihhmqmww tr, #ofihhmqmww td, #ofihhmqmww th {
  border-style: none;
}

#ofihhmqmww p {
  margin: 0;
  padding: 0;
}

#ofihhmqmww .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ofihhmqmww .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ofihhmqmww .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ofihhmqmww .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ofihhmqmww .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ofihhmqmww .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ofihhmqmww .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ofihhmqmww .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ofihhmqmww .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ofihhmqmww .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ofihhmqmww .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ofihhmqmww .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ofihhmqmww .gt_spanner_row {
  border-bottom-style: hidden;
}

#ofihhmqmww .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#ofihhmqmww .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ofihhmqmww .gt_from_md > :first-child {
  margin-top: 0;
}

#ofihhmqmww .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ofihhmqmww .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ofihhmqmww .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ofihhmqmww .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ofihhmqmww .gt_row_group_first td {
  border-top-width: 2px;
}

#ofihhmqmww .gt_row_group_first th {
  border-top-width: 2px;
}

#ofihhmqmww .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofihhmqmww .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ofihhmqmww .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ofihhmqmww .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ofihhmqmww .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofihhmqmww .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ofihhmqmww .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ofihhmqmww .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ofihhmqmww .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ofihhmqmww .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ofihhmqmww .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofihhmqmww .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ofihhmqmww .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ofihhmqmww .gt_left {
  text-align: left;
}

#ofihhmqmww .gt_center {
  text-align: center;
}

#ofihhmqmww .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ofihhmqmww .gt_font_normal {
  font-weight: normal;
}

#ofihhmqmww .gt_font_bold {
  font-weight: bold;
}

#ofihhmqmww .gt_font_italic {
  font-style: italic;
}

#ofihhmqmww .gt_super {
  font-size: 65%;
}

#ofihhmqmww .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ofihhmqmww .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ofihhmqmww .gt_indent_1 {
  text-indent: 5px;
}

#ofihhmqmww .gt_indent_2 {
  text-indent: 10px;
}

#ofihhmqmww .gt_indent_3 {
  text-indent: 15px;
}

#ofihhmqmww .gt_indent_4 {
  text-indent: 20px;
}

#ofihhmqmww .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id=""></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="&lt;strong&gt;ANC&lt;/strong&gt;">
        <span class="gt_column_spanner"><strong>ANC</strong></span>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;strong&gt;Total&lt;/strong&gt;"><strong>Total</strong></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Old">Old</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="New">New</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Death</td>
<td headers="stat_1" class="gt_row gt_center"></td>
<td headers="stat_2" class="gt_row gt_center"></td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    No</td>
<td headers="stat_1" class="gt_row gt_center">373 (89.02%)</td>
<td headers="stat_2" class="gt_row gt_center">316 (94.05%)</td>
<td headers="stat_0" class="gt_row gt_center">689 (91.26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Yes</td>
<td headers="stat_1" class="gt_row gt_center">46 (10.98%)</td>
<td headers="stat_2" class="gt_row gt_center">20 (5.95%)</td>
<td headers="stat_0" class="gt_row gt_center">66 (8.74%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Total</td>
<td headers="stat_1" class="gt_row gt_center">419 (100.00%)</td>
<td headers="stat_2" class="gt_row gt_center">336 (100.00%)</td>
<td headers="stat_0" class="gt_row gt_center">755 (100.00%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


This can be written as
$$Re = 0:06 \text{ and } Rne = 0:11$$

Where $Re$ is the risk in the exposed group (new anc method) and $Rne$ is the 
risk in the non-exposed (old anc method). 

## Risk Ratio
A comparative way of expressing the risks in the two groups is by the use of 
the Risk Ratio or Relative Risk (RR). 
Where
$$RR = \frac{Re}{Rne}$$

Note that by inference if the $Re$ is the same as $Rne$ then $RR = 1$. The $RR$ 
of perinatal mortality of the new compared to the old method is

$$RR = \frac{5.952381}{10.978520} = 0.5421843 \approx 0.54$$

The `epiDisplay` package has a function `cs()` which automatically calculates 
the RR and other relevant stats with their confidence intervals. This is 
applied to the ANCdata as below.


```r
df_anc %$% epiDisplay::cs(outcome = death, exposure = anc, )

          Exposure
Outcome    Non-exposed Exposed Total
  Negative 373         316     689  
  Positive 46          20      66   
  Total    419         336     755  
                                    
           Rne         Re      Rt   
  Risk     0.11        0.06    0.09 
                                         Estimate Lower95ci
 Risk difference (Re - Rne)              -0.05    -0.09    
 Risk ratio                              0.54     0.32     
 Protective efficacy =(Rne-Re)/Rne*100   45.8     8.71     
   or percent of risk reduced                              
 Number needed to treat (NNT)            19.9     10.79    
   or -1/(risk difference)                                 
 Upper95ci
 -0.01    
 0.91     
 68.06    
          
 94.2     
          
```

The output above first tabulates the two variables producing a contingency table 
with the marginal totals. It then shows our previously calculated parameters, Re 
and Rne. Rt (Risk total) is the risk if both the exposed and unexposed are put 
together, here.

$$Rt =\frac{20 + 46}{419 + 336} = \frac{66}{755} \approx 0.09$$

The next section of the output shows the risk difference (difference between the 
risks of the two groups), the risk ratio, the protective efficacy and the number 
needed to treat (NNT) together with their confidence intervals.

Interpreting the analysis so far, we conclude that the risk of perinatal death 
when using the new anc method is significantly less than using the old method. 
It significantly reduces the risk of death (Risk difference) by 0.05 (5%) and 
halves the chances of death (RR = 0.54, 95%CI: 0.32 to 0.91). About 20 (95%CI: 
11 to 95) pregnant women need to be treated with the new anc method to prevent 
one perinatal death (NNT).


## Odds
Another way of expressing the risk of an outcome is using the Odds. Statistically the odds
is defined as

$$Odds = \frac{p}{1-p}$$

Where p is the probability of the outcome occurring. Using the ANCdata the probability of
death in the exposed is.

$$pe = \frac{20}{336} = 0.05952381$$

The odds of death in the exposed can then be determined as

$$Oddse = \frac{0.05952381}{1-0.05952381} = 0.06329114$$

Similarly, the probability of death in the non-exposed (old anc type) is

$$pne = \frac{46}{419} = 0.1097852$$ 

And the odds of death in the non-exposed is

$$Oddsne = \frac{0.1097852}{1-0.1097852} = 0.1233244$$ 


## Odds ratio
The comparative way of comparing the two odds is the Odds Ratio (OR). This is 
determined as

$$OR = \frac{Oddse}{Oddsne} = 0.5132086 \approx 0.51$$ 

Once again fortunately we do not have to go through this tedious procedure each 
time we need to calculate the OR. The `cc()` function in the `epiDisplay` 
package does this very well. Below we apply it to the analysis just done.


```r
df_anc %$% epiDisplay::cc(outcome=death, exposure=anc, graph = FALSE)

       anc
death   Old New Total
  No    373 316   689
  Yes    46  20    66
  Total 419 336   755

OR =  0.51 
95% CI =  0.3, 0.89  
Chi-squared = 5.9, 1 d.f., P value = 0.015
Fisher's exact test (2-sided) P value = 0.019 
```

The output shows a table of the variables in question, the OR with its 95% 
confidence interval and both p-values determine by the chi-squared test and the 
Fisher's test. With a confidence interval of the odds ratio not containing the 
null value 1, and small p-values from both methods it can be concluded that the 
odds of death in mothers who used the new ANC method is about half (0.5) of 
those who used the old method and the probability of obtaining an OR this values 
if the null was true, is low (p-value = 0.019). Therefore, the use of the new 
anc method is associated with significantly better perinatal outcomes compared 
to the old.

Odds ratios are very important in regression analysis and will be dealt with in 
more detail in subsequent chapters.









