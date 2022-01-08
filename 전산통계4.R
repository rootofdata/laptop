x<-c(2.1,4.2,3.3,5.4)
(y<-setNames(x,letters[1:4]))
y["b"]
factor("b")
y[factor("b")]

str(factor("b"))

str(factor(c("b","c","c","b")))
y[factor(c("b","c","c","b"))] #level:2
