#2번문제
name <- c("최민수","유관순","이순신","김유신","홍길동")
age <- c(55,45,45,53,15) #연령
gender <- c(1,2,1,1,1)   #1:남자 2:여자
job <- c("연예인","주부","군인","직장인","학생")
sat <- c(3,4,2,5,5)      #만족도
grade <- c("C","C","A","D","A")
total <- c(44.4,28.5,43.5,NA,27.1) #총구매금액(NA:결측치)
#조건1 위 7개의 벡터를 칼럼으로 갖는 user 데이터프레임을 생성하시오.
user <- data.frame(name=name,age=age,gender=gender,job=job,sat=sat,grade=grade,total=total)
user
class(user)
#조건2 gender 변수를 이용하여 히스토그램을 그리시오.
hist(user$gender)
# 데이터프레임 user에서 짝수 행만 선택해서 user2에 넣으시오
user2<-user[c(2,4),]
user2
#혹은 
nrow(user)
seq(0,nrow(user),2)
user2 <- user[seq(2,nrow(user),2),]
user2
#3번 문제 Data를 대상으로 apply()를 적용하여 행/열 방향으로 조건에 맞게 통계량을 구하시오.
kor <- c(90,85,90)
eng <- c(70,85,75)
mat <- c(86,92,88)
#조건1 3개의 과목점수를 이용하여 데이터프레임(Data)을 생성하시오
Data <- data.frame(kor=kor,eng=eng,mat=eng)
Data
#조건2 행/열 방향으로 max()함수를 적용하여 최대값을 구하시오.
apply(Data,1,max) #행방향
apply(Data,2,max) #열방향향
#조건3 행/열 방향으로 mean()함수를 적용하여 평균을 구하여 소수점 23자리까지 표현하시오.
round(apply(Data,1,mean),2)
round(apply(Data,2,mean),2)
#조건4 행 단위의 분산과 표준편차를 구하시오.
apply(Data,1,var) #분산
apply(Data,1,sd)  #표준편차

#4 다음의 Data2 객체를 대상으로 정규표현식을 적용하여 문자열을 처리하시오.
#조건1 일자별 수입을 다음과 같이 출력하시오
install.packages("stringr")
library(stringr)
Data2 <- c("2017-02-05 수입3000원",
           "2017-02-06 수입4500원",
           "2017-02-07 수입2500원")

a<-str_extract_all(Data2,'[0-9]{4}[가-힣]{1}')
mode(a)
unlist(a)
#조건2 "-- 수입원" "-- 수입원" "-- 수입원" 
unlist(str_remove_all(Data2,'[0-9]{2,}'))
#조건3  "2017/02/05 수입3000원" "2017/02/06 수입4500원" "2017/02/07 수입2500원"
unlist(str_replace_all(Data2,"-","/"))
#조건4 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오.
paste(Data2, collapse = ",")

#3장 
#2 R에서 제공하는 CO2데이터 셋을 대상으로 다음과 같은 단계로 파일에 저장하시오.
CO2[1:5,]

# 단계1 Treatment 칼럼 값이 'nonchilled'인 경우 'CO2_df1.csv'파일로 행 번호를 제외하고 저장한다.
CO2_df1<-subset(CO2,Treatment=='nonchilled')
write.csv(CO2_df1,"CO2_df1.csv",row.names = F)

#단계2 Treatment 칼럼 값이 'chilled'인 경우 'CO2_df2.csv'파일로 행 번호를 제외하고 저장한다.
CO2_df2<-subset(CO2,Treatment=='chilled')
write.csv(CO2_df2,"CO2_df2.csv",row.names = F)
