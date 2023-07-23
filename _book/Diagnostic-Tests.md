
# Diagnostic Tests



Scientific testing for the presence of various disease conditions or processes 
is very common in everyday life. This could range from the complex testing for 
the presence of strange diseases to newly manufactured electrical gadgets for 
defects. Very often there is a Gold Standard test, one that is deemed to 
perfectly determine the presence or absence of the condition. However there is
always the search for alternative test often because they are cheaper or easier 
to use compared to the Gold standard.

In a study to diagnose malaria in children attending an outpatient clinic in 
Ghana, children with a clinical suspicion of malaria were tested using three 
methods. First a blood film reported as a count of the malaria parasites 
(Gold standard) was done. Two rapid diagnostic kits, called here RDT.1 and RDT.2 
were also done concurrently and reported as positive (1) or negative (0). These 
were done for 100 patients and recorded in `malaria.csv`. Our task is to 
evaluate RDT.1's ability to accurately and reliably diagnose malaria.

First we read in the data


```r
df_malaria <- 
    read_csv("./Data/malaria.txt") %>% 
    mutate(
        gold = ifelse(mps == 0, 0, 1) %>% 
            factor(levels = c(1,0),
                   labels = c("Positive", "Negative")),
        across(
            c(rdt.1, rdt.2), 
            ~factor(
                .x, 
                levels = c(1,0),
                labels = c("Positive", "Negative"),
            )
        )
    )
```

Summary of the data is as shown below





```r
df_malaria %>% summarytools::dfSummary(graph.col = F)
Data Frame Summary  
df_malaria  
Dimensions: 100 x 4  
Duplicates: 44  

-----------------------------------------------------------------------------------------
No   Variable    Stats / Values                 Freqs (% of Valid)   Valid      Missing  
---- ----------- ------------------------------ -------------------- ---------- ---------
1    mps         Mean (sd) : 3365.2 (23683.3)   53 distinct values   100        0        
     [numeric]   min < med < max:                                    (100.0%)   (0.0%)   
                 0 < 62.5 < 236155                                                       
                 IQR (CV) : 413.8 (7)                                                    

2    rdt.1       1. Positive                    52 (52.0%)           100        0        
     [factor]    2. Negative                    48 (48.0%)           (100.0%)   (0.0%)   

3    rdt.2       1. Positive                    51 (51.0%)           100        0        
     [factor]    2. Negative                    49 (49.0%)           (100.0%)   (0.0%)   

4    gold        1. Positive                    54 (54.0%)           100        0        
     [factor]    2. Negative                    46 (46.0%)           (100.0%)   (0.0%)   
-----------------------------------------------------------------------------------------
```




And then tabulate rdt.1 and the Gold Standard as 


```r
df_malaria %>% 
    gtsummary::tbl_cross(
        col = gold,
        row = rdt.1,
        label = list(
            gold ~ "Gold Standard",
            rdt.1 ~ "First RDT"
        )
    ) %>% 
    gtsummary::bold_labels()
```


```{=html}
<div id="nyhunkmikt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nyhunkmikt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nyhunkmikt thead, #nyhunkmikt tbody, #nyhunkmikt tfoot, #nyhunkmikt tr, #nyhunkmikt td, #nyhunkmikt th {
  border-style: none;
}

#nyhunkmikt p {
  margin: 0;
  padding: 0;
}

#nyhunkmikt .gt_table {
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

#nyhunkmikt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nyhunkmikt .gt_title {
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

#nyhunkmikt .gt_subtitle {
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

#nyhunkmikt .gt_heading {
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

#nyhunkmikt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nyhunkmikt .gt_col_headings {
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

#nyhunkmikt .gt_col_heading {
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

#nyhunkmikt .gt_column_spanner_outer {
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

#nyhunkmikt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nyhunkmikt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nyhunkmikt .gt_column_spanner {
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

#nyhunkmikt .gt_spanner_row {
  border-bottom-style: hidden;
}

#nyhunkmikt .gt_group_heading {
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

#nyhunkmikt .gt_empty_group_heading {
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

#nyhunkmikt .gt_from_md > :first-child {
  margin-top: 0;
}

#nyhunkmikt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nyhunkmikt .gt_row {
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

#nyhunkmikt .gt_stub {
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

#nyhunkmikt .gt_stub_row_group {
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

#nyhunkmikt .gt_row_group_first td {
  border-top-width: 2px;
}

#nyhunkmikt .gt_row_group_first th {
  border-top-width: 2px;
}

#nyhunkmikt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nyhunkmikt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nyhunkmikt .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nyhunkmikt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nyhunkmikt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nyhunkmikt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nyhunkmikt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nyhunkmikt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nyhunkmikt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nyhunkmikt .gt_footnotes {
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

#nyhunkmikt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nyhunkmikt .gt_sourcenotes {
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

#nyhunkmikt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nyhunkmikt .gt_left {
  text-align: left;
}

#nyhunkmikt .gt_center {
  text-align: center;
}

#nyhunkmikt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nyhunkmikt .gt_font_normal {
  font-weight: normal;
}

#nyhunkmikt .gt_font_bold {
  font-weight: bold;
}

#nyhunkmikt .gt_font_italic {
  font-style: italic;
}

#nyhunkmikt .gt_super {
  font-size: 65%;
}

#nyhunkmikt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nyhunkmikt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nyhunkmikt .gt_indent_1 {
  text-indent: 5px;
}

#nyhunkmikt .gt_indent_2 {
  text-indent: 10px;
}

#nyhunkmikt .gt_indent_3 {
  text-indent: 15px;
}

#nyhunkmikt .gt_indent_4 {
  text-indent: 20px;
}

#nyhunkmikt .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id=""></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="&lt;strong&gt;Gold Standard&lt;/strong&gt;">
        <span class="gt_column_spanner"><strong>Gold Standard</strong></span>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;strong&gt;Total&lt;/strong&gt;"><strong>Total</strong></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Positive">Positive</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Negative">Negative</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">First RDT</td>
<td headers="stat_1" class="gt_row gt_center"></td>
<td headers="stat_2" class="gt_row gt_center"></td>
<td headers="stat_0" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Positive</td>
<td headers="stat_1" class="gt_row gt_center">50</td>
<td headers="stat_2" class="gt_row gt_center">2</td>
<td headers="stat_0" class="gt_row gt_center">52</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Negative</td>
<td headers="stat_1" class="gt_row gt_center">4</td>
<td headers="stat_2" class="gt_row gt_center">44</td>
<td headers="stat_0" class="gt_row gt_center">48</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Total</td>
<td headers="stat_1" class="gt_row gt_center">54</td>
<td headers="stat_2" class="gt_row gt_center">46</td>
<td headers="stat_0" class="gt_row gt_center">100</td></tr>
  </tbody>
  
  
</table>
</div>
```


The table above decomposes the the test results into 4 distinct categories.

1. Those who had both RDT.1 and the gold standard positive (True positive) were 50.
1. The group with both RDT.1 and Gold standard negative (True Negative) were 44.
1. The group that apparently showed a positive RDT.1 results when they actually are negative by the Gold standard (False positive) were 2.
1. Finally the last group, those whose RDT.1 result were negative but are actually positive
judging by the Gold standard (False negative) were 4.

We operationalise these by extracting relevant portions of the table below


```r
tp <- 50
tn <- 44
fp <- 2
fn <- 4
```

## True prevalence of the disease
The true prevalence of the disease is the proportion of the diseased individuals 
observed in the study population as determine by the gold standard. This is 
mathematically given by
 $$True~prevalence = \frac{tp + fn}{tp + tn + fp + fn}$$


And determined with our data as


```r
true.prevalence <- (tp+fn)/(tp+tn+fp+fn)
true.prevalence
[1] 0.54
```

## Apparent prevalence of the disease
The apparent prevalence of the disease is the proportion of the diseased 
individuals observed in the study population as determine by the RDT.1 test. 
This is mathematically given by
 $$Apparent~prevalence = \frac{tp + fp}{tp + tn + fp + fn}$$
And determined with our data by

```r
apparent.prevalence<-(tp+fp)/(tp+tn+fp+fn)
apparent.prevalence
[1] 0.52
```

## Sensitivity of a test
The sensitivity of a test defines as the proportion of individuals with the 
disease who are correctly identified by the test applied. It ranges form 0, a completely useless test to 1,a perfect test. Mathematically this is defined as

$$Sensitivity = \frac{tp}{tp + fn}$$
And is determined as below

```r
sensitivity <- tp/(tp+fn)
sensitivity
[1] 0.9259259
```

## Specificity of a test
The specificity of a test is defined as proportion of individuals without the 
disease who are correctly identified by the test used. It ranges form 0, a 
completely useless test to 1, a perfect test. Mathematically this is defined as
$$Specificity = \frac{tn}{tn + fp}$$

And determine as below

```r
specificity<-tn/(tn+fp)
specificity
[1] 0.9565217
```

## Predictive value of a test
### Positive predictive value of a test
The positive predictive value (ppv) of a test is defined as the proportion of 
individuals with a positive test result who have the disease. This is a more 
useful measure compared to the sensitivity and specificity because it indicates 
how much weight one has to put on a positive test result when confronted with 
one. Mathematically it is defined as:

$$PPV = \frac{tp}{tp + fp}$$

```r
ppv <- tp/(tp+fp)
ppv
[1] 0.9615385
```

### Negative predictive value of a test
The negative predictive value (npv) of a test is defined as the proportion of 
individuals with a negative test result who do not have the disease. As with 
the ppv this is a more useful measure compared to the sensitivity and 
specificity as it indicates how much weight one has to put on a negative test 
result when confronted with one. Mathematically it is defined as:
$$NPV = \frac{tn}{tn + fn}$$
And determined as below


```r
npv <- tn/(tn+fn)
npv
[1] 0.9166667
```


## Likelihood ratio of a test
The likelihood ratio of a test is another way of expressing its usefulness. 
Unlike the previous statistics about tests the likelihood ratios stretch beyond 
0 to 1. A likelihood ratio of 1 indicates a useless (non-discriminatory) test.

### The Positive likelihood ratio (LR+) 
This is the ratio of the chance of a positive result if the patient has the 
disease to the chance of a positive result if he does not have the disease. The 
higher the positive likelihood the better the test.

This is mathematically equivalent to

$$LR+ = \frac{Sensitivity}{1-Specificity}$$

Applying this to our data so far we have


```r
pLR <- sensitivity/(1-specificity)
pLR
[1] 21.2963
```

### Negative liklihood ratio (LR-)
The negative likelihood ratio (LR-) on the other hand is the ratio of the 
chance of a person having a negative result having the disease to the chance of 
a negative result in a person not having the disease. The lower the negative 
likelihood the better the test.

Computationally this is equivalent to
$$LR+ = \frac{1-Sensitivity}{Specificity}$$
Applying this to our data so far we have

```r
nLR<-(1-sensitivity)/specificity
nLR
[1] 0.07744108
```


## Summary
Fortunately all these can be obtained in one go using the `epi.tests()` function 
from the `epiR`package. The function however requires a table formatted in a 
specific way. Below we creat the table


```r
table.test <- 
    df_malaria %$%
    table(rdt.1, gold)

table.test
          gold
rdt.1      Positive Negative
  Positive       50        2
  Negative        4       44
```

And then we evaluate the test


```r
table.test %>% epiR::epi.tests()
          Outcome +    Outcome -      Total
Test +           50            2         52
Test -            4           44         48
Total            54           46        100

Point estimates and 95% CIs:
--------------------------------------------------------------
Apparent prevalence *                  0.52 (0.42, 0.62)
True prevalence *                      0.54 (0.44, 0.64)
Sensitivity *                          0.93 (0.82, 0.98)
Specificity *                          0.96 (0.85, 0.99)
Positive predictive value *            0.96 (0.87, 1.00)
Negative predictive value *            0.92 (0.80, 0.98)
Positive likelihood ratio              21.30 (5.48, 82.77)
Negative likelihood ratio              0.08 (0.03, 0.20)
False T+ proportion for true D- *      0.04 (0.01, 0.15)
False T- proportion for true D+ *      0.07 (0.02, 0.18)
False T+ proportion for T+ *           0.04 (0.00, 0.13)
False T- proportion for T- *           0.08 (0.02, 0.20)
Correctly classified proportion *      0.94 (0.87, 0.98)
--------------------------------------------------------------
* Exact CIs
```

**Conclusion**: With the high (all above 0.9) Sensitivity, Specificity, PPV and 
NPV this appears to be a very good test. This is confirmed by the relatively 
high LR+ and low LR-.











