#키보드로 입력
num<-scan()
num

name<-scan(what=character())
name
?scan #what=double()이다.

df=data.frame()
df=edit(df)
df

#화면 출력
x<-10;y<-20
x
y
z<-x*y
cat("x*y=",z,";","x/y=",x/y,sep="")

print(z)

#로컬 파일 읽기
getwd()
setwd("C:\\Users\\SEO\\Desktop\\3-2\\전산통계1\\R언어\\part1")
setwd(readCilpboard())

student<-read.table("student.txt")
student
colnames(student)<-c("번호","이름","키","몸무게")
student

student1<-read.table("student1.txt",header=T)
student1

student2<-read.table("student2.txt",header=T,sep=";")
student2

student3<-read.table("student3.txt",header=T,na.strings="-")
student3

student4<-read.table("student4.txt",header=T,sep=",",na.strings = "-")
student4<-read.csv("student4.txt",na.strings="-")
student4

#로컬 파일 읽기
install.packages("data.table")
library(data.table)
stock<-fread("stock.csv")
stock<-read.csv("stock.csv")

stock
dim(stock)

#엑셀 파일 읽기
install.packages("xlsx")
install.packages("rJava")
#자바 JRE 설치
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre.8.0_301')
library(xlsx)
library(rJava)
studentex<-read.xlsx("studentexcel.xlsx",sheetIndex = 1,encoding = "UTF-8")
studentex

#로컬 파일 저장
student
write.table(student,"student_new.txt",row.names = F,quote=F)
student4
write.csv(student4,"student4_new.csv",row.names = F,quote=F)
student4_new<-read.csv("student4_new.csv",na.strings = "-")
student4_new

fwrite(stock,"stock_new.csv")

studentex
write.xlsx(studentex,"studentex_new.xlsx",row.names = F)

#인터넷에서 파일 읽기
http://databank.worldbank.org/data/download/GDP.csv
GDP_ranking<-read.csv("http://databank.worldbank.org/data/download/GDP.csv",skip=3)[2:206,-c(3,6)]
head(GDP_ranking)
names(GDP_ranking)=c("Code","Ranking","Notion","GDP")

GDP_ranking
library(stringr)
num_gdp=as.numeric(str_replace_all(GDP_ranking$GDP,",",""))
num_gdp
GDP_ranking$GDP<-num_gdp
head(GDP_ranking)

GDP_ranking15<-head(GDP_ranking,15)
barplot(GDP_ranking15$GDP,col=rainbow(15),las=2,cex.names=0.6,names.arg=GDP_ranking15$Nation)


#웹문서 읽기
url= "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

install.packages("XML")
install.packages("httr")

library(XML)
library(httr)

get_url<-GET(url)
con<-rawToChar(get_url$content)

library(stringr)
str_locate_all(con,"<table")
str_sub(con,38564,38666)

html_cont<-as.data.frame(readHTMLTable(con))
class(html_cont)
html_cont
names(html_cont)<-c("State","y2010","y2011","y2012","y2013","y2014","y2015")
html_cont
