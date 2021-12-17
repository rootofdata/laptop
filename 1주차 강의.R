#R 패키지 설치
install.packages("stringr")

#R 패키지 로딩
library(stringr)
require(stringr)

library(blmd)
require(blmd)

#R 패키지 제거
remove.packages("stringr")

#자료형
int <- 20 #numeric
int
string<-"홍길동" #character
string
boolean<-TRUE #논리형 Logical
boolean

a<-NA #Missing
a
sum(10,20,30)
sum(10,20,20,NA)
sum(10,20,20,NA,na.rm=T)
100/0
0/0

#자료형 확인
is.numeric(int) #TRUE
is.integer(int) #FALSE / integer : 정수
is.double(int) # TRUE / 정수로 해도 double로 담는다. double: 실수
is.character(string) #TRUE
is.logical(boolean) #TRUE
is.na(a) #TRUE
is.na(0/0) #TRUE / NaN 값
is.nan(a) #FALSE
is.nan(0/0) #TRUE / NaN 값 ## 특이하다 ---- na ,NaN 모두 TRUE
if (is.numeric(int)) print("int is numeric")
if (is.na(a)) print("missing!!")  #조건문에서 많이 사용한다.

#자료형 변환
x<-c(1,2,"3")
x
xy<-as.numeric(x)
xy
as.character(xy)

#자료형과 자료구조 보기
#mode: 자료형(datatype)을 보여줌
#class: 자료구조(data structure)을 보여줌
mode(int) #numeric
mode(string) #character
mode(boolean) #logical
class(int) #numeric
class(string)  #character
class(boolean) #logical
## 스칼라의 경우 mode&class 결과가 같다.
## 벡터,행렬,리스트의 경우 다를 수 있다.
mat <- matrix(0,2,2)
mat #0으로만 채운 2x2 행렬
mode(mat) #numeric
class(mat) #"matirx" "array"

#유용한 함수들
help(sum)
? sum

args(sum) #함수 파라미터 보기
example(sum)

getwd() #작업 공간 보기 
setwd("C:/Users/SEO/Documents") #작업 공간 지정
getwd()
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part1")
test<-read.csv("test.csv")
test
