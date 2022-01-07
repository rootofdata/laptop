install.packages("multilinguer")
library(multilinguer)
install_jdk()

#Step2. 의존성 패키지 설치하기
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")

#Step3. github 버전 설치하기
install.packages("remotes")

#Step4. KoNLP 설치하기(64bit에서만 동작)
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP)
#Test
extractNoun('안녕하세요.')
[출처] [R STUDIO] KoNLP 패키지 설치하기 (feat. 오류를 해결해보자)|작성자 홍긍지
library(tm)
library(sessioninfo)
library(devtools)
install.packages("rJava")
install.packages("NLP")
install.packages("wordcloud")
install.packages("slam")
install.packages("Sejong")
install.packages("hash")
install.packages("tau")
