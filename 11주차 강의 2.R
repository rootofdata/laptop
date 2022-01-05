#단일 집단 모비율 추론
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
data<-read.csv("one_sample.csv")
data
sum(is.na(data$survey))
table(data$survey) #0: 불만족 (14), 1:만족(136)
sum(data$survey)/length(data$survey)

#양측 검정(H0: p=0.8 vs H1: p!=0.8)
x<-data$survey
binom.test(136,150,p=0.8)
binom.test(136,150,p=0.8,alternative = "two.sided",conf.level = 0.95) #위와 같음
binom.test(c(136,14),p=0.8)
#X~Bin(150,0.8)
pbinom(135,150,0.8,lower.tail = F)*2 #136에서 하나 뺀 값을 넣어야함

#단측 검정(H0:p=0.8 vs H1:p>0.8)
binom.test(136,150,p=0.8,alternative = "greater",conf.level = 0.95)
pbinom(135,150,0.8,lower.tail = F)

#두 집단 비율 추론
data<-read.csv("two_sample.csv")
head(data)
x<-data$method
y<-data$survey
table(x,y)

#양측 검정(H0:p1=p2 vs H1:p1!=p2)
prop.test(c(110,135),c(150,150),alternative = "two.sided",conf.level = 0.95) #c(150,150)은 합을 나타냄/

#단측 검정(H0:p1=p2 vs H1: p1<p2)
prop.test(c(110,135),c(150,150),alternative = "less",conf.level = 0.95)

#세집단 비율 추론
data<-read.csv("three_sample.csv")
head(data)
x<-data$method
y<-data$survey
table(x,y)

#세집단 비율 차이 검정 (H0: p1=p2=p3,H1: not H0)
prop.test(c(34,37,39),c(50,50,50),alternative = "two.sided",conf.level = 0.95)

#적합도 검정
x<-data.frame(matrix(c(1,2,3,4,5,41,30,51,71,61),ncol=2))
names(x)<-c("prop","freq")
x
x$prop<-x$freq/sum(x$freq)
x

#H0:p1=p2=p3=p4=p5=0.2 vs H1:not H0
chisq.test(x$freq)
?chisq.test

#H0:p1~p5=c(0.2,0.1,0.2,0.3,0.2) vs H1: not H0
chisq.test(x$freq,p=c(0.2,0.1,0.2,0.3,0.2))

#독립성 검정 (Independence Test)
install.packages("gmodels")
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
library(gmodels)

data<-read.csv("cleanDescriptive.csv")
head(data)
dim(data)
x<-data$level2 #부모의 학력 수준
y<-data$pass2 #자녀의 대학진학여부

table(x)
table(y)
#H: 부모의 학력수준과 대학진학여부는 관련성이 없다.
chisq.test(x,y)
?chisq.test
CrossTable(x,y,chisq=T)
225*(90/225)*(89/225)
(40-35.6)^2/35.6

#동질성 검정
data<-read.csv("homogenity.csv",header=T)
head(data)
dim(data)

CrossTable(data$method,data$survey,chisq=T)
chisq.test(data$method,data$survey)

#Chisq test
tab1 = table(data$level2, data$pass2) #독립성 검정
tab1 = table(data$method, data$survey) #동질성 검정

compute.chisq = function(tab) {
  r = nrow(tab)
  c = ncol(tab)
  tab = cbind(tab,apply(tab,1,sum))
  tab = rbind(tab,apply(tab,2,sum))
  chi = 0
  for (i in 1:r) {
    for (j in 1:c) {
      eij = tab[r+1,c+1]*tab[i,j]/tab[r+1,j]*tab[i,j]/tab[i,c+1]
      chi = chi + (tab[i,j]-eij)^2/eij
    }
  }
  list(chi,pchisq(chi,df=(r-1)*(c-1),lower.tail=F))
}
compute.chisq(tab1)
