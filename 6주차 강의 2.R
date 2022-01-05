# Bar plot
chart_data<-c(305,450,320,460,330,480,380,520)
names(chart_data)<-c("2014-1","2015-1","2014-2","2015-2",
                     "2014-3","2015-3","2014-4","2015-4")
chart_data

#세로 (가로)Bar plot 그리기
?barplot
barplot(chart_data,col=c("red","blue"))
barplot(chart_data
        ,col=rainbow(8),ylab="매출액",xlab="연도별 분기현황",
        main="2014vs2015년도 분기별 매출현황",
        ylim=c(0,600))
barplot(chart_data, 
        horiz=T,
        ,col=rainbow(8),ylab="매출액",xlab="연도별 분기현황",
        main="2014vs2015년도 분기별 매출현황",
        Xlim=c(0,600),cex.names=0.6) #xlim 변경
# 개별 (누적) bar plot 그리기
data("VADeaths")
head(VADeaths) #Death rates in Virginia (1940)
class(VADeaths)

barplot(VADeaths,beside=T,col=rainbow(5),
        main="Death Rates in Virginia",ylab="Death rates")
legend(19,71,
       c("50-54","55-59","60-64","70-74"),
       fill=rainbow(5))

barplot(VADeaths,beside=F,col=rainbow(5),
        main="Death Rates in Virginia",ylab="Death rates")
legend(3.8,200,
       c("50-54","55-59","60-64","70-74"),
       fill=rainbow(5))

#Dot chart
chart_data
dotchart(chart_data,col=c("red","blue"),xlab="매출액",
         pch=1:2, cex=1.5,
         main="분기별 판매현황")

#pie chart
pie(chart_data,labels=names(chart_data),
    border='blue',col=rainbow(8))
title("분기별 판매현황")

#3D pie chart
install.packages("plotrix")
library(plotrix)
pie3D(chart_data,labels=names(chart_data),explode = 0.1,
      main="분기별 판매현황")

#Histogram
data("iris")
head(iris)
table(iris$Species)

summary(iris$Sepal.Length)
hist(iris$Sepal.Length,xlab="sepal length of iris",
     main="iris sepal length histogram",col="light green",
     breaks=10,xlim=c(min(iris$Sepal.Length)-0.5,max(iris$Sepal.Length)))

hist(iris$Sepal.Width,xlab="sepal Width of iris",freq=F, #freq 추가함
     main="iris sepal Width histogram",col="light green", 
     breaks=10,xlim=c(min(iris$Sepal.Width),max(iris$Sepal.Width)))

d<-density(iris$Sepal.Width)
class(d)
names(d)
head(d$x)
head(d$y)

#add density
lines(d,col="red")

#add normal distribution curve
x <-seq(2.0,4.5,0.1) #그래프 x축 범위 정도..?
length(x)
m<-mean(iris$Sepal.Width)
s<-sd(iris$Sepal.Width)
curve(dnorm(x,m,s),col="blue",add=T)
dnorm(x,m,s)

#box plot
VADeaths
boxplot(VADeaths,col="light blue")
cm<-colMeans(VADeaths)
points(1:4,cm,col="red",pch=16)

#Scatter plot(산점도)
set.seed(10) #계속 같은 숫자 나오게 하기.
price<-runif(10,min=1,max=100)
price
plot(price,col="blue",pch=16)
par(new=T)
plot(1:100,type='l',col="red",axes=F,ann=F)
text(70,80,"대각선 추가",col="blue")

#Draw scatter plot for overlapped points
install.packages("HistData")
library(HistData)
data("Galton")
head(Galton)

table(Galton$child,Galton$parent)
galtonData<-as.data.frame(table(Galton$child,Galton$parent))
galtonData
names(galtonData)<-c("child","parent","freq")
head(galtonData)
plot(as.numeric(galtonData$parent),as.numeric(galtonData$child),
     col="blue",bg="green",pch=21,cex=0.2*galtonData$freq,
     xlab="parent",ylab="child")

x<-rnorm(1000)
y<-rnorm(1000)
xy<-matrix(c(x,y),length(x),2)
colnames(xy)<-c("x","y")
head(xy)
plot(xy,col="blue",pch=20,cex=2)
plot(xy,col=densCols(xy),pch=20,cex=2) #곂치는 부분 진하게 표시

#Scatter plot for 3D
install.packages("scatterplot3d")
library(scatterplot3d)
table(iris$Species)

se<-iris[iris$Species=="setosa",]
vc<-iris[iris$Species=='versicolor',]
va<-iris[iris$Species=='virginica',]

d3<-scatterplot3d(iris$Petal.Length,iris$Sepal.Length,
                iris$Sepal.Width,type='n')
d3$points3d(se$Petal.Length,se$Sepal.Length,
            se$Sepal.Width,bg='orange',pch=21)
d3$points3d(vc$Petal.Length,vc$Sepal.Length,
            vc$Sepal.Width,bg='blue',pch=21)
d3$points3d(va$Petal.Length,va$Sepal.Length,
            va$Sepal.Width,bg='green',pch=21)

#그룹별 기술 통계량 구하기
head(iris)
apply(iris,2,mean)
lapply




