x<-c(0.3,0.5,0.4,0.9,0.7,0.2,0.6,0.5,0.8,0.4,0.8,0.6)
y<-c(6,9,7,19,15,5,12,9,20,9,18,13)
(xb<-mean(x))
(yb<-mean(y))
75/250
(r<-mean(y)/mean(x))
r
p<-cor(x,y)
(k<-r*r*sd(x)*sd(x)+sd(y)*sd(y)-2*r*sd(x)*sd(y)*p)
(v<-(250-12)/12/250/0.3/0.3*k)
k
v
vty
(vty<-v*75*75)
(B<-2*(sqrt(vty)))
B
(a<-data.frame(x=x,y=y))
v<-"volume"

(plot(x,y,xlab = "Square-foot basal area",ylab="Volume",main = "1번문제"))


##2번문제
yb*250
vy<-2*sqrt((250*250)*238/250*sd(y)*sd(y)/12)
vy
