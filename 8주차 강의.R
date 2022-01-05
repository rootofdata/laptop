#ggplot2 설치
install.packages("ggplot2")
library(ggplot2)
data(mpg)
head(mpg)
str(mpg)
?mpg #연비 효율에 대한 데이터

table(mpg$drv)
summary(mpg$hwy) #highway miles per gallon

plot(mpg$hwy)
hist(mpg$hwy)
qplot(hwy,data=mpg,fill="light blue") #다른 색깔로 나옴
qplot(hwy,data=mpg,fill=I("light blue"),col=I("black")) #I = 변수로 해석하지 말아라.
qplot(hwy,data=mpg,fill=drv,col=I("black"),binwidth=2,facets=.~drv) #drv에 따라 나뉘어져 그려진다.
#binwidth bin의 크기가 커지는 것,  facets= 쪼개는것(drv에 따라 쪼개는거(열)) (drv~. =행에 따라 나눈다.)
qplot(hwy,data=mpg,fill=drv,col=I("black"),binwidth=2,facets=drv~cyl) #그리드 형태의 그림

#diamonds 데이터
head(diamonds)
?diamonds #5만4천개의 다이어의 정보
table(diamonds$clarity)
table(diamonds$cut)

qplot(clarity,data=diamonds,fill=cut,geom='bar')

#변수가 2개인 경우 -->산점도 (scatter)
summary(mpg$displ)
?mpg

qplot(displ,hwy,data=mpg,color=drv,facets = drv~.)

#mtcars
head(mtcars)
?mtcars
table(mtcars$carb)
summary(mtcars$qsec)
qplot(wt,mpg,data=mtcars,color=factor(carb),size=qsec,
      shape=factor(cyl)) #반비례의 관계에 있다

qplot(wt,mpg,data=mtcars,geom="point")
qplot(wt,mpg,data=mtcars,geom="smooth")
qplot(wt,mpg,data=mtcars,geom=c("smooth","point"),color=factor(cyl))
