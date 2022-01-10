x <- c(12,30,24,24,18,30,12,6,36,42)
y <- c(18,42,24,36,24,36,14,10,48,54)
mx <- mean(x)
my <- mean(y)
sx <- sd(x)
sy <- sd(y)
N <- 200 #지정해주기
n <- 10 #지정해주기
(ty<-N*my)
vy <- (sy^2/n)*((N-n)/N)
(simpleB<-2*N*sqrt(vy))

#ratio
r = my/mx
tx <- 4200 #지정해주기
mux <- tx/N
(ratioty<-r*tx)
vr <- ((N-n)/(n*N))*(1/mux^2)*(sy^2+r^2*sx^2-2*r*cor(x,y)*sx*sy)
(ratioB<-2*tx*sqrt(vr))

#regression
b <- cov(x,y)/sx^2
myl <- my+b*(mux-mx)
(regression<-N*myl)
anova(lm(y~x)) #residuals mean값
mse <- 13.24 #지정해주기
vmyl <- ((N-n)/(n*N))*mse
(regressionB<-2*N*sqrt(vmyl))
plot(x,y)
M1<-lm(y~x)
abline(M1)

