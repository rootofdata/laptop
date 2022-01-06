##############################8주차 강의##############################################
#########################아홉번째 강의자료############################################
#Visualization Analysis
#ggplot2 package 고급 시각화
#특징 - data 객체와 graphic 객체를 서로 분리하고 재사용 가능
#qplot() ==> geometric objects에 미적 요소를 mapping 하여 plotting  
#ggplot()==> aesthetic 요소 mapping에 layer 관련 함수를 추가하여 plotting ,+연산자로 연결
#ggsave()==> 해상도를 적용하여 다양한 형식의 image file 저장

#install.packages("ggplot2")
library(ggplot2)
data(mpg)
head(mpg)
str(mpg)
?mpg #연비 효율에 대한 데이터

table(mpg$drv) #drive train의 타입
summary(mpg$hwy) #highway miles per galleon
plot(mpg$hwy)  #산점도
hist(mpg$hwy) #막대그래프

qplot(hwy,data=mpg,fill="light blue") #fill : 색채우기 -> 없으면 검은색으로 나옴
qplot(hwy,data=mpg,fill=I("light blue"),col=I("black")) #I= 변수로 해석하지 말아라. I안하면 빨간색나옴.
qplot(hwy,data=mpg,fill=drv,col=I("black"),binwidth=2,facets=.~drv) #열 단위 패널 생성 
qplot(hwy,data=mpg,fill=drv,col=I("black"),binwidth=2,facets=drv~.) #행 단위 패널 생성
qplot(hwy,data=mpg,fill=drv,col=I("black"),binwidth=2,facets=drv~cyl) #그리드 형태의 패널 생성
#fill: 색채우기 ->없으면 검은색 , fill=I() : I 가 있어야 변수로 해석하지 않는다.
#binwidth : bin(막대)의 넓이,크기 지정. facets=쪼개는 것(drv에 따라 쪼개는것(열)(drv~. => 행에 따라 나눈다.))

#diamonds 데이터
head(diamonds)
?diamonds #price of over 50,000 round cut diamonds (다이아몬드 정보)
table(diamonds$clarity) #얼마나 깨끗한가에 대한 측정 
table(diamonds$cut) #커팅 질

qplot(clarity,data=diamonds,fill=cut,geom="bar") #cut에 따라 나옴
qplot(clarity,data=diamonds,color=cut,geom="bar") #테두리 색 적용

#변수가 2개인 경우 -> 산점도(scatter plot)
summary(mpg$displ) #연속형
table(mpg$displ) #이산형
?mpg #차 정보
qplot(displ,hwy,data=mpg) #displ : 엔진크기 vs hwy
qplot(displ,hwy,data=mpg,color=drv,facets=drv~.)

#mtcars
head(mtcars)
table(mtcars$carb) #이산형
summary(mtcars$qsec) #연속형
qplot(wt,mpg,data=mtcars,color=factor(carb),size=qsec,shape=factor(cyl)) # 반비례 관계가 있음을 볼 수 있다.
# color=factor() : 색상 적용, size:크기 적용,shape :모양 적용
qplot(wt,mpg,data=mtcars,geom="point") #default 값 : point다.
qplot(wt,mpg,data=mtcars,geom="smooth") #method="lowess
qplot(wt,mpg,data=mtcars,geom=c("line","point"),color=factor(cyl)) #geom을 둘로 지정해서 같이 나오게끔. 

##############################9주차 강의##############################################

#ggplot function
#(1) setup
library(ggplot2)
head(diamonds)
dim(diamonds)
g<-ggplot(diamonds)
class(g) #"gg" "ggplot"
ggplot(diamonds,aes(x=carat,y=price,color=cut))  #도화지만 그려놓는 작업

#(2)Layers
g1<-ggplot(diamonds,aes(x=carat,y=price,color=cut))+
  geom_point()+geom_smooth();g1
ggplot(diamonds)+geom_point(aes(x=carat,y=price,color=cut))+
  geom_smooth(aes(x=carat,y=price)) #g1과 같은 꼴

g2<-ggplot(diamonds,aes(x=carat,y=price))+
  geom_point(aes(color=cut,shape=cut))+geom_smooth() #g1과 다른 점은 shape..?
g2
#(3)Labels
g3<-g1+labs(title="scatter plot",x="catat",y="price") #*labs()함수, 변수 title: 제목
print(g3)

#(4) Theme
g4<-g3+theme(plot.title=element_text(size=20,face="bold"),
             axis.text.x=element_text(size=15),
             axis.text.y=element_text(size=20),
             axis.title.x=element_text(size=25),
             axis.title.y=element_text(size=15)) +
  scale_color_discrete(name="cut of diamonds")
print(g4)  #theme() 함수 : label 크기 조정 : axis.text.x=element_text()
                           #각 title 조정 : axis.title.x=element_text(),
                           #title 조정 : plot.title = element_text()

#scale_color_discrete #이산형
#scale_color_continuous #연속형 #데이터 성격에 따라 달라진다. 
#scale_shape_discrete 
#scale_shape_continuous #차이 존재

#(5)Facets
g5<-g3+facet_wrap(color~cut,ncol=3) #facet_wrap() : row:color ,column :cut
print(g5)
g6<-g3+facet_grid(color~cut) #facet_grid() : grid 형태
print(g6)

#(6) box plot
library(datasets)
data("airquality")
dim(airquality)
str(airquality)
airquality$Month<-factor(airquality$Month)

pp1<-ggplot(airquality,aes(x=Month,y=Ozone))+
  geom_boxplot(fill="red",color="blue")
pp1

pp2<-pp1+scale_x_discrete(name="month")+
  scale_y_continuous(name="mean ozone in \nparts per billion",
                     breaks=seq(0,175,25),limits=c(0,180))+
  theme_bw() #theme_bw() : 백그라운드를 하얗게 하기.
pp2
pp2+ggtitle("boxplot of mean ozone by month") #ggtitle() :제목 달기.

#bonus 부분 (복붙 한 부분)
bmiukb <- data.frame(
  method = factor(c("PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR",
                    "Lasso+CTPR","PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR","Lasso+CTPR"),levels=c("PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR","Lasso+CTPR")),
  cohort=factor(c("NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS",
                  "NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank"),levels=c("NHS/HPFS/PHS","UKBiobank")),
  pred = c(0.1427,0.14123,0.2217,0.2225,0.2609,0.2796,0.2922,0.2978,
           0.2232,0.2220,0.3653,0.3583,0.3775,0.3908,0.4247,0.4284)*100,
  se = c(0.000983528,0.0009826683,0.001116853,0.001109679,
         0.001144894,0.001150417,0.001157279,0.001158628,
         0.0010686,0.001068152,0.001160714,0.001162218,
         0.001154691,0.001150587,0.001133377,0.001132073)*100
)
bmiukb
ggplot(data=bmiukb, aes(x=cohort, y=pred, fill=method)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")+ theme_bw() + 
  geom_errorbar(aes(ymin=pred-se, ymax=pred+se),width=.2,position=position_dodge(.9), colour="#606060") +
  xlab("Validation Dataset") + 
  ylab(quote(paste("Prediction ",R^2,"(%)"))) +
  labs(fill="", colour="", linetype="", title="HGT-BMI (N=436,898)") + 
  scale_fill_manual(values=c("#F3898B","#FF6666","#F9A825","#EF6C00","#42A5F5","#1976D2", "#5C6BC0","#283593")) + 
  theme(plot.title = element_text(lineheight=.8, size=16), axis.text=element_text(size=14),
        axis.title=element_text(size=14),legend.text=element_text(size=12), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
#panel부분 element_blank()

#가장 최근 그래프 저장하기.
ggsave(file="bmi.pdf",width=7.5,height=7.5)
ggsave(file="bmi.jpg",dpi=200) #저장하기
getwd()

#########################열번째 강의자료############################################
#install packages
#install.packages("DBI")
#install.packages("rJAVA")
#install.packages("RJDBC")
library("DBI")
#C:\Program Files\Java\jre1.8.0_301
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_301")
library(rJava)
library(RJDBC)

#mysql-connector-java-8.0.27 (connector from R to MariaDB)
drv<-JDBC(driverClass = "com.mysql.cj.jdbc.Driver",
          classPath = "C:/Temp/Program/mysql-connector-java-8.0.27.jar")
conn<-dbConnect(drv,"jdbc:mysql://127.0.0.1:3306/work?serverTimezone=UTC",
                "scott","tiger")

#RDMBS (Relational Database Management System)
#MySQL ,MariaDB,Oracle,MS-SQL 
#강의에서는 MariaDB를 사용
#아래는 maria DB MySQL 사용
# Enter password: ****
#   Welcome to the MariaDB monitor.  Commands end with ; or \g.
# Your MariaDB connection id is 4
# Server version: 10.6.4-MariaDB mariadb.org binary distribution
# 
# Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
# 
# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
# 
# MariaDB [(none)]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   +--------------------+
#   4 rows in set (0.009 sec)
# 
# MariaDB [(none)]> create database work;
# Query OK, 1 row affected (0.002 sec)
# 
# MariaDB [(none)]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [(none)]> use work;
# Database changed
# MariaDB [work]> show tables;
# Empty set (0.001 sec)
# 
# MariaDB [work]> create table goods(
#   -> code int primary key,
#   -> name varchar(20) not null,
#   -> su int,
#   -> dan int);
# Query OK, 0 rows affected (0.018 sec)
# 
# MariaDB [work]> show tables
# -> ;
# +----------------+
#   | Tables_in_work |
#   +----------------+
#   | goods          |
#   +----------------+
#   1 row in set (0.001 sec)
# 
# MariaDB [work]> insert into goods values(1,'냉장고',2,850000);
# Query OK, 1 row affected (0.010 sec)
# 
# MariaDB [work]> insert into goods values(2,'세탁기',3,550000);
# Query OK, 1 row affected (0.002 sec)
# 
# MariaDB [work]> insert into goods values(3,'전자레인지',2,350000);
# Query OK, 1 row affected (0.001 sec)
# 
# MariaDB [work]> insert into goods values(3,'HDTV',3,150000);
# ERROR 1062 (23000): Duplicate entry '3' for key 'PRIMARY'
# MariaDB [work]> insert into goods values(4,'HDTV',3,1500000);
# Query OK, 1 row affected (0.001 sec)
# 
# MariaDB [work]> select * from goods;
# +------+------------+------+---------+
#   | code | name       | su   | dan     |
#   +------+------------+------+---------+
#   |    1 | 냉장고     |    2 |  850000 |
#   |    2 | 세탁기     |    3 |  550000 |
#   |    3 | 전자레인지 |    2 |  350000 |
#   |    4 | HDTV       |    3 | 1500000 |
#   +------+------------+------+---------+
#   4 rows in set (0.001 sec)
# 
# MariaDB [work]> create user 'scott'@'localhost'identified by 'tiger'
# -> ;
# Query OK, 0 rows affected (0.005 sec)
# 
# MariaDB [work]> select Host,User,Password from mysql.user;
# +-----------------+-------------+-------------------------------------------+
#   | Host            | User        | Password                                  |
#   +-----------------+-------------+-------------------------------------------+
#   | localhost       | mariadb.sys |                                           |
#   | localhost       | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | desktop-ro4riae | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | 127.0.0.1       | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | ::1             | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | %               | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | localhost       | scott       | *F2F68D0BB27A773C1D944270E5FAFED515A3FA40 |
#   +-----------------+-------------+-------------------------------------------+
#   7 rows in set (0.010 sec)
# 
# MariaDB [work]> grant all privileges on work.* to 'scott'@'localhost';
# Query OK, 0 rows affected (0.001 sec)
# #########################################################################33
# MariaDB [work]> flush privileges;
# Query OK, 0 rows affected (0.001 sec)
# 
# MariaDB [work]> show tables;
# +----------------+
#   | Tables_in_work |
#   +----------------+
#   | goods          |
#   | goods1         |
#   | goods_new      |
#   | goods_original |
#   +----------------+
#   4 rows in set (0.003 sec)
# 
# MariaDB [work]> select * from goods_new
# -> ;
# +------+-------------+------+---------+
#   | code | name        | su   | dan     |
#   +------+-------------+------+---------+
#   |    1 | 냉장고      |    2 |  850000 |
#   |    2 | 세탁기      |    3 |  550000 |
#   |    3 | 전자레인지  |    2 |  350000 |
#   |    4 | HDTV        |    2 | 1500000 |
#   |    5 | 식기세척기  |    1 |  250000 |
#   +------+-------------+------+---------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [work]> drop table goods;
# Query OK, 0 rows affected (0.012 sec)
# 
# MariaDB [work]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [work]> yse sys;
# ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'yse sys' at line 1
# MariaDB [work]> use sys;
# Database changed
# MariaDB [sys]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [sys]> drop database work;
# Query OK, 3 rows affected (0.037 sec)
# 
# MariaDB [sys]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   +--------------------+
#   4 rows in set (0.001 sec)
# 
# MariaDB [sys]>quit;
#   bye
############# maria DB 사용###############

# select 문장
dbGetQuery(conn,"select*from goods")
dbGetQuery(conn,"select code,name from goods where code=1 or code=2")

#create/ alter 문장
dbSendUpdate(conn,"create table goods1 as select *from goods")
dbSendUpdate(conn,"alter table goods1 rename to goods_original")
dbGetQuery(conn,"select * from goods_original")

#insert, update, delete 문장
dbSendUpdate(conn,"insert into goods values(5,'식기세척기',1,25000)")
dbSendUpdate(conn,"insert into goods values(6,'테스트',1,1000)")
dbGetQuery(conn,"select*from goods")
dbSendUpdate(conn,"update goods set name='테스트',where code=6")
dbSendUpdate(conn,"update goods set su=3 where code=6")
dbSendUpdate(conn,"delete from goods where code=6")

#inner/ outer/ left/ right join
dbGetQuery(conn,"select*from goods_original inner join goods on goods_original.code=goods.code")

#write table
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part2")
recode<-read.csv("recode.csv")
recode
class(recode)
dbWriteTable(conn,"goods_new",recode)
dbGetQuery(conn,"select * from goods_new")

#disconnect
dbDisconnect(conn)

##############################10주차 강의##############################################
#########################열한번째 강의자료############################################
#단일집단 모평균 추론
set.seed(1)
n<-100
x<-rnorm(n)
xbar<-mean(x)
se<-sd(x)/sqrt(n)
xbar
se
#(xbar-t_alpha_2_n_1*se,xbar+t_alpha_2_n_1*se)
t_alpha_2_n_1<-qt(0.05/2,df=n-1)*(-1)
t_alpha_2_n_1
ci.x<-c(xbar-t_alpha_2_n_1*se,xbar+t_alpha_2_n_1*se)
ci.x #신뢰구간

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
shapiro.test(x1) #정규분포 검정 함수

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
dim(data)
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
length(a)
length(b)
mean(a)
mean(b)

#분산의 동질성 검정(H0: 두 개 그룹의 분산이 동일하다.)
var.test(a,b,alter="two.sided")

#양측 검정(H0:mu1=mu2,H1:mu1!=mu2)
t.test(a,b,alter="two.sided",conf.level = 0.95)
?t.test
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
plot(data2$score)
dim(data2)
boxplot(data2$score,col="light blue")

#그룹별 평균
head(data2)
data2$method2[data2$method==1]<-"M1"
data2$method2[data2$method==2]<-"M2"
data2$method2[data2$method==3]<-"M3"
x<-table(data2$method2)
y<-tapply(data2$score,data2$method2,mean)
x
y
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
##############################11주차 강의##############################################
#단일 집단 모비율 추론
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
data<-read.csv("one_sample.csv")
head(data)
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
mean(x$prop)
#H0:p1=p2=p3=p4=p5=0.2 vs H1:not H0
chisq.test(x$freq)
?chisq.test

#H0:p1~p5=c(0.2,0.1,0.2,0.3,0.2) vs H1: not H0
chisq.test(x$freq,p=c(0.2,0.1,0.2,0.3,0.2))

#독립성 검정 (Independence Test)
#install.packages("gmodels")
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part3")
library(gmodels)

data<-read.csv("cleanDescriptive.csv")
head(data)
dim(data)
x<-data$level2 #부모의 학력 수준
y<-data$pass2 #자녀의 대학진학여부

table(x)
table(y)
#H0: 부모의 학력수준과 대학진학여부는 관련성이 없다.
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
tab1
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
##############################열세번째 자료##############################################
########################################
## 텍스트 마이닝 분석 
########################################

###############
# 1. 토픽 분석  
###############

# 텍스트마이닝을 위한 패키지 설치 

# 토픽 분석을 위한 패키지 설치
# install.packages("rJava")
#install.packages(c("KoNLP", "wordcloud"))
# tm 패키지 구 버전 다운로드/설치 - version 3.3.2
# install.packages("http://cran.r-project.org/bin/windows/contrib/3.0/tm_0.5-10.zip",repos=NULL)
# install.packages('slam')
# install.packages('Sejong')
# install.packages('hash')
# install.packages('tau')
# install.packages('devtools')

#setwd(readClipboard())
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part2")
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_301")

# 패키지 로딩
library(rJava) 
library(slam) 
library(RSQLite)
library(httr)
library(XML)
library(KoNLP) # 세종사전 
library(tm) # 영문 텍스트 마이닝 
library(wordcloud) # RColorBrewer()함수 제공

# 명사 추출 예 
extractNoun('안녕하세요. 홍길동 입니다.')

# (1) 텍스트 자료 가져오기 
facebook <- file("facebook_bigdata.txt", encoding="UTF-8")
facebook_data <- readLines(facebook) # 줄 단위 데이터 생성
head(facebook_data) # 앞부분 6줄 보기 - 줄 단위 문장 확인 
str(facebook_data) # chr [1:76]

# (2) 자료집(Corpus) 생성 
facebook_corpus <- Corpus(VectorSource(facebook_data))
facebook_corpus 
inspect(facebook_corpus) # 76개 자료집에 포함된 문자 수 제공 


# (3)단어 추가와 단어추출 
# 세종 사전에 없는 단어 추가
#install.packages('curl')
library(curl)
useSejongDic() # 세종 사전 불러오기
mergeUserDic(data.frame(c("R 프로그래밍","페이스북","소셜네트워크"), c("ncn"))) 
# ncn -명사지시코드

# (4) 단어추출 사용자 함수 정의 
# 사용자 정의 함수 작성 
exNouns <- function(x) { paste(extractNoun(as.character(x)), collapse=" ")}
# exNouns 함수 이용 단어 추출 
facebook_nouns <- sapply(facebook_corpus, exNouns) 
facebook_nouns[1] # 단어만 추출된 첫 줄 보기 

# (5) 추출된 단어 대상 전처리
# 추출된 단어 이용 자료집 생성
myCorputfacebook <- Corpus(VectorSource(facebook_nouns)) 
myCorputfacebook 

# 데이터 전처리 
myCorputfacebook <- tm_map(myCorputfacebook, removePunctuation) # 문장부호 제거
myCorputfacebook <- tm_map(myCorputfacebook, removeNumbers) # 수치 제거
myCorputfacebook <- tm_map(myCorputfacebook, tolower) # 소문자 변경
myStopwords = c(stopwords('english'), "사용", "하기")
myCorputfacebook <-tm_map(myCorputfacebook, removeWords, myStopwords) # 불용어제거
inspect( myCorputfacebook[1:5])

# (6) 단어 선별(단어 길이 2개 이상)
# 단어길이 2개 이상인 단어만 선별하여 matrix 자료구조로 변경
myCorputfacebook_term <- TermDocumentMatrix(myCorputfacebook, control=list(wordLengths=c(2,Inf)))

# matrix 자료구조를 data.frame 자료구조로 변경
myTermfacebook.df <- as.data.frame(as.matrix(myCorputfacebook_term)) 
dim(myTermfacebook.df) 

# (7) 단어 빈도수 구하기 - 빈도수가 높은 순서대로 내림차순 정렬
wordResult <- sort(rowSums(myTermfacebook.df), decreasing=TRUE) # 빈도수로 내림차순 정렬
wordResult[1:10]

# (8) 단어 구름(wordcloud) 생성 - 디자인 적용 전
myName <- names(wordResult) # 단어 이름 생성 -> 빈도수의 이름 
wordcloud(myName, wordResult) # 단어구름 적성


# (9) 단어 구름에 디자인 적용(빈도수, 색상, 위치, 회전 등) 
# 단어이름과 빈도수로 data.frame 생성
word.df <- data.frame(word=myName, freq=wordResult) 
str(word.df) # word, freq 변수

# 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3
# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성 적용 
#x11( ) # 별도의 창을 띄우는 함수
wordcloud(word.df$word, word.df$freq, 
          scale=c(5,1), min.freq=3, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")


#################
## 2 연관어 분석 
#################

# 한글 처리를 위한 패키지 설치
#install.packages('rJava')
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_151')
#library(rJava) # 아래와 같은 Error 발생 시 Sys.setenv()함수로 java 경로 지정
#install.packages("KoNLP") 
#library(KoNLP) # rJava 라이브러리가 필요함


# (1) 텍스트 파일 가져오기 ('빅데이터'키워드로 페이스북에서 검색한 결과파일일)
marketing <- file("marketing.txt", encoding="UTF-8")
marketing2 <- readLines(marketing) # 줄 단위 데이터 생성
# incomplete final line found on - Error 발생 시 UTF-8 인코딩 방식으로 재 저장
close(marketing) 


# (2) 줄 단위 단어 추출
lword <- Map(extractNoun, marketing2)  
length(lword) # [1] key = 472

lword <- unique(lword) # 중복제거1(전체 대상)
length(lword) # [1] 353 (19개 제거)

# (3) 중복단어 제거와 추출 단어 확인
lword <- sapply(lword, unique) # 중복제거2 (줄 단위 대상) 
length(lword) # [1] 353


# (4) 연관어 분석을 위한 전처리 

# 단어 필터링 함수 정의 (길이 2~4사이 한글 단어 추출)
filter1 <- function(x){
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}

filter2 <- function(x){
  Filter(filter1, x)
}

# 줄 단위로 추출된 단어 전처리 
lword <- sapply(lword, filter2)
lword

# (5) 트랜잭션 생성
#update.packages(checkBuilt=TRUE, ask=FALSE)
warning()
# 연관분석을 위한 패키지 설치
#install.packages("arules")
library(arules) 

# 트랜잭션 생성 
wordtran <- as(lword, "transactions") # lword에 중복데이터가 있으면 error발생
wordtran 

# (6) 단어 간 연관규칙 산출 
# default (support지지도=0.1, confidence신뢰도=0.8, maxlen최대길이=10)
# 지지도와 신뢰도를 높이면 발견되는 규칙수가 줄어듦
tranrules <- apriori(wordtran, parameter=list(supp=0.25, conf=0.05)) 
tranrules <- apriori(wordtran, parameter=list(supp=0.25, conf=0.8)) 
tranrules <- apriori(wordtran, parameter=list(supp=0.3, conf=0.05)) 

# 연관규칙 생성 결과보기 
inspect(tranrules) # 연관규칙 생성 결과(59개) 보기

# (7)  연관어 시각화 

# 연관단어 시각화를 위해서 자료구조 변경
rules <- labels(tranrules, ruleSep=" ")  
rules
class(rules)

# 문자열로 묶인 연관단어를 행렬구조 변경 
rules <- sapply(rules, strsplit, " ",  USE.NAMES=F) 
rules
class(rules) 

# 행 단위로 묶어서 matrix로 반환
rulemat <- do.call("rbind", rules)
rulemat
class(rulemat)

# 연관어 시각화를 위한 igraph 패키지 설치
#install.packages("igraph") # graph.edgelist(), plot.igraph(), closeness() 함수 제공
library(igraph)   

# edgelist보기 - 연관단어를 정점 형태의 목록 제공 
ruleg <- graph.edgelist(rulemat[c(12:59),], directed=F) # [1,]~[11,] "{}" 제외
ruleg

#  edgelist 시각화
#X11()
plot.igraph(ruleg, vertex.label=V(ruleg)$name,
            vertex.label.cex=1.2, vertex.label.color='black', 
            vertex.size=20, vertex.color='green', vertex.frame.color='blue')

#############################
# 3. 실시간 뉴스 수집과 분석
#############################

# 텍스트마이닝을 위한 패키지 설치 
# install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip")
# install.packages("Sejong")
# install.packages("wordcloud")
# install.packages("tm")
# install.packages("RSQLite")
# install.packages("hash")
# install.packages("tau")
# install.packages("httr")
# install.packages("XML")
# install.packages("rlang")

library(RSQLite)
library(KoNLP)
library(tm)
library(wordcloud)
library(httr)
library(XML)

# (1) URL 요청
url <- "https://news.naver.com/"
web <- GET(url)
web

# (2) HTML 파싱
html <- htmlTreeParse(web, useInternalNodes = T, trim=T, encoding="utf-8")
rootNode <- xmlRoot(html)
rootNode

# (3) 태그 자료 수집
# <div class="main_content_inner _content_inner">
news <- xpathSApply(rootNode, "//div[@class='main_content_inner _content_inner']", xmlValue)
news

# (4) 수집한 자료 전처리
news_pre <- gsub('[\r\n\t]', '', news) 
news_pre <- gsub('[a-z]','',news_pre)
news_pre <- gsub('[A-Z]','',news_pre)
news_pre <- gsub('\\s+',' ',news_pre)
news_pre <- gsub('[[:cntrl:]]','',news_pre)
news_pre <- gsub('[[:punct:]]','',news_pre)
news_pre <- gsub('\\d+',' ',news_pre)
news_pre

# (5) 토픽 분석
# 단어 추출
library(KoNLP)
news_noun <- extractNoun(news_pre)
news_noun

#말뭉치 생성
library(tm)
newsCorpus <- Corpus(VectorSource(news_noun))
TDM <- TermDocumentMatrix(newsCorpus, control=list(wordLengths=c(4,16)))
TDM
tdm.df <- as.data.frame(as.matrix(TDM))
dim(tdm.df)
tdm.df

wordResult <- sort(rowSums(tdm.df),decreasing =T)
wordResult

wordResult <- wordResult[-c(1:6)]

library(wordcloud)
myNames <- names(wordResult)
df <- data.frame(word=myNames, freq=wordResult)
df
pal <- brewer.pal(12,"Paired")
wordcloud(df$word, df$freq, min.freq=2, random.order=F, scale=c(4,0.7), 
          rot.per=0.1, colors=pal, family="malgun")

windowsFonts(A=windowsFont("serif"))
############################13번째 강의################################
#pryr package
#install.packages("pryr")
library(pryr)

df<-data.frame(x=1:10,y=letters[1:10])
df
otype(df) #s3
methods("mean")
methods("t.test")
methods(class="ts")

#S3 object (1)
foo<-structure(list(),class="foo")
class(foo)
inherits(foo,"foo")
otype(foo)

#s3 object (2)
foo<-list()
class(foo)<-"foo"
class(foo)
inherits(foo,"foo")
otype(foo)

#s3 function
#create a generic function
f<-function(x) UseMethod("f")
f

f.a <-function(x) "Class a!!!"
f.default<-function(x) "Unkown!!!"

obj1<-list(); class(obj1)<-"a"
obj1
class(obj1)
otype(obj1)
f(obj1)

#create a linear model
mod<-lm(log(mpg)~log(disp),data=mtcars)
mod
summary(mod)
class(mod)
otype(mod)
methods("summary")
class(mod)<-"newlm"

summary(mod)

summary.newlm<-function(object,...) print("newlm!!!")
summary(mod)

###2번째 강의###

#S4 object
library(methods)
setClass("Person",slots=list(name="character",age="numeric"))
setClass("Employee",slots=list(boss="Person"),contains="Person") #contains=: 상속받는 것

alice<-new("Person",name="Alice",age=40)#사람
john<-new("Employee",name="John",age=20,boss=alice)

alice
john

alice@name
alice@age

john@name
john@age
john@boss

#create a generic function and method
union
methods("union")
?methods
setGeneric("union")
setMethod("union",c(x="data.frame",y="data.frame"),function(x,y){unique(rbind(x,y))})

a<- data.frame(a=10,b=20)
a
b<-dataxx.frame(a=10,b=30)
b

union(a,b)
###
# create a generic and method
setGeneric("union") #> [1] "union"
setMethod("union", # generic name
          c(x = "data.frame", y = "data.frame"),function(x, y) { unique(rbind(x, y))}
)
###

#RC object 
Acc1<-setRefClass("Account1",fields=list(balance="numeric"))
Acc2<-setRefClass("Account2",fields=list(balance="numeric"),methods = list(
  withdraw=function(x){balance<<-balance-x},deposit=function(x){balance<<-balance +x}
))
Acc3<-setRefClass("NoOverdraft",contains = "Account2",methods=list(
  withdraw=function(x){
    if (balance<x) stop("Not enough Money!!!")
    balance <<-balance-x
  }
))
a1<-Acc1$new(balance=100)
a1$balance
a1$balance<-200

a2<-Acc2$new(balance=100)
a2$deposit(100)
a2$balance
a2$withdraw(200)

a3<-Acc3$new(balance=100)
a3$deposit(50)
a3$balance
a3$withdraw(200)

#####################족보정리############################################################
#1
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/기말고사")
getwd()
user_data<-read.csv("user_data.csv",header=T)
head(user_data)
user_data$house_type[user_data$house_type==1]<-"단독주택"
user_data$house_type[user_data$house_type==2]<-"다세대주택"
user_data$house_type[user_data$house_type==3]<-"아파트"
user_data$house_type[user_data$house_type==4]<-"오피스텔"
user_data$age_group<-ifelse(user_data$age<40,"40세미만","40세이상")
table(user_data$age_group,user_data$house_type)
boxplot(user_data$age)

#2
df<-data.frame(no=c(1:15),before=c(80,96,75,81,78,71,85,74,84,91,76,85,73,88,94),after=c(83,91,74,83,75,65,88,70,81,89,79,78,70,81,93))
df
mean(df$before)
mean(df$after)
t.test(df$before,df$after,paired = T)
#(2)
library(ggplot2)
##
result1<- ggplot(df,aes(x=no,y=before))+
  geom_boxplot(fill="blue",color="black")+labs(x="before",y="weight")+scale_y_continuous(limits=c(65,110))
result1
##
result2<- ggplot(df,aes(x=no,y=after))+
  geom_boxplot(fill="blue",color="black")+labs(x="after",y="weight")+scale_y_continuous(limits=c(65,110))
result2

#3
prop.test(c(457,446),c(500,500),alter="two.sided",correct = T)

#4
smoking<-read.csv("smoking.csv",header = T)
head(smoking)
table(smoking)

x<-smoking$education
y<-smoking$smoking
table(x)
table(y)
sum(is.na(x))
sum(is.na(y))
#######smoking<-na.omit(smoking)
chisq.test(x,y)
library(gmodels)
CrossTable(x,y,chisq=T)

#(3)
library("DBI")
#C:\Program Files\Java\jre1.8.0_301
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_301")
library(rJava)
library(RJDBC)

#mysql-connector-java-8.0.27 (connector from R to MariaDB)
drv<-JDBC(driverClass = "com.mysql.cj.jdbc.Driver",
          classPath = "C:/Temp/Program/mysql-connector-java-8.0.27.jar")
conn<-dbConnect(drv,"jdbc:mysql://127.0.0.1:3306/work?serverTimezone=UTC",
                "scott","tiger")
##maria DB
##create database work;
##show work;
##use work;
#show table;
dbWriteTable(conn, "smoking", smoking)
dbGetQuery(conn, "select * from smoking where smoking='3.non-smoking' and education='2.high'")

#5
#(1)
library(pryr)
acc1<-setRefClass("Class1",fields=list(score="numeric"))
c1<-acc1$new(score=99)
c1$score

#(2)
acc2<-setRefClass("Class2",contain="Class1",fields = list(score="numeric"),methods=list(getCredit=function(x){ifelse(score>=90,"A","B")}))
c2<-acc2$new(score=89)
c2$getCredit()

  