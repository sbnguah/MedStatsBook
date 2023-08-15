rm(list=ls(all=T))
setwd("C:\\STI")
mydata1<-read.table("data1.txt", header=TRUE, sep="\t")
head(x=mydata1, n=4)
mydata2<-read.table("visits.txt", header=TRUE, sep=",")
head(x=mydata2, n=4)
mydata3<-read.csv("data1.csv")
head(x=mydata3, n=4)
mydata4<-read.delim("data1.txt")
head(x=mydata4, n=4)
#--------------------
load(file="data1.Rdata")
ls()
head(data1_stata, n=4)
save(mydata1, file="mydata1_export.Rdata")
dir(pattern=".Rdata")
#---------------------
dput(x=mydata1, file="mydata1_dput.txt")
dir(pattern=".txt")
rm(list=ls(all=T))
ls()
dput_data<-dget(file="mydata1_dput.txt")
ls()
head(x=dput_data, n=4)

#-------------------------------------
rm(list=ls(all=T))
ls()
ft1<-read.ftable("ftable1.txt")
ft1

agg.df<-as.data.frame(ft1)
head(x=agg.df, n=5)

rm(list=ls())
df<-read.table("ft_data1.txt", header=TRUE)
head(df, n=10)

ftable1<-ftable(df)
ftable1

#---------------------------------------------------
rm(list=ls(all=T))
library(readxl)
df1 <- read_excel("data1.xlsx", sheet=1)
head(df1, n=4)
df2 <- read_excel("data1.xls", sheet=1)
head(x=df2, n=4)
#---------------------------------------------
library(RODBC)
rm(list=ls())
con2<-odbcConnectAccess2007("Data1_access.accdb")
data1.acc<-sqlFetch(con2, "data1")
head(x=data1.acc, n=4)
femacc<-data1.acc[data1.acc$sex=="Female",]
# sqlSave(con2,femacc,tablename = "Females", rownames=F)
odbcCloseAll()
str(data1.acc)
#--------------------------------------------------
library(sas7bdat)
df_sas<-read.sas7bdat("whas500.sas7bdat")




# source("C:\\STI\\STI_read_write_cmds_15082015.R", echo=T)


