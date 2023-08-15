#------------------------------------------------------------
#     Function for looking at a continuous variable
#     Author: Dr Samuel Blay Nguah
#     Date:   13-02-2014
#--------------------------------------------------------------
Inspect<-function(X)(
		if(class(X)=="numeric" | class(X)=="integer")
			{
			a<-X[order(X)]
			b<-1:length(X)			
			opar<-par(mfrow=c(2,2), fg="red", family="mono")
			boxplot(X, pch=19, main=paste("Boxplot of", deparse(substitute(X))), ylab=deparse(substitute(X)))
			hist(X, main=paste("Histogram of", deparse(substitute(X))), xlab=deparse(substitute(X)))
			plot(a,b, pch=20, main=paste("Sorted dotchart of", deparse(substitute(X))), xlab=deparse(substitute(X)), ylab="")
			qqnorm(X)
			qqline(X, col=1)
			par(opar)
			Mean<-mean(X, na.rm=T)
			Median<-median(X, na.rm=T)
			SD<-sd(X, na.rm=T)
			Unique<-length(unique(X))
			N<-length(X)
			Miss.<-length(X[is.na(X)])
			Min.<-min(X, na.rm=T)
			Q1<-quantile(X, prob=.25, na.rm=T)
			Q3<-quantile(X, prob=.75, na.rm=T)
			Max.<-max(X, na.rm=T)
			temp<-list()
			X1<-c(N=N, Miss=Miss., Unique=Unique, Mean=Mean, SD=SD) 
			temp[["Summaries"]]<-X1
			rownames(temp[[1]])<-NULL
			temp[["Quantiles"]]<-quantile(X, na.rm=TRUE, prob=c(0, 0.025, .25, .5, .75, 0.975, 1))
			return(temp)
			}
		)
   
