

# R data types

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

As we expected it is a *numeric* variable. Next, we determine the class of data 
”A”

```r
class("A")
[1] "character"
```

R classifies this as a character data type. Finally, what about FALSE?


```r
class(FALSE)
[1] "logical"
```

This is a logical data type.

## Integer

The integer data types are made up of numeric variables that can be counted, 
similar to the discrete quantitative variable described above. By default, R 
does not store numbers as integers but there may arise situations where numbers 
will have to be converted to integers to facilitate manipulations. To determine 
if data is of class integer we use the function is.integer(). To convert data 
of another type to integer we use the function as.integer(). As an illustration, 
we determine if the number 9 in R is an integer. We first, assign the number 9 
to X and then we ask if X is stored as an integer.


```r
X <- 9
is.integer(X)
[1] FALSE
```

It is not! Next, we convert it to an integer, this time calling it Y. Then find 
out if it is. 


```r
Y <- as.integer(X)
is.integer(Y)
[1] TRUE
```

It is an integer now.

## Double

This is a number that can take any value including decimals, similar to the 
continuous quantitative variable discussed above. Double is the default type 
of numeric variable used by R. To illustrate this point let's look at the 
properties of the number 7.1 in R. First we assign the name "A" to 7.1.


```r
A <- 7.1
```

And then find out if A is of class "Double".


```r
is.double(A)
[1] TRUE
```

Numeric data types stored as double are never stored as exact but rather as 
approximations of real numbers. To illustrate this, we add three As and test if 
the answer is 21.3


```r
21.3 == A + A + A 
[1] FALSE
```

It may appear strange that adding A or 7.1 three times does not equal 21.3. This 
is because A is stored as an approximate and not exact. This could be very 
important when manipulating data in R and many other statistical software.

## Logical

A Logical is an object stored as TRUE or FALSE. The example below shows the 
creation of "Z"  from a statement asking if 5 is less than 8. Z, therefore, is 
a logical (TRUE) data type. First, we assign the values 5 and 8 to X and Y 
respectively and then create the logical data type Z by asking if X is less than 
Y in R.


```r
X <- 5
Y <- 8
Z <- X < Y
Z
[1] TRUE
```

Next, we determine the class of Z


```r
class(Z)
[1] "logical"
```

Logical objects have innate values in R such that FALSE is considered to have a 
value of 0 while TRUE has a value of 1. The output below demonstrates this.


```r
FALSE + FALSE
[1] 0
FALSE + TRUE
[1] 1
TRUE + TRUE
[1] 2
```

Apart from the "<" operator used in the example above there are other logical 
operators in R. The following examples illustrate the use of some other logical 
operators. We begin by assigning the ages of a man and his wife as 45 and 23 
years, respectively. 


```r
wife <- 23
husband <- 45
```

Next, we use this to answer some basic questions about the couple. First, we 
ask if the wife's age is less than or equal to 35


```r
wife <= 34
[1] TRUE
```

Next, we ask if the husband is more than or equal to 45 years


```r
husband >= 45
[1] TRUE
```

The next example combines three logical operators. Here we ask if the wife is 
less than 25 years old and at the same time, the husband is greater than 35 years


```r
(wife < 25) & (husband > 35)
[1] TRUE
```

Finally, we ask whether the wife is less than 25 years or the husband is greater 
than 50 years


```r
(wife < 25) | (husband > 50)
[1] TRUE
```


## Character

A Character is an object enclosed in double quotes. These are called strings or 
names and cannot be used in mathematical calculations. Examples include "red", 
"Male", and "1". As seen, "1" (different from the number 1) is a character and 
cannot be used for calculations unless converted to another object form as an 
integer or double. We illustrate some of these by creating two characters below


```r
A <- "x"
B <- "2"
```

And then determine their class.


```r
class(A)
[1] "character"
class(B)
[1] "character"
```



To illustrate that "2" is a character and so cannot be added, we do


```r
B + B
Error in B + B: non-numeric argument to binary operator
```

However, we can convert B into a numeric variable C by using the function as.numeric().


```r
C <- as.numeric(B)
class(C)
[1] "numeric"
```

We can now use the numeric variable C in calculations as below


```r
C + C
[1] 4
```

## Factor

A Factor in R is a categorical variable such as sex (male & female). Factor 
variables have levels representing the different categories. Sex naturally will 
have two levels, Male, Female. Factors can be derived from numeric and character 
objects using as.factor(). Below we form a character variable of length four 
called blood.grp using one of the most used functions in R c().


```r
blood.grp <- c("O", "AB", "B", "A")
class(blood.grp)
[1] "character"
```

And then convert it to a factor variable


```r
blood.grp2 <- as.factor(blood.grp)
class(blood.grp2) 
[1] "factor"
```

Next, we determine the categories (levels) of the factor variable using the 
function levels()


```r
levels(blood.grp2) 
[1] "A"  "AB" "B"  "O" 
```

Often, it becomes necessary that factor variables are converted to an integer 
while retaining the order in which the categories appear. For instance, one may 
have a factor variable with levels "A", "B", "C", and "D" but wants to convert 
this to an integer variable with A, B, C and D being represented by 1, 2, 3 and 
4. This is achieved in R by unclassing. Unclassing a factor variable assigns 
numbers, starting from 1 to the levels of the factors in the order of the 
levels. The output below shows the unclassed numbers for the factor blood.grp2 
and the levels they refer to. We do this by the use of the unclass() function.


```r
unclass(blood.grp2)
[1] 4 2 3 1
attr(,"levels")
[1] "A"  "AB" "B"  "O" 
```

A very useful function in R to generate a factor variable is gl(). It generates 
a factor variable with a specified number of levels (n) and replications (k). A 
practical example is shown below. Factor fac.1 is created by forming a vector 
of three levels and two replications.


```r
fac.1 <- gl(n=3, k=2)
fac.1
[1] 1 1 2 2 3 3
Levels: 1 2 3
```

The factor can also be created with labels as shown


```r
fac.2 <- gl(n=3, k=2, label=c("Apple", "Mango"," Pear"))
fac.2
[1] Apple Apple Mango Mango  Pear  Pear
Levels: Apple Mango  Pear
```

## Ordered Factor
If the order of a factor is important it must be declared as an ordered factor, 
also known as an ordinal categorical variable explained earlier in this chapter. 
Below we create a character variable.


```r
size <- c("Medium", "Large", "Small", "Medium")
class(size)
[1] "character"
```

Next, we convert it to an ordered factor using the function ordered().


```r
ord.size <- ordered(size, levels=c("Small", "Medium", "Large"))
ord.size
[1] Medium Large  Small  Medium
Levels: Small < Medium < Large
class(ord.size)
[1] "ordered" "factor" 
```

An ordered factor variable can also be derived using the gl() function introduced above.


```r
fac.3 <- gl(n=3, k=2, ordered=TRUE, label=c("Small", "Medium", "Large"))
fac.3
[1] Small  Small  Medium Medium Large  Large 
Levels: Small < Medium < Large
```

## Date and time

Date and Time objects are the last to be discussed in this section. They can be 
created with the functions

`as.Date(), as.POSIXct(), as.POSIXlt(), strptime(), ISOdatetime() and
ISOdate().`

Most date and time data creation require the use of character data and a 
"format". The format dictates to the function the format in which the character 
data is recorded i.e. dd/mm/yy, mm/dd/yyyy, yyyy/mm/dd hh:mm:ss etc. These 
formats are declared with the % symbol.

The first object we create below is of the class "Date" and is created using a 
character object "01/01/1970".  To do this we first create this character object


```r
dt.str <- "01/01/1970"
class(dt.str)
[1] "character"
```

Next, we convert the character object into a Date object


```r
dt1<-as.Date(dt.str, format="%d/%m/%Y")
dt1
[1] "1970-01-01"
class(dt1)
[1] "Date"
```

Note how the format was specified. Each day, month or year is preceded by the % 
symbol. The symbols that separate the values in the dates are also specified 
accordingly. Next, we derive an object of the class Date and time but referred 
to in R as POSIXct or POSIXlt. Though this is referred to as "Date and Time" it 
can be only a Date or Date with Time in specified formats. Below we create a 
POSIXct which is in a Date only format.


```r
dt2 <- as.POSIXct("2003-01-23")
dt2
[1] "2003-01-23 GMT"
class(dt2)
[1] "POSIXct" "POSIXt" 
```

Next, we create a Date and Time variable that shows both the date and time


```r
dt3 <- as.POSIXct("2003-04-23 15:34")
dt3
[1] "2003-04-23 15:34:00 GMT"
class(dt3)
[1] "POSIXct" "POSIXt" 
```

The next example uses the function `strptime()` to create a "POSIXlt" DateTime 
format data.


```r
dt4<-strptime("02/27/92 11:30:10", format="%m/%d/%y %H:%M:%S")
dt4
[1] "1992-02-27 11:30:10 GMT"
class(dt4)
[1] "POSIXlt" "POSIXt" 
```

Next, we use `ISOdatetime()` to create a "POSIXct" DateTime format data type. 
Note that the two functions `ISOdatetime()` and `ISOdate()` take individual 
numeric values and combine them rather than convert character variables.


```r
dt5<-ISOdatetime(
    year=2013, month=4, day=7, hour = 12, min = 33, sec = 10, tz = "GMT"
    )
dt5
[1] "2013-04-07 12:33:10 GMT"
class(dt5)
[1] "POSIXct" "POSIXt" 
```

And finally the function `ISOdate()`


```r
dt6 <- ISOdate(year = 2013, month = 4, day = 7, tz = "GMT")
dt6
[1] "2013-04-07 12:00:00 GMT"
class(dt6)
[1] "POSIXct" "POSIXt" 
```

Mathematical manipulations can be done on date objects. Subtracting one date 
from the other yields an object which is the period between the two. This object 
is of class difftime. As an illustration, we determine the time difference 
between dt5 and dt6


```r
dt5-dt6
Time difference of 33.16667 mins
```

It is worth noting here that there is a function in R, `difftime()` specifically 
designed for finding time differences.

The functions `weekdays()`, `months()` and `quarters()` extract as "character" 
datatype the days, months and quarters from date objects respectively.


```r
weekdays(dt2)
[1] "Thursday"
quarters(dt2)
[1] "Q1"
months(dt2)
[1] "January"
```

## Missing values in R
In R missing values are denoted by NA. NaN is also encountered and stands for 
"Not a number". This is often generated when one divides for instance 0 by 0.
Any operation involving NA results in an NA. Examples are shown below


```r
1 + NA
[1] NA
NA - 1
[1] NA
NA*2
[1] NA
```

The function `is.na()` produces a logical that indicates if a value is missing.

```r
is.na(2)
[1] FALSE
is.na(NA)
[1] TRUE
```

 
