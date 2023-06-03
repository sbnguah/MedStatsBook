# Data Structures in R

We have introduced R and described variable types in research and R. Data 
structures are the composite of the various atomic types described in the 
preceding chapter.

Different data structures in R include Vector, Matrix, Array, List, Data frame 
and Time-series. Most data needs to be in a specific structure to perform 
appropriate further analysis.

## Vectors
A vector is the simplest data structure in R. It is made up of a collection of 
like data types mentioned in the preceding chapter. There are numerous functions 
in R capable of creating vectors. The `c()` function is a generic function that 
combines objects into a vector by first converting them into the same data type. 
Below we create a numeric vector A
with length 10 using the `c()` function.


```r
A <- c(3, 2, 4, 5, 6, 2, 3, 1, 7, 9) 
A
 [1] 3 2 4 5 6 2 3 1 7 9
```

To create an integer vector in sequence we can use.


```r
B <- 1:10 
B
 [1]  1  2  3  4  5  6  7  8  9 10
```

Next, we use the `seq()` function to create a sequence of numbers C, from 0 to 
20 at intervals of 2.


```r
C <- seq(from = 0, to = 20, by = 2) 
C
 [1]  0  2  4  6  8 10 12 14 16 18 20
```



A vector of repeated sequences of atomic values can be created using the `rep()` 
function. Here we repeat "B" ten times to form a vector of length 10, with all 
elements being "B".


```r
D <- rep("B", times = 10) 
D
 [1] "B" "B" "B" "B" "B" "B" "B" "B" "B" "B"
```

The R base package has two functions that can generate a vector of alphabets in 
either lowercase or upper cases. These are 


```r
letters[1:12] 
 [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l"
LETTERS[1:12]
 [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L"
```

A sequence of dates as a vector can also be created.


```r
seq(as.POSIXct("2003-04-23"), by = "month", length = 12)
 [1] "2003-04-23 GMT" "2003-05-23 GMT" "2003-06-23 GMT"
 [4] "2003-07-23 GMT" "2003-08-23 GMT" "2003-09-23 GMT"
 [7] "2003-10-23 GMT" "2003-11-23 GMT" "2003-12-23 GMT"
[10] "2004-01-23 GMT" "2004-02-23 GMT" "2004-03-23 GMT"
```

Finally, a vector of specified length and atomic type can be created by the use 
of the `vector()` function.


```r
E <- vector(mode = "integer", length = 7)
E
[1] 0 0 0 0 0 0 0
```

Mathematical and other operations on vectors are carried out on each element of 
the vector. For instance, dividing a vector by 2 means every element of the 
vector will be divided by 2. First, we create a vector of numbers 1 to 10


```r
X <- 1:10
X
 [1]  1  2  3  4  5  6  7  8  9 10
```

And then divide the vector X by 2 to form Y


```r
Y <- X/2
Y
 [1] 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
```

Next, we square the same vector and call the resulting vector Z


```r
Z <- X^2
Z
 [1]   1   4   9  16  25  36  49  64  81 100
```

Note that when X was divided by 2 every member of the vector was halved. 
Similarly squaring the vector meant the resulting vector Z has elements that are 
the squares of X.

## Matrices
Matrices are vectors arranged in two dimensions made up of rows and columnns 
(r,c). Below is an example of a 3 x 5 matrix (matrix with three rows and five 
columns)

$$
C =\begin{bmatrix}
1 & 2 & 3 & 4 & 5 \\
3 & 4 & 5 & 6 & 7 \\
5 & 4 & 3 & 4 & 8
\end{bmatrix}
$$

There a number of ways matrices can be created in R. Below is just one of them. 
First, we can create vectors and combine them by row using `rbind()`. We begin 
by creating three vectors and naming them with the desired row names of the 
matrix


```r
Row1 <- c(1, 2, 3, 4, 5)
Row2 <- c(3, 4, 5, 6, 7)
Row3 <- c(5, 4, 3, 4, 8)
```

And then bind them together to form the matrix


```r
mat4 <- rbind(Row1, Row2, Row3)
mat4
     [,1] [,2] [,3] [,4] [,5]
Row1    1    2    3    4    5
Row2    3    4    5    6    7
Row3    5    4    3    4    8
```

mat4 has row names but not column names. We therefore go
ahead to name the columns of the matrix using the function `colnames()`


```r
colnames(mat4) <- c("Col1", "Col2", "Col3", "Col4", "Col5")
mat4
     Col1 Col2 Col3 Col4 Col5
Row1    1    2    3    4    5
Row2    3    4    5    6    7
Row3    5    4    3    4    8
```

## Arrays
An array is a vector with more than two dimensions. It can be created by assigning dimensions to a vector or using the `array()` function. The creation of a three dimentional array is illustrated below.


```r
Y <- array(X, 
           dim = c(2,3,2), 
           dimnames = list(
               Sex = c("M","F"), 
               Color = c("red", "blue", "green"), 
               Age=c("<30yrs",">=30yrs")
               )
           )
Y
, , Age = <30yrs

   Color
Sex red blue green
  M   1    3     5
  F   2    4     6

, , Age = >=30yrs

   Color
Sex red blue green
  M   7    9     1
  F   8   10     2
class(Y)
[1] "array"
```



All mathematical manipulations applicable to vectors are also applicable to 
matrices and arrays. Matrices, however can be used in matrix algebra in the 
field of mathematics and statistics. This is beyond the scope of this book and 
will not be discussed further.


## Data frame

A data frame is the most important object in R. It's used for numerous 
statistical manipulations. Compared to matrices and arrays which have columns 
that are of the same class, data frames can have various columns being of 
different classes. Most standard statistical datasets are manipulated in R as 
data frames. An example data frame can be created in R using the function 
`data.frame()`. Todo this we first create four different vectors sex, age, 
colour and old.


```r
sex <- gl(n = 2, k = 5, label = c("Male","Female")) 
age <- c(5, 2, 5, 6, 5, 6, 7, 8, 7, 7) 
color <- rep(c("Red", "Blue"), times=5) 
old <- age > 6
```

Next, we combine the four vectors into a data frame


```r
df1 <- data.frame(sex, age, color, old) 
df1
      sex age color   old
1    Male   5   Red FALSE
2    Male   2  Blue FALSE
3    Male   5   Red FALSE
4    Male   6  Blue FALSE
5    Male   5   Red FALSE
6  Female   6  Blue FALSE
7  Female   7   Red  TRUE
8  Female   8  Blue  TRUE
9  Female   7   Red  TRUE
10 Female   7  Blue  TRUE
```

Next we check the structure of the data frame with the function `str()`. 


```r
str(df1)
'data.frame':	10 obs. of  4 variables:
 $ sex  : Factor w/ 2 levels "Male","Female": 1 1 1 1 1 2 2 2 2 2
 $ age  : num  5 2 5 6 5 6 7 8 7 7
 $ color: chr  "Red" "Blue" "Red" "Blue" ...
 $ old  : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
```

The output indicates there are 4 variables and 10 records. Also, it describes 
the classes of the various variables, giving a few examples per variable.


## List
In R, a list is a set of different elements of objects put together. It is 
similar to a data frame but the components can be made up of objects other than 
a vector. These include matrices, arrays, data frames etc. Below we create a 
list called `list1` made up of three elements and using the `list()` function. 
The first is a data frame called `DF`. The second is a numeric vector of length 
5 called `Vec` and the last is a character called `Color`.


```r
list1 <- list(DF = df1,  Vec =1 :5, Color = "Red")
list1
$DF
      sex age color   old
1    Male   5   Red FALSE
2    Male   2  Blue FALSE
3    Male   5   Red FALSE
4    Male   6  Blue FALSE
5    Male   5   Red FALSE
6  Female   6  Blue FALSE
7  Female   7   Red  TRUE
8  Female   8  Blue  TRUE
9  Female   7   Red  TRUE
10 Female   7  Blue  TRUE

$Vec
[1] 1 2 3 4 5

$Color
[1] "Red"
```

## Tables

Tables are objects that display frequencies. Its use is very popular in 
statistical and mathematical literature. Tables can be constructed in many ways 
in R using the function `table()`. They can also be created from other objects 
such as arrays and matrices using `as.table()`. The simplest form of a table is 
the count or frequency of occurrence of elements of a vector.

At the outpatient clinic of a hospital in Accra, Ghana, 8 patients were randomly 
selected and their sex was noted. These are recorded in the vector `Gender` 
below.


```r
Sex <- c("Male",  "Female",  "Female",  "Male",  "Male", "Female", "Male", "Male")
Sex
[1] "Male"   "Female" "Female" "Male"   "Male"   "Female"
[7] "Male"   "Male"  
```

To determine the frequencies of the different sexes we tabulate the vector 
yielding a table object, `table.1`.


```r
table.1 <- table(Sex)
table.1
Sex
Female   Male 
     3      5 
```


The result indicates we have five males and three females in our selected 
patients. The function `is.table()` determines if an object is a table. Though 
we know `table.1` is a table we test this below


```r
is.table(table.1)
[1] TRUE
```

Contingency tables, a cross-tabulation of two or more variables or vectors are 
very common in research. The vectors below represent data from randomly selected 
8 pupils from a basic school in Ghana. Four pens were then randomly given to some 
of the pupils. The vector Sex is a recording of their sex while Pen indicates if 
the pupil was given a pen or not. We create these two vectors.


```r
Sex<-c("Male", "Female", "Female", "Male", "Male", "Female", "Male", "Male")
Pen<-c("No", "Yes", "Yes", "Yes", "Yes", "No", "No", "No")
```



Next, we cross-tabulate them using the `table()` function.


```r
table(Sex, Pen)
        Pen
Sex      No Yes
  Female  1   2
  Male    3   2
Pen
[1] "No"  "Yes" "Yes" "Yes" "Yes" "No"  "No"  "No" 
```

The output indicates that there were in all three females two of whom had pens. 
Also, there were five males two of whom had pens given to them.
