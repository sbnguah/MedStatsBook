#	Introduction
##	The statistical data analyst
Statistical data analysis is more than just using a computer software to 
generate a set of results. It involves the basic understanding of the data type being analysed, the best way to analyse and then present such data to make sense to the population at large. Thus the data analyst :

1. Must understand the genesis (study methodology) involved in obtaining the 
data in the first place. Conclusions from the same data may be different 
depending on the study methodology used and hypothesis being tested. It is very prudent therefore that the statistical data analyst be involved in the data collection process right from the beginning.
2. Should be able to point out errors in the data collection process in the very early stages to avoid wasting valuable resources on data that may not answer the question at hand.
3. Provide valuable advice on the best method of analysing the data at hand.
4. Perform the analysis in a scientifically sound manner applying the most 
current and statistically appropriate principles.
5. Be able to present the result of the analysis in a manner that makes it easy for literally all persons without statistical and analytical expertise to completely understand with the least effort. This requires the statistical data analyst to be in a position to explain the analysis in the ”layman’s language”.
6. Finally the data analyst must know his limit. There are often instances where the analyst should seek ”professional” help even though he/she may feel he/she is on the right path. It never hurts to seek a second opinion from your peers.

It therefore goes without saying from the prior discussion that the data analyst 
must have a firm understanding of statistical and research methodology.

##	Statistical software 
Some years back, statistical analysis was one of the most tedious processes done mainly by dedicated statisticians. With the advent of computers and statistical software it has become rather handy with many advantages but some disadvantages as well.

The main advantages are:

1. The tremendous speed with which large data is processed and results obtained.
2. The accuracy of the statistical calculations performed. Computers do not make mistakes but one has to beware of rounding in some software. Some software can perform calculations to specific number of decimal places. Therefore when one is 
confronted with a figure such as 1.00377655432 the software may work with 
1.0037765, leaving out the last four digits. Calculations using this truncated 
value is likely to have different result from the non-truncated figure, thus 
affecting the accuracy ofthe result.
3. Many modern statistical software have the ability to read data from varied 
sources and formats. This makes it easy to transfer data from one software to 
another without having to re-enter the data collected into the second computer 
or software.This transferability has enabled the use of other digital equipment such as smart phones, personal digital assistants and tablets for data collection. Data collected in this manner is said to be ready for cleaning and analysis, bypassing the data entry stage.
4. Plotting graphs is one of the most important uses of modern day computerised data analysis. Statistical software tend to make this rather tedious process almost hassle free and accords one the ability to redo the plot from scratch at the click of a button. 

Despite all these advantages many disadvantages are also inherent in the use of computers and statistical software. Some include:

1. Many persons with very little or no statistical knowledge can manipulate data and come up with conclusions that often tend to be very spurious. The cliche ”Garbage In Garbage Out” could not apply better than in this situation.
2. Many commonly used software tend to be very reliable and accurate. With the large number of often user written statistical software freely available online one needs to be cautious of the output generated. Some of these could actually be wrongly written codes producing faulty results.
3. Unfortunately the most used, reliable and accurate statistical software tend to be expensive as well. This not withstanding there are few, such as R that combines free and open source with versatility and reliability. This forms the basis for my choice of R for this book.

##	Obtaining and installing R
R is a free software programming language and environment for data manipulation, calculation  and graphical display. It can run on Windows, MacOS X and Unix systems. It has great applications in many academic fields including mathematics, economics and epidemiology. This capability has been enhanced by the many packages written by individuals over the years. R has a great advantage of being able to handle many datasets simultaneously. However this functionality comes at a cost which would be discussed in the subsequent chapters. R also has great graphics functionality but requires practice to harness full use of this. 

Several advanced statistical and mathematical functionality such as regression
and survival analysis are also implemented in R.  

R and its many packages are obtainable free from <http://cran.r-project.org/>.
The most current version as at writing this book is R-3.2.1-win32.exe. The 
Windows version is installable on both the 32 and 64 bit operating systems. 
Download the base file from <https://cran.r-project.org/bin/windows/base/>, save on your computer and install (preferably as an administrator) by double clicking the executable file and following the on-screen instructions.

##	Running R
After installation, two shortcuts similar to the figure below are placed on the desktop (windows version). On a Windows 8 64 bit machine both shortcuts for the 32 and 64 bit versions are placed on the desktop. Double click the desktop icon to launch R. A welcome screen as shown below is displayed in the console launched.  

The > at the end of the output above is the command prompt and indicates R is 
ready to be used. The R Console before you at this stage if running for the 
first time will show a wide grey screen with a smaller white screen. The white 
screen is the referred to as the console. We can type straight and obtain 
requisite output on the console but I will strongly discourage this habit.


##	R as a calculator
The applicability of R in data analysis starts from its use as an overgrown 
calculator. In this section we learn this simple task. Calculations in R can be 
achieved simply by inputting and executing using the appropriate mathematical 
operational symbols. These are  

$+$ addition  
$∗$ multiplication  
$−$ substraction  
$/$ division  
$∧$ raised to power or exponent  

A couple of examples  

```r
7+8
[1] 15

(12-6)/7
[1] 0.8571429
```


##	Name assignment in R 
All objects in R can be assigned names, values or attributes. This assignment 
is achieved by using "->" or "<-". The example below assigns the values 5 to 
Kwame and 10 to Ama, their respective ages.


```r
Kwame <- 5
Ama <- 10
```

Calling these names yield the values (ages) assigned. We can do that by typing 
the names in the console.

```r
Kwame
[1] 5
Ama
[1] 10
```

To add the ages of Kwame and Ama we can just do

```r
Kwame + Ama
[1] 15
```

                 
