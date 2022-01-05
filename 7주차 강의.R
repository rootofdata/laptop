# (1) 더미 형식 파생 변수 생성

setwd("C:/Users/SEO/OneDrive - 숭실대학교 - Soongsil University/Desktop/R언어/전산통계1/part2")
user_data<-read.csv("user_data.csv")
head(user_data)
table(user_data$house_type)

user_data$house_type2<- ifelse(user_data$house_type==1| user_data$house_type==2, 0,1)
head(user_data)

# (2) 1대1 관계로 파생변수 생성
pay_data<-read.csv("pay_data.csv")
head(pay_data)

library(reshape2)
product_price<-dcast(pay_data,user_id~product_type,value.var="price",sum,na.rm=T)
head(product_price)
names(product_price)[-1]=c("식료품(1)","생필품(2)","의류(3)","잡화(4)","기타(5)")

head(product_price)

pay_price <- dcast(pay_data,user_id~pay_method,value.var ="price" , length)
head(pay_price)

#(3)파생변수 합치기
library(plyr)
head(user_data)
user_pay_data<-join(user_data,product_price,by="user_id")
head(user_pay_data)
user_pay_data<-join(user_pay_data,pay_price,by="user_id")
head(user_pay_data)

#(4) 변형된 데이터 저장
write.csv(user_pay_data,"CleanData.csv",quote=F,row.names = F)
data<-read.csv("CleanData.csv")
head(data)

#결측치 처리
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part2")
dataset<-read.csv("dataset.csv")
head(dataset)
dim(dataset)
dataset$resident<-as.factor(dataset$resident)
table(dataset$resident,exclude=NULL)
summary(dataset$resident)
summary(dataset$price)

#결측치 제거
price2<-na.omit(dataset$price)
summary(price2)
length(dataset$price)
length(price2)

class(dataset)
dataset.new<-na.omit(dataset)
dim(dataset)
dim(dataset.new)
sum(is.na(dataset))
sum(is.na(dataset.new))

#NA를 0이나 평균으로 대체
x<-dataset$price
x
sum(is.na(x))
head(dataset)
dataset$price2<-ifelse(!is.na(x),x,0)
head(dataset)
sum(is.na(dataset$price2))
dataset$price3<-ifelse(!is.na(x),x,round(mean(x,na.rm=T),2)) #ceiling :,floor: 올림내림
head(dataset,10)

#저장하기
write.csv(dataset,"dataset_new.csv",quote=F,row.names = F)
getwd()
