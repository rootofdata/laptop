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

setMethod("union",c(x="data.frame",y="data.frame"),function(x,y) {unique(rbind(x,y))})

a<- data.frame(a=10,b=20)
a
b<-data.frame(a=10,b=30)
union(a,b)

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
