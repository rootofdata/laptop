#조건문
#if 문 only
score<-85
result<-"B"
if(score>80) result<-"A"
result
cat("당신의 학점은",result,"(",score,")","입니다.")

#if ~else if 문
score<-90
if (score>=90){result="A"
}else if (score >= 80) {result ="B"
}else if (score >= 70) {result ="C"
}else if (score >= 60) {result ="D"
}else {result="F"}
cat("당신의 학점은",result,"(",score,")","입니다.",sep="")

#ifelse 문
score<-c(100,85,70,90)
names(score)<-c("James","Jane","Thomas","Maria")
score
credit<-ifelse(score>=90,"A","B")
credit

#switch 문
input<-"name"
switch(input,id="hong",age=40,name="James")

#which 문 (유용하다!!)
no<-1:5
name<-c("James","Jane","Thomas","Maria","Tom")
score<-c(100,80,90,95,30)
exam<-data.frame(학번=no ,이름=name,성적=score)
exam$학번
exam[which(exam$학번==3),]

#반복문 (for문)
d<-numeric()
for(i in 1:10) {
  d[i]<-i*10
  cat(i,d[i],"\n")
}

#짝수값 출력
for (i in 1:10){
  #if(i%%2==0){print(i)}
  if(i%%2==0){next
    }else{cat(i," ")}
}
score<-c(50,80)
name<-c("James","Jane")
i<-1
for (s in score){
  cat(name[i],"점수",s,"\n")
  i<-i+1
}

#while문
i<-0
while(i<10){
  i<-i+1
  print(i)
}

#R 내장함수
#행, 열 합계 및 평균 구하기
install.packages("RSADBE")
library(RSADBE)
data("Bug_Metrics_Software")
bug<-Bug_Metrics_Software
bug
class(bug)
bug[,,1]
bug[,,2]

class(bug[,,1])
rowSums(bug[,,1])
apply(bug[,,1],1,sum)

rowMeans(bug[,,1])
apply(bug[,,1],1,mean)

colSums(bug[,,1])
apply(bug[,,1],2,sum)

colMeans(bug[,,1])
apply(bug[,,1],2,mean)

#난수 생성 및 확률 분포
#정규분포(Normal distribution)
n<-1000
r<-rnorm(n,mean=0,sd=1) #r<-rnorm(n,0,1)
r
?rnorm
hist(r,col="light blue",main="Histogram of random numbers")

#균등분포(Uniform distribution)
n<-1000
r2<-runif(n,min=0,max=1) #r2<-runfif(n,0,1)
r2
hist(r2,col="pink")

#이항분포 (Binomial distribution)
set.seed(123) #랜덤순서 고정해주기
n<-20
rbinom(n,1,prob = 0.5) #베르누이
rbinom(n,2,0.5)
rbinom(n,10,0.5)

#################
#사용자 정의 함수
#################
#매개변수가 없는 함수
f1<-function(){
  cat("매개변수가 없는 함수!!!")
}
f1()

#매개변수가 있는 함수
f2<-function(x=10,y=20){
  cat("x=",x,"y=",y)
}
f2(10,50)
f2()

#리턴값이 있는 함수
f3<-function(x,y){
  prod<-x*y
  return(prod)
}
prod<-f3(10,20)
prod

#분산과 표준편차를 구하는 함수
x<-c(7,5,12,9,15,6)
x
var(x)
sd(x) #sqrt(var(x))
var_sd<-function(x){
  var<-sum((x-mean(x))^2)/(length(x)-1)
  sd<-sqrt(var)
  cat("var=",var,"sd=",sd)
  res<-c(var,sd)
  return(res)
}
result<-var_sd(x)
result

#구구단 출력 함수
gugu<-function(i){
  for(x in i){
    cat("****",x,"단****","\n",sep="")
    for (y in 1:9){
      cat(x,"*",y,"=",x*y,"\n",sep="")
    }
    cat("***********\n")
  }
}
gugu(3:5)

#동전 앞/뒤 난수 확률 분포 함수
coin<-function(n){ #n은 시행횟수
  r<-runif(n,0,1)
  res<-numeric()
  for (i in 1:n){
    if(r[i]<=0.5){res[i]<-0
    }else{res[i]<-1}
  } 
  return(res)
}
coin<-function(n){ #n은 시행횟수
  r<-runif(n,0,1)
  res<-ifelse(r<=0.5,0,1)
  return(res)
}
coin(10)
coin(1)
#몬테카를로 시뮬레이션
montaCoin<-function(n){
  cnt<-0
  for (i in 1:n){
    cnt<-cnt+coin(1)
  }
  res<-cnt/n
  return(res)
}
montaCoin(10)
montaCoin(100)
montaCoin(1000)
montaCoin(1000000)

#ceiling() 올림 floor()내림 round() 반올림
#factorial(x) 팩토리얼함수
pmin(5:1,pi) #더 작은 값 출력
min(5:1,pi)
prod(1:6) #벡터 원소들의 곱
cumsum(1:6)  #누적합 
cumprod(1:6) #누적곱
log(x) #자연로그
log10(x)
ncol(x)
nrow(x)
t(x) #전치행렬
cbind(x) #열 더할때
rbind(x)
diag(x) #대각행렬
det(x) #행렬식
x%*%y #두 행렬의 곱
solve(x) #역 행렬
qr(x) #QR 분해
eigen(x) #고유값
chol(x) #choleski 분해

c %in% y #c가 집합 y의 원소인지 테스트 ---> 해볼만함
c<-c(10,2,3,4,5)
y<-c(1,2,3,4,5,6,7)
choose(n,k) #n combination k
choose(5,2)