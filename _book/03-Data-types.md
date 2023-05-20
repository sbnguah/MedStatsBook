# The Basics
## Statistical data types
We begin proper data analysis by revising what statistical data types are. There 
are two broad types of data; Quantitative and Qualitative 

### Qualitative data
In this data type the observations fall into distinctive categories. There is 
usually no scale applicable to qualitative data type. These are further divided 
into:

#### Nomimal
These are qualitative data types that have no order. The colors of a flag for 
instance can be ”red” ”yellow” and ”green”. None of these can be said to be 
coming after the other. Contrast this to the one immediately below. A special 
type of this is the binary data type which is very common in statistical 
analysis. These are observations that can take only two values. A question that 
for instance records the presence of a disease will only have a ”Yes” or ”No” 
answer. Gender is usually recorded as ”Male” or ”Female”.

#### Ordinal
An ordinal qualitative data type has an order to it. A commonly used one is 
the socioeconomic status, often categorised as ”Low”, ”Middle” and ”High”. Although 
we cannot say that the interval between ”Low” and ”Middle” is the same as 
”Middle” and ”High”, we know ”Low” is lower than ”Middle” which in turn is also 
lower than ”High”. The Likert scale, a well known scale in many social science 
research is also an example of an ordinal scale. Ordinal variables are often 
created from quantitative (see below)variables. E.g. the ages of a group of men 
can be converted into age groups of any desired number of categories.

### Quantitative data
Quantitative or numerical data are observations such as numbers that can be 
measured. There are two types:

#### Discrete
Discrete quantitative data is one that only specific values can be obtained. The 
number of persons attending a theatre can only be a whole number. So is the 
number of votes obtained in an election. Although discrete quantitative 
variables are often analysed as continuous ones they can occasionally pose 
problems when analysed as such. We will be dealing with some of these in the 
subsequent chapters.

#### Continuous
Continuous quantitative variables on the other hand can be measured to any 
precision, thereby making the figures they present to be as precise as the 
experimenter desires. For instance the distance between two towns can be 
measured in kilometers to as much precision as possible. Theoretically this can 
be as 12.0kms to as much as 12.0234278kms.

## Types of data in R
All data objects in R are made up of smaller units referred to as ”Atomic” data. 
The various atomic data types are *Integer*, *Double*, *Complex*, *Logical*, 
*Character*, *Factor* and *Date and Time*. These would be further explained 
subsequently. To determine the data types in R the most commonly used function 
is class(). The example below uses this function to determine the data type for 
4.2.


```r
class(4.2)
[1] "numeric"
```

As we expected it is a *numeric* variable. Next we determine the class of data 
”A”

```r
class("A")
[1] "character"
```

R classifies this as a character data type. Finally what about FALSE?

```r
class(FALSE)
[1] "logical"
```

This is a logical data type.
