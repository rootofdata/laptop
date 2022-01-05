library(stringr)
EMP<-c("2014?솉湲몃룞220","2002?씠?닚?떊300","2010?쑀愿?닚260")
EMP

#2踰덈Ц?젣
emp_pay<-function(x){
  #?븿?닔 ?궡?슜 ?옉?꽦
  library(stringr)
  name<-str_extract(x,"[媛-?옡]{3}")
  cnpay<-str_extract(x,"[媛-?옡]{3}[0-9]{3}")
  nnpay<-str_replace(cnpay,'[媛-?옡]{3}',"")
  npay<-as.numeric(nnpay)
  mnpay<-mean(npay)
  
  cat("?쟾泥? 湲됱뿬 ?룊洹?:",mnpay,'\n')
  cat("?룊洹? ?씠?긽 湲됱뿬 ?닔?졊?옄\n")
  
  for (i in 1:length(name)){
    if(nnpay[i]>=mnpay){
      cat(name[i],"=>",nnpay[i],'\n')
    }
  }
}
emp_pay(EMP)

#6?옣
#1踰?
install.packages("dplyr")
library(dplyr)
data("iris")
filter1<-iris %>% filter(Petal.Length>=1.5)
filter1$Petal.Length
#2踰?
filter2<-filter1 %>%select(c(1,3,5))
head(filter2)
#3踰?
?mutate
filter3<-filter2 %>% mutate(diff=Sepal.Length-Petal.Length)
head(filter3)

#4踰?
filter4<-filter3 %>% group_by(Species) %>% summarise(sepal_mean=mean(Sepal.Length),petal_mean=mean(Petal.Length))
filter4

#5踰?
install.packages("reshape2")
library(reshape2)
#?떒怨?1
melt1<-melt(iris,id=c("Species"),na.rm = TRUE)
head(melt1)
#?떒怨?2
dcast1<-dcast(melt1,Species~variable,sum)
dcast1








