#단일집단 모평균 추론
set.seed(1)
n<-100;
x<-rnorm(n)
xbar<-mean(x)
se<-sd(x)/sqrt(n)
xbar
se
#(xbar-t_alpha_2_n_1*se, xbar+t_alpha_2_n_1*se)
?qt
t_alpha_2_n_1<-qt(0.05/2,df=n-1)
t_alpha_2_n_1
ci.x<-c(xbar-t_alpha_2_n_1*se, xbar+t_alpha_2_n_1*se)
ci.x

#compute mean
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
data<-read.csv("one_sample.csv",header=T)
data
dim(data)
head(data)
mean(data$time,na.rm=T)
x<-data$time
x1<-na.omit(x)
length(x)
length(x1)

# shapiro-wilk test(H0: X1,..,xn~Normal)
shapiro.test(x1)

#Histogram
hist(x1,freq=F,col="light blue",main="Histogram")
lines(density(x1),col="red")

##QQ plot
qqnorm(x1,pch=16,col="light blue")
qqline(x1,lty=1,col="red")

#y축: sort(x1) :1~109
#x축: F^-1(i/(n+1)) n=109 i=1,...,109
#c(F^-1(1/110),...,F^-1(109/110))

#양측 검정 (H0: mu=5.2 vs H1:mu!=5.2)
mean(x1)
res<-t.test(x1,mu=5.2,alter="two.sided",conf.level = 0.95)
res

#단측 검정 (H0: mu=5.2 vs H1: mu>5.2)
res<-t.test(x1,mu=5.2,alter="greater",conf.level = 0.95)
res


#대응표본의 평균 계산
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
data<-read.csv("paired_sample.csv")
head(data)
sum(is.na(data$before))
sum(is.na(data$after))
result<-na.omit(data)
dim(result)
mean(result$before)
mean(result$after)
x<-result$before
y<-result$after

#양측 검정 (H0:mu1=mu2, H1:mu1!=mu2)
t.test(x,y,paired=T,alter="two.sided",conf.level = 0.95)
?t.test #paired=FALSE임

#단측 검정 (H0:mu1=mu2,H1:mu1<mu2)
t.test(x,y,paired = T,alter="less",conf.level = 0.95)

# 두 집단 평균 계산
data<-read.csv("two_sample.csv")
dim(data)
head(data)
sum(is.na(data[,1]))
sum(is.na(data[,2]))
sum(is.na(data[,3]))
sum(is.na(data[,4]))
sum(is.na(data[,5]))

result<-na.omit(data)
dim(result)

head(result)
table(result$method)

a<-subset(result,method==1)$score
b<-subset(result,method==2)$score

mean(a)
mean(b)

#분산의 동질성 검정(H0: 두 개 그룹의 분산이 동일하다.)
var.test(a,b,alter="two.sided")

#양측 검정(H0:mu1=mu2,H1:mu1!=mu2)
t.test(a,b,alter="two.sided",conf.level = 0.95)

#단측 검정(H0:mu1=mu2,H1:mu1<mu2)
t.test(a,b,alter="less",conf.level = 0.95)

##분산 분석
data<-read.csv("three_sample.csv")
head(data)
sum(is.na(data[,1]))
sum(is.na(data[,2]))
sum(is.na(data[,3]))
sum(is.na(data[,4]))

result<-na.omit(data)
dim(result)
dim(data)
sort(result$score,decreasing=T)

plot(result$score)
data2<-subset(result,score<=13)
dim(data2)
boxplot(data2$score,col="light blue")

#그룹별 평균
head(data2)
data2$method2[data2$method==1]<-"M1"
data2$method2[data2$method==2]<-"M2"
data2$method2[data2$method==3]<-"M3"
x<-table(data2$method2)
y<-tapply(data2$score,data2$method2,mean)

library(dplyr)
data2%>%group_by(method2)%>%summarize(avg=mean(score))
library(plyr)
ddply(data2,.(method2),summarize,avg=mean(score))

#세집단 간 동질성 검정(H0:세집단 분포의 모양이 같다.)
bartlett.test(score~method2,data=data2)

#분산분석
res<-aov(score~method2,data=data2)
res
summary(res) #차이가 있다고 판단


