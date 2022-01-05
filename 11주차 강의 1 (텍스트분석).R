########################################
## 텍스트 마이닝 분석 
########################################

###############
# 1. 토픽 분석  
###############

# 텍스트마이닝을 위한 패키지 설치 

# 토픽 분석을 위한 패키지 설치
# install.packages("rJava")
install.packages(c("KoNLP", "wordcloud"))
# tm 패키지 구 버전 다운로드/설치 - version 3.3.2
# install.packages("http://cran.r-project.org/bin/windows/contrib/3.0/tm_0.5-10.zip",repos=NULL)
# install.packages('slam')
# install.packages('Sejong')
# install.packages('hash')
# install.packages('tau')
# install.packages('devtools')

#setwd(readClipboard())
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part2")
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_301")

# 패키지 로딩
library(rJava) 
library(slam) 
library(RSQLite)
library(httr)
library(XML)
library(KoNLP) # 세종사전 
library(tm) # 영문 텍스트 마이닝 
library(wordcloud) # RColorBrewer()함수 제공

# 명사 추출 예 
extractNoun('안녕하세요. 홍길동 입니다.')

# (1) 텍스트 자료 가져오기 
facebook <- file("facebook_bigdata.txt", encoding="UTF-8")
facebook_data <- readLines(facebook) # 줄 단위 데이터 생성
head(facebook_data) # 앞부분 6줄 보기 - 줄 단위 문장 확인 
str(facebook_data) # chr [1:76]

# (2) 자료집(Corpus) 생성 
facebook_corpus <- Corpus(VectorSource(facebook_data))
facebook_corpus 
inspect(facebook_corpus) # 76개 자료집에 포함된 문자 수 제공 


# (3)단어 추가와 단어추출 
# 세종 사전에 없는 단어 추가
#install.packages('curl')
library(curl)
useSejongDic() # 세종 사전 불러오기
mergeUserDic(data.frame(c("R 프로그래밍","페이스북","소셜네트워크"), c("ncn"))) 
# ncn -명사지시코드

# (4) 단어추출 사용자 함수 정의 
# 사용자 정의 함수 작성 
exNouns <- function(x) { paste(extractNoun(as.character(x)), collapse=" ")}
# exNouns 함수 이용 단어 추출 
facebook_nouns <- sapply(facebook_corpus, exNouns) 
facebook_nouns[1] # 단어만 추출된 첫 줄 보기 

# (5) 추출된 단어 대상 전처리
# 추출된 단어 이용 자료집 생성
myCorputfacebook <- Corpus(VectorSource(facebook_nouns)) 
myCorputfacebook 

# 데이터 전처리 
myCorputfacebook <- tm_map(myCorputfacebook, removePunctuation) # 문장부호 제거
myCorputfacebook <- tm_map(myCorputfacebook, removeNumbers) # 수치 제거
myCorputfacebook <- tm_map(myCorputfacebook, tolower) # 소문자 변경
myStopwords = c(stopwords('english'), "사용", "하기")
myCorputfacebook <-tm_map(myCorputfacebook, removeWords, myStopwords) # 불용어제거
inspect( myCorputfacebook[1:5])

# (6) 단어 선별(단어 길이 2개 이상)
# 단어길이 2개 이상인 단어만 선별하여 matrix 자료구조로 변경
myCorputfacebook_term <- TermDocumentMatrix(myCorputfacebook, control=list(wordLengths=c(2,Inf)))

# matrix 자료구조를 data.frame 자료구조로 변경
myTermfacebook.df <- as.data.frame(as.matrix(myCorputfacebook_term)) 
dim(myTermfacebook.df) 

# (7) 단어 빈도수 구하기 - 빈도수가 높은 순서대로 내림차순 정렬
wordResult <- sort(rowSums(myTermfacebook.df), decreasing=TRUE) # 빈도수로 내림차순 정렬
wordResult[1:10]

# (8) 단어 구름(wordcloud) 생성 - 디자인 적용 전
myName <- names(wordResult) # 단어 이름 생성 -> 빈도수의 이름 
wordcloud(myName, wordResult) # 단어구름 적성


# (9) 단어 구름에 디자인 적용(빈도수, 색상, 위치, 회전 등) 
# 단어이름과 빈도수로 data.frame 생성
word.df <- data.frame(word=myName, freq=wordResult) 
str(word.df) # word, freq 변수

# 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3
# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성 적용 
#x11( ) # 별도의 창을 띄우는 함수
wordcloud(word.df$word, word.df$freq, 
          scale=c(5,1), min.freq=3, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")


#################
## 2 연관어 분석 
#################

# 한글 처리를 위한 패키지 설치
#install.packages('rJava')
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_151')
#library(rJava) # 아래와 같은 Error 발생 시 Sys.setenv()함수로 java 경로 지정
#install.packages("KoNLP") 
#library(KoNLP) # rJava 라이브러리가 필요함


# (1) 텍스트 파일 가져오기 ('빅데이터'키워드로 페이스북에서 검색한 결과파일일)
marketing <- file("marketing.txt", encoding="UTF-8")
marketing2 <- readLines(marketing) # 줄 단위 데이터 생성
# incomplete final line found on - Error 발생 시 UTF-8 인코딩 방식으로 재 저장
close(marketing) 


# (2) 줄 단위 단어 추출
lword <- Map(extractNoun, marketing2)  
length(lword) # [1] key = 472

lword <- unique(lword) # 중복제거1(전체 대상)
length(lword) # [1] 353 (19개 제거)

# (3) 중복단어 제거와 추출 단어 확인
lword <- sapply(lword, unique) # 중복제거2 (줄 단위 대상) 
length(lword) # [1] 353


# (4) 연관어 분석을 위한 전처리 

# 단어 필터링 함수 정의 (길이 2~4사이 한글 단어 추출)
filter1 <- function(x){
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}

filter2 <- function(x){
  Filter(filter1, x)
}

# 줄 단위로 추출된 단어 전처리 
lword <- sapply(lword, filter2)
lword

# (5) 트랜잭션 생성

# 연관분석을 위한 패키지 설치
#install.packages("arules")
library(arules) 

# 트랜잭션 생성 
wordtran <- as(lword, "transactions") # lword에 중복데이터가 있으면 error발생
wordtran
??deparse1
# (6) 단어 간 연관규칙 산출 
# default (support지지도=0.1, confidence신뢰도=0.8, maxlen최대길이=10)
# 지지도와 신뢰도를 높이면 발견되는 규칙수가 줄어듦
tranrules <- apriori(wordtran, parameter=list(supp=0.25, conf=0.05)) 
tranrules <- apriori(wordtran, parameter=list(supp=0.25, conf=0.8)) 
tranrules <- apriori(wordtran, parameter=list(supp=0.3, conf=0.05)) 

# 연관규칙 생성 결과보기 
inspect(tranrules) # 연관규칙 생성 결과(59개) 보기

# (7)  연관어 시각화 

# 연관단어 시각화를 위해서 자료구조 변경
rules <- labels(tranrules, ruleSep=" ")  
rules
class(rules)

# 문자열로 묶인 연관단어를 행렬구조 변경 
rules <- sapply(rules, strsplit, " ",  USE.NAMES=F) 
rules
class(rules) 

# 행 단위로 묶어서 matrix로 반환
rulemat <- do.call("rbind", rules)
rulemat
class(rulemat)

# 연관어 시각화를 위한 igraph 패키지 설치
#install.packages("igraph") # graph.edgelist(), plot.igraph(), closeness() 함수 제공
library(igraph)   

# edgelist보기 - 연관단어를 정점 형태의 목록 제공 
ruleg <- graph.edgelist(rulemat[c(12:59),], directed=F) # [1,]~[11,] "{}" 제외
ruleg

#  edgelist 시각화
#X11()
plot.igraph(ruleg, vertex.label=V(ruleg)$name,
            vertex.label.cex=1.2, vertex.label.color='black', 
            vertex.size=20, vertex.color='green', vertex.frame.color='blue')

#############################
# 3. 실시간 뉴스 수집과 분석
#############################

# 텍스트마이닝을 위한 패키지 설치 
# install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip")
# install.packages("Sejong")
# install.packages("wordcloud")
# install.packages("tm")
# install.packages("RSQLite")
# install.packages("hash")
# install.packages("tau")
# install.packages("httr")
# install.packages("XML")
# install.packages("rlang")

library(RSQLite)
library(KoNLP)
library(tm)
library(wordcloud)
library(httr)
library(XML)

# (1) URL 요청
url <- "https://news.naver.com/"
web <- GET(url)
web

# (2) HTML 파싱
html <- htmlTreeParse(web, useInternalNodes = T, trim=T, encoding="utf-8")
rootNode <- xmlRoot(html)
rootNode

# (3) 태그 자료 수집
# <div class="main_content_inner _content_inner">
news <- xpathSApply(rootNode, "//div[@class='main_content_inner _content_inner']", xmlValue)
news

# (4) 수집한 자료 전처리
news_pre <- gsub('[\r\n\t]', '', news) 
news_pre <- gsub('[a-z]','',news_pre)
news_pre <- gsub('[A-Z]','',news_pre)
news_pre <- gsub('\\s+',' ',news_pre)
news_pre <- gsub('[[:cntrl:]]','',news_pre)
news_pre <- gsub('[[:punct:]]','',news_pre)
news_pre <- gsub('\\d+',' ',news_pre)
news_pre

# (5) 토픽 분석
# 단어 추출
library(KoNLP)
news_noun <- extractNoun(news_pre)
news_noun

#말뭉치 생성
library(tm)
newsCorpus <- Corpus(VectorSource(news_noun))
TDM <- TermDocumentMatrix(newsCorpus, control=list(wordLengths=c(4,16)))
TDM
tdm.df <- as.data.frame(as.matrix(TDM))
dim(tdm.df)
tdm.df

wordResult <- sort(rowSums(tdm.df),decreasing =T)
wordResult

wordResult <- wordResult[-c(1:6)]

library(wordcloud)
myNames <- names(wordResult)
df <- data.frame(word=myNames, freq=wordResult)
df
pal <- brewer.pal(12,"Paired")
wordcloud(df$word, df$freq, min.freq=2, random.order=F, scale=c(4,0.7), 
          rot.per=0.1, colors=pal, family="malgun")

windowsFonts(A=windowsFont("serif"))

