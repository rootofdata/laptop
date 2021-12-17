#stringr 패키지
install.packages("stringr")
library(stringr)

#문자열 추출(정규표현식을 활용)
str_extract("홍길동35이순신45유관순25", "[1-9]{2}") #1~9중 2개가 반복
str_extract_all("홍길동35이순신45유관순25", "[1-9]{2}")

#(1) 반복수 관련 정규표현식
string<-"hongkildong105lee102you25강감찬2005"
string
str_extract_all(string,"[a-z]{3}") 
str_extract_all(string,"[a-z]{3,}") #3개 이상
str_extract_all(string,"[a-z]{3,5}") #3개 -5개

#(2) 문자와 숫자 관련 정규표현식
str_extract_all(string,'hong')
str_extract_all(string,'[가-힣]{3}')
str_extract_all(string,'[0-9]{4}')

#(3) 특정 문자열 제외 정규표현식
str_extract_all(string,'[^a-z]{3}')
str_extract_all(string,'[^0-9]{3}')

#(4) 한개의 숫자나 단어 관련 정규표현식
jumin <-'991212-1234583'
str_extract_all(jumin,"[0-9]{6}-[1-4][0-9]{6}")
str_extract_all(jumin,"\\d{6}-[1-4]\\d{6}")
str_extract_all(string,"[a-z0-9가-힣힣]{10,}")
str_extract_all(string,"\\w{10,}") #\\w :전체 다나오기

#문자열 연산
string
str_length(string) #stringr에서 제공 #nchar(string) #기본 r 제공

str_locate(string,"강감찬") #regexpr("강감찬",string) #기본r
str_sub(string,26,28) #substring(string,26,28)
str_to_upper(string) #toupper(string)
str_to_lower(string) #tolower(string)

string_rep<-str_replace(string,"hongkildong105","홍길동35")
string_rep
string_rep<-str_replace(string_rep,"lee102",",이순신55")
string_rep<-str_replace(string_rep,"you25",",서영석24,")
string_rep
string_c<-str_c(string_rep,',강감찬55')
string_c

#문자열 분리 및 결합
string_sp<-unlist(str_split(string_c,","))
#strsplit(string_c,",")
class(string_sp)
string_sp

string_join<-paste(string_sp,collapse=',')
string_join

number=1:22
paste("file_chr",number,".txt",sep="")
paste0("file_chr",number,".txt")
