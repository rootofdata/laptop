# 그룹별 기술 통계량 구하기
head(iris)
#apply, lapply, sapply
tapply(iris$Sepal.Length,iris$Species,mean)
table(iris$Sepal.Length,iris$Specie)
tapply(iris$Sepal.Length,iris$Specie,sd) #factor가 뒤에 나와야댐

install.packages("plyr")
library(plyr)
summarise(iris,avg=mean(Sepal.Length),std=sd(Sepal.Length))
avg_df<-ddply(iris,.(Species),summarise,
              avg=round(mean(Sepal.Length),2),std=round(sd(Sepal.Length),2),
              min=min(Sepal.Length),max=max(Sepal.Length)) #Species로 나뉘어 계산하게 됨
avg_df

#merge
x<-data.frame(id=c(1,2,3,4,6),height=c(160,171,173,162,180))
y<-data.frame(id=c(5,4,1,3,2),weight=c(55,73,60,57,80))
merge(x,y,by="id")  #intersect(x,y)    #merge는 해당 되는 것만 합침
merge(x,y,by="id",all.x=T) #x
merge(x,y,by="id",all.y=T) #y
merge(x,y,by="id",all=T) #union(x,y)

join(x,y,by="id") #join 은 다 합침
join(x,y,by="id",type="left") #x
join(x,y,by="id",type="right") #y
join(x,y,by="id",type="inner") #intersect(x,y)
join(x,y,by="id",type="full") #union(x,y)

#merge data by two keys
x<-data.frame(key1=c(1,1,2,2,3),key2=c('a','b','c','d','e'),
              val1=c(10,20,30,40,50))
x
y<-data.frame(key1=c(3,2,2,1,1),key2=c('e','d','c','b','a'),
              val1=c(500,400,300,200,100))
y
xy1<-merge(x,y,by="key1")
xy2<-merge(x,y,by="key2")
xy2
xy12<-merge(x,y,by=c("key1","key2"))
xy12
xy12<-join(x,y,by=c("key1","key2"))
xy12

##6주차 2차시
install.packages("dplyr")
install.packages("hflights")

library(dplyr)
library(hflights)

str(hflights)

class(hflights)
hflights_df<-tbl_df(hflights)
class(hflights_df)

head(hflights_df)

#조건에 맞는 데이터 필터링
filter(hflights_df,Month==1&DayofMonth==2) #1월 2일에 관련된 것 
table(filter(hflights_df,Month==2| Month==4)$Month)
table(filter(hflights_df,Month>=7 & Month<9)$Month)

#컬럼으로 데이터 정렬
arrange(hflights_df,Year,Month,DayofMonth) #오름차순으로 정렬렬
arrange(hflights_df, Year, Month, desc(DayofMonth))

# 컬럼으로 데이터 검색
select(hflights_df,Year,Month,DepTime,ArrTime)
select(hflights_df,Year:ArrTime)
select(hflights_df,-(Year:DayOfWeek))
select(hflights_df,1:3)

#데이터 셋에 컬럼 추가
select(mutate(hflights_df,gain=ArrDelay-DepDelay, gain_per_hour=gain/(AirTime/60)),
       Year,Month,DayofMonth,gain,gain_per_hour)

#요약 통계량 계산
summarise(hflights_df,avgAirTime=mean(AirTime,na.rm=T),
          arrTimeVar=var(AirTime,na.rm=T))

#질적 변수 대상 그룹화
group_by(hflights_df,Month)

#파이프 사용법
hflights_df %>% group_by(Month) %>% summarise(AvgAirTime=mean(AirTime,na.rm=T))

#reshape2 패키지
install.packages("reshape2")
library(reshape2)

# Long format을 Wide format으로 변경
setwd("C:/Users/SEO/OneDrive - 숭실대학교 - Soongsil University/Desktop/R언어/전산통계1/part2")
data<-read.csv("data.csv")
head(data)
dim(data)

#dcast(data.frame,행구성변수~열구성변수,value.var="측정변수",function)
wide <-dcast(data,Customer_ID~Date,value.var = "Buy",sum)
wide

#Wide format을 Long format으로 변경
#melt(data.frame,id="기준 column")
long<-melt(wide,id="Customer_ID")
long
names(long)[-1]=c("Date","Buy")
head(long)

data("smiths")
smiths

long<-melt(smiths,id=c("subject","time"))
long
dcast(long, subject+time~ variable,value.var = "value")

#3차원 배열 형식으로 변경
data("airquality")
head(airquality)
str(airquality)

air_melt<-melt(airquality,id=c("Month","Day"))
air_melt

acast<-acast(air_melt,Day~Month~variable)
acast
class(acast)

