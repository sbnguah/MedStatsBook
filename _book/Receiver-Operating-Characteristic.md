
# Receiver Operating Characteristic


Up until now we have dealt with tests that are categorized as either positive or 
negative. However, many tests are quantitative rather than qualitative. For 
instance the blood urea and nitrogen, serum cholesterol and serum protein among 
many others are measured on a continuous scale often ranging from 0 to infinity. 
Such tests pose different challenges as we often need a cut-off point to 
determine which range of values can be considered "normal" or "abnormal". As we
have learned above the sensitivity and specificity of a test are often used to 
defines how good it is. For tests on a continuous scale the sensitivity and 
specificity change depending on the cut-off provided for the measure.

In this section we use the lbw.csv data collected in a study conducted in a 
cohort of 350 newborns in Ghana. The identification of babies born with weight 
of less than 2.5kgs is important because of the special needs they require. In 
many under developed countries however the unavailability of a reliable weighing 
scale makes this a challenge. This has prompted the search for other surrogate 
measures easily available in rural areas for determining if a baby is low birth 
weight (<2.5kgs). The aim of the study was to determine how well the length or 
chest circumference of a baby could be used as a surrogate indicator for low 
birth weight in newborns. If they turn out to be good tests they can easily be 
deployed in any rural area as the only instrument needed here would be a 
measuring tape. The variables collected include their study ID (sid), birth 
weight (bweight), sex (gender), chest circumference (chc) and length
of baby (lgth).

First we read in the data after clearing the workspace


```r
df_lbw <- 
    read_csv("./Data/lbw.csv") %>% 
    mutate(gender = factor(gender)) %>% 
    mutate(bwcat = ifelse(bweight < 2.5, 1, 0) %>% 
               factor(levels = c(0,1), labels = c("Normal","Low")))
```

And then summarize it



```r
df_lbw %>% dfSummary(graph.col = F)
Data Frame Summary  
df_lbw  
Dimensions: 350 x 6  
Duplicates: 0  

---------------------------------------------------------------------------------------
No   Variable    Stats / Values              Freqs (% of Valid)    Valid      Missing  
---- ----------- --------------------------- --------------------- ---------- ---------
1    sid         Mean (sd) : 175.5 (101.2)   350 distinct values   350        0        
     [numeric]   min < med < max:                                  (100.0%)   (0.0%)   
                 1 < 175.5 < 350                                                       
                 IQR (CV) : 174.5 (0.6)                                                

2    bweight     Mean (sd) : 2.9 (0.6)       33 distinct values    350        0        
     [numeric]   min < med < max:                                  (100.0%)   (0.0%)   
                 1 < 2.9 < 4.5                                                         
                 IQR (CV) : 0.7 (0.2)                                                  

3    gender      1. Female                   166 (47.4%)           350        0        
     [factor]    2. Male                     184 (52.6%)           (100.0%)   (0.0%)   

4    chc         Mean (sd) : 31.7 (3.2)      115 distinct values   350        0        
     [numeric]   min < med < max:                                  (100.0%)   (0.0%)   
                 20 < 32 < 42.1                                                        
                 IQR (CV) : 4 (0.1)                                                    

5    lgth        Mean (sd) : 46.8 (4.3)      109 distinct values   350        0        
     [numeric]   min < med < max:                                  (100.0%)   (0.0%)   
                 28 < 47 < 60.3                                                        
                 IQR (CV) : 5.5 (0.1)                                                  

6    bwcat       1. Normal                   268 (76.6%)           350        0        
     [factor]    2. Low                       82 (23.4%)           (100.0%)   (0.0%)   
---------------------------------------------------------------------------------------
```

Next, I introduce the `pROC` package. The function `roc()` from the package will 
be used extensively in this section.

## Sensitivity, specificity and cut-offs
As mentioned above when one has a gold standard which is bivariate (indicating 
presence or absence) and a quantitative test, the sensitivity and specificity of 
the test depends on the cut-off chosen. For our `lbw.csv` data our gold standard 
for a low birth weight baby is the the birth weight categorised into low birth 
weight (LBW) or normal birth weight (NBW). Two continuous measures, the chest 
circumference and the length of the baby were used as our tests.

To illustrate the relationship between the various cut-offs with sensitivity and 
specificity we generate some arbitrary cut-offs.


```r
cut.off <- c(28, 42, 44, 46, 47, 49, 50, 51, 61)
```

From these cut-offs we generate the categories from the length of the babies 
and tabulate the resultant categorical variable.


```r
df_lbw <- 
    df_lbw %>% 
    mutate(lgthcat = cut(lgth, br=cut.off, include.lowest=T))
```

And then count the various groups


```r
df_lbw %>% 
    gtsummary::tbl_summary(
        include = lgthcat,
        digits = lgthcat ~ c(0,1)
    ) %>% 
    gtsummary::bold_labels()
```


```{=html}
<div id="khtijqsmrb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#khtijqsmrb table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#khtijqsmrb thead, #khtijqsmrb tbody, #khtijqsmrb tfoot, #khtijqsmrb tr, #khtijqsmrb td, #khtijqsmrb th {
  border-style: none;
}

#khtijqsmrb p {
  margin: 0;
  padding: 0;
}

#khtijqsmrb .gt_table {
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

#khtijqsmrb .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#khtijqsmrb .gt_title {
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

#khtijqsmrb .gt_subtitle {
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

#khtijqsmrb .gt_heading {
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

#khtijqsmrb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khtijqsmrb .gt_col_headings {
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

#khtijqsmrb .gt_col_heading {
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

#khtijqsmrb .gt_column_spanner_outer {
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

#khtijqsmrb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#khtijqsmrb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#khtijqsmrb .gt_column_spanner {
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

#khtijqsmrb .gt_spanner_row {
  border-bottom-style: hidden;
}

#khtijqsmrb .gt_group_heading {
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

#khtijqsmrb .gt_empty_group_heading {
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

#khtijqsmrb .gt_from_md > :first-child {
  margin-top: 0;
}

#khtijqsmrb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#khtijqsmrb .gt_row {
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

#khtijqsmrb .gt_stub {
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

#khtijqsmrb .gt_stub_row_group {
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

#khtijqsmrb .gt_row_group_first td {
  border-top-width: 2px;
}

#khtijqsmrb .gt_row_group_first th {
  border-top-width: 2px;
}

#khtijqsmrb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#khtijqsmrb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#khtijqsmrb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#khtijqsmrb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khtijqsmrb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#khtijqsmrb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#khtijqsmrb .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#khtijqsmrb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#khtijqsmrb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khtijqsmrb .gt_footnotes {
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

#khtijqsmrb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#khtijqsmrb .gt_sourcenotes {
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

#khtijqsmrb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#khtijqsmrb .gt_left {
  text-align: left;
}

#khtijqsmrb .gt_center {
  text-align: center;
}

#khtijqsmrb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#khtijqsmrb .gt_font_normal {
  font-weight: normal;
}

#khtijqsmrb .gt_font_bold {
  font-weight: bold;
}

#khtijqsmrb .gt_font_italic {
  font-style: italic;
}

#khtijqsmrb .gt_super {
  font-size: 65%;
}

#khtijqsmrb .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#khtijqsmrb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#khtijqsmrb .gt_indent_1 {
  text-indent: 5px;
}

#khtijqsmrb .gt_indent_2 {
  text-indent: 10px;
}

#khtijqsmrb .gt_indent_3 {
  text-indent: 15px;
}

#khtijqsmrb .gt_indent_4 {
  text-indent: 20px;
}

#khtijqsmrb .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 350&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 350</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">lgthcat</td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    [28,42]</td>
<td headers="stat_0" class="gt_row gt_center">49 (14.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (42,44]</td>
<td headers="stat_0" class="gt_row gt_center">36 (10.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (44,46]</td>
<td headers="stat_0" class="gt_row gt_center">59 (16.9%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (46,47]</td>
<td headers="stat_0" class="gt_row gt_center">35 (10.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (47,49]</td>
<td headers="stat_0" class="gt_row gt_center">67 (19.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (49,50]</td>
<td headers="stat_0" class="gt_row gt_center">39 (11.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (50,51]</td>
<td headers="stat_0" class="gt_row gt_center">25 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    (51,61]</td>
<td headers="stat_0" class="gt_row gt_center">40 (11.4%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```


Next we determine the sensitivities and specificities at the various cut-offs by 
using the `roc()` function from the `pROC` package. Since this package requires 
an ordered categorical variable we convert `lgthcat` into an ordered factor 
variable. And then go ahead to impute the relevant information into the `roc()` 
function




