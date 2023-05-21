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
