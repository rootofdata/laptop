N<-415
n<-25
mi<-c(8,12,4,5,6,6,7,5,8,3,2,6,5,10,9,3,6,5,5,4,6,8,7,3,8)
yi<-c(96,121,42,65,52,40,75,65,45,50,85,43,54,49,53,50,32,22,45,37,51,30,39,47,41)*1000
(ybar<-sum(yi)/sum(mi)) #추정치
a<-yi/mi
sd(d)
cor(yi,mi)
sd(mi)
(N-n)/(N)*((1/n)*sd(mi)^2/mean(mi)^2-cor(yi,mi)*sd(mi)/mean(mi)*sd(d)/mean(d))
d<-(yi-ybar*mi)
vy<-(N-n)/(N*n*mean(mi)^2)*sum((yi-ybar*mi)^2)/(n-1) #분산
p<-cor(mi,yi)
(1-n/N)*(1/n)*((sd(mi)/mean(mi))^2-p*(sd(mi)/mean(mi)*sd(yi)/ybar))   ##오류있는 계산
####total estimation####
#### M을 알때####
M<-2500
M*ybar
vmy<-M^2*vy  
#### M을 모를 때####
N/n*sum(yi)
(st2<-sum((yi-mean(yi))^2)/(n-1) ) ##sd(yi)^2
sqrt(st2)
b<-N^2*(1-n/N)*st2/n #v(Ny)에 들어갈 값
2*sqrt(b) #bound값
####equal cluster sizes####
#--------------anova값구하기-----
a<-c(1,2,1,3,3,2,1,4,1,1,1,3,2,2,3,1,4,1,1,2,2,1,1,1,1,3,2,1,3,1,1,1,3,2,1,5,1,2,3,1)
b<-factor(rep(x=1:4,each=10),labels=paste("a",1:4,sep=""));b
dat<-data.frame(a,b)
fit<-aov(a~b,data=dat)
anova(fit)
####MSB이용해서 추정치 구하기####
n<-4
N<-400
yi<-c(19,20,16,20)
m<-10
(ybar<-sum(yi)/length(yi)/m) #평균
(vybar<-(1-n/N)*(1/m/n)*0.36) #MSB=0.36 #분산값
2*sqrt(vybar)
###########단순확률추출이랑 비교##
s2<-1/m*((m-1)*1.2+0.36)
simplevy<-(1-n/N)*(1/m/n)*s2^2
reyy<-s2/0.36 #re(yc/y) relative efficiency 구하기
#########selcet sample size#####
B<-500
D<-B^2*mean(mi)^2/4;D
sr2<-sum((yi-ybar*mi)^2)/(n-1);sr2
sizen<-N*sr2/(N*D+sr2)
sizen
#-------
B<-1000000
D<-B^2/4/N^2
sizen<-N*sr2/(N*D+sr2)
sizen
#-------
N/n*sum(yi)
st2<-sum((yi-mean(yi))^2)/(n-1) 
sqrt(st2)
(b<-N^2*(1-n/N)*st2/n) #v(y)에 들어갈 값
2*sqrt(b) #bound값
D<-B^2/4/N^2
sizen<-N*st2/(N*D+st2)
sizen




#============9장========
##u 추정하기####
Mi<-c(50,65,45,48,52,58,42,66,40,56)
yi<-c(5.4,4,5.667,4.8,4.3,3.83,5,3.85,4.88,5)
si2<-c(11.38,10.67,16.75,13.29,11.12,14.88,5.14,4.31,6.13,11.8)
mi<-c(10,13,9,10,10,12,8,13,8,11)
N<-90
n<-10
M<-4500
(u<-N/M/n*sum(Mi*yi)) #평균
sb2<-sum((Mi*yi-M/N*u)^2)/(n-1)
(varu<-(1-n/N)*(1/(n*(M/N)^2))*sb2+1/(n*N*(M/N)^2)*sum(Mi^2*(1-mi/Mi)*(si2/mi))) #분산값
####T 추정하기####
t<-M*u #평균
vart<-M^2*varu #분산
2*sqrt(vart)
####ratio estimation M모를때####
ur<-sum(Mi*yi)/sum(Mi)
sr2<-sum(Mi^2*(yi-ur)^2)/(n-1)
varur<-(1-n/N)*(1/(n*(M/N)^2))*sr2+1/(n*N*(M/N)^2)*sum(Mi^2*(1-mi/Mi)*(si2/mi))
####proportion 일때####
pi<-c(0.4,0.38,0.22,0.3,0.5,0.25,0.38,0.31,0.25,0.36)
(p<-sum(Mi*pi)/sum(Mi)) #p 추정값
(sr2<-sum((Mi^2*(pi-p)^2)/(n-1)))
(varp<-(1-n/N)*(1/(n*(M/N)^2))*sr2+1/(n*N*(M/N)^2)*sum(Mi^2*(1-mi/Mi)*(pi*(1-pi)/(mi-1)))) #p분산값
#####M이 같을때#####


####10장####
####direct samping####
t<-300 #captured tag released
n<-200 #second sample
s<-62 #recaptured
(N<-n*t/s) #총개수
vn<-t^2*n*(n-s)/s^3 #분산
2*sqrt(vn)
####inverse sampling####
t<-150 #captured tag released
n<-100 #second sample
s<-35 #recaptured
(N<-n*t/s) #총 개수
vn<-t^2*n*(n-s)/(s^2*(s+1)) #분산
2*sqrt(vn)
 -90/52
