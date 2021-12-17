#vector 객체 생성
vec<-1:20
vec
c(1:20,33,44)
c("a","b","c")
c("a","b","c",33,44)
c("a","b","c",vec)

seq(from=1,to=10,by=2) #1,3,5,7,9
?seq
seq(1,100,3)
rep(x=1:3,times=5)
rep(x=1:3,each=2)
rep(1:3,5) #times임
rep(1:3,each=5)
?rep

#vector 데이터 처리 함수
x<-c(1,3,5,7)
y<-c(3,5)
length(x)
length(y)
union(x,y) #합집합
intersect(x,y) #교집합
setdiff(x,y) #차집합
setdiff(y,x)

#vector 컬럼 이름
age<-c(20,22,33)
age
names(age) <-c("James","Jane","Peter")
age
names(age)
age[1]
age[2]
age[3]
age[1:2]

#vecter 데이터 참조
a<-1:50
a
a[c(1,3)]
a[30:45]
a[c(1,2,45:50)]
a[-1]
a[-c(1,4,5,6,7)]

#matrix 객체 생성
m<-matrix(c(1:3))
m
m<-matrix(c(1:10),nrow=2,ncol=5)
#matrix(c(1:10),2,5)
m<-matrix(c(1:10),2,5,byrow=T)

x<-matrix(1:9,3,3)
x
colnames(x)<-c("one","two","three")
rownames(x)<-c(1,2,3)
x
colnames(x)
rownames(x)

mode(x)
class(x)

length(x)
ncol(x)
nrow(x)

#apply 함수
x
apply(x,1,max) #1:행,2:열
x[1,]
x[2,]
x[3,2]
max(x[1,])
max(x[2,])
max(x[3,])

apply(x,2,max) #열을 기준
max(x[,1])
max(x[,2])
max(x[,3])

f<-function(x){x *c(1,2,3)}
f(2)
f(c(2,3,4))
x
apply(x,1,f)
f(x[1,])
f(x[2,])
f(x[3,])

#### 2차시####
#Array 객체 생성
arr<-array(1:12,c(3,2,2)) 
arr
arr[,,1]
arr[,,2]
arr[1,1,2]

mode(arr)
class(arr)

#List 객체 생성
list<-list('lee','이순신',2,c(1,2,3),matrix(1:6,2,3))
list

list[[1]]
list[[2]]
list[[3]]
list[[4]]
list[[5]]

unlist<-unlist(list)
unlist

member<-list(name=c('lee','이순신'),age=c(35,25),adress=c('미국','한국'))
member
member[[1]][2]
member[[2]][1]
member$name[1]
member$age[2]

#lapply,sapply 함수
a<-list(1:5,6:10)
a
lapply(a,max)
unlist(lapply(a,max)) #sapply와 같다
sapply(a,max) 

#do.call 함수
multi_list<-list(c1=list(1,2,3),c2=list(10,20,30))
multi_list
multi_list[[1]]
multi_list[[2]]

do.call(cbind,multi_list)
cbind(multi_list[[1]],multi_list[[2]])

#Data frame 객체 생성
# (1) vector를 이용
no<-c(1,2,3)
name<-c("hong","lee","kim")
pay<-c(150,250,300)
vemp<-data.frame(NO=no,NAME=name,Pay=pay)
vemp
mode(vemp)
class(vemp)

#(2)Matrix를 이용
m<-matrix(c(1,'hong',150,
            2,'lee',250,
            3,'kim',300),3,3,byrow=T)
memp<-data.frame(m)
memp
class(m)
class(memp)
colnames(memp)=c("NO","Name","Pay")
memp

# (3)txt,csv 파일을 이용하여 객체 생성
getwd()
setwd("C:\\Users\\SEO\\Desktop\\3-2\\전산통계1\\R언어\\part1")
txtemp<-read.table("emp.txt",header=T,)
txtemp
class(txtemp)

#data frame 처리 함수
df<-data.frame(x=c(1:5),y=seq(2,10,2),z=c('a','b','c','d','e'))
df

str(df)
dim(df)
class(df)
ncol(df)
nrow(df)
colnames(df)
rownames(df)
summary(df)
apply(df[,1:2],2,sum)

#subset 함수
df
x1<-subset(df,x>=3)
x1
x2<-subset(df,x>=3&y<9)
x2

#데이터 병합
height<-data.frame(id=c(1,2,3),h=c(180,175,155))
weight<-data.frame(idd=c(1,2),w=c(80,75))


user=merge(height,weight,by.x="id",by.y="idd",all=T) #all.y, all.x하면 달라짐
user
