
#ggplot function
#(1) Setup
library(ggplot2)
head(diamonds)
dim(diamonds)
g<-ggplot(diamonds)#
class(g) #"gg" "ggplot"
ggplot(diamonds,aes(x=carat,y=price,color=cut))

#(2) Layers
g1<-ggplot(diamonds,aes(x=carat,y=price,color=cut)) +
  geom_point() +geom_smooth()

ggplot(diamonds)+geom_point(aes(x=carat,y=price,color=cut)) +
  geom_smooth(aes(x=carat,y=price))

g2<-ggplot(diamonds,aes(x=carat,y=price))+
  geom_point(aes(color=cut,shape=cut))+geom_smooth()

#(3) Labels
g3<-g1+labs(title='Scatter Plot',x="Carat",y="Price")
print(g3)

#(4) Theme
g4<-g3+theme(plot.title=element_text(size=20,face="bold"),
             axis.text.x=element_text(size=15),
             axis.text.y=element_text(size=20),
             axis.title.x=element_text(size=25),
             axis.title.y=element_text(size=15)) +
  scale_color_discrete(name="cut of diamonds") # legend title 바꾸기
print(g4)

#scale_color_discrete
#scale_color_continuous #데이터 성격에 따라 달라진다. 
#scale_shape_discrete
#scale_shape_continuous #차이 알기

#(5) Facets
g5<-g3+facet_wrap(color~cut,ncol=3)
print(g5)
g6<-g3+facet_grid(color~cut)
print(g6)

#(6) Box plot
library(datasets)
data("airquality")
head(airquality)
dim(airquality)
str(airquality)
airquality$Month<-factor(airquality$Month)

pp1 <- ggplot(airquality,aes(x=Month,y=Ozone))+
  geom_boxplot(fill="red",color="blue")
pp1

pp2<-pp1+scale_x_discrete(name="Month")+
  scale_y_continuous(name="Mean Ozone in \nparts per billion",
                     breaks=seq(0,175,25),limits=c(0,180))+
  theme_bw() #theme_bw 백그라운드 하얗게 하기
pp2


#Bonus 부분 보기
bmiukb <- data.frame(
  method = factor(c("PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR",
                    "Lasso+CTPR","PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR","Lasso+CTPR"),levels=c("PRS","PRS+MTAG","LDpred","LDpred+MTAG","MCP","Lasso","MCP+CTPR","Lasso+CTPR")),
  cohort=factor(c("NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS",
                  "NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","NHS/HPFS/PHS","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank","UKBiobank"),levels=c("NHS/HPFS/PHS","UKBiobank")),
  pred = c(0.1427,0.14123,0.2217,0.2225,0.2609,0.2796,0.2922,0.2978,
           0.2232,0.2220,0.3653,0.3583,0.3775,0.3908,0.4247,0.4284)*100,
  se = c(0.000983528,0.0009826683,0.001116853,0.001109679,
         0.001144894,0.001150417,0.001157279,0.001158628,
         0.0010686,0.001068152,0.001160714,0.001162218,
         0.001154691,0.001150587,0.001133377,0.001132073)*100
)
bmiukb
ggplot(data=bmiukb, aes(x=cohort, y=pred, fill=method)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")+ theme_bw() + 
  geom_errorbar(aes(ymin=pred-se, ymax=pred+se),width=.2,position=position_dodge(.9), colour="#606060") +
  xlab("Validation Dataset") + 
  ylab(quote(paste("Prediction ",R^2,"(%)"))) +
  labs(fill="", colour="", linetype="", title="HGT-BMI (N=436,898)") + 
  scale_fill_manual(values=c("#F3898B","#FF6666","#F9A825","#EF6C00","#42A5F5","#1976D2", "#5C6BC0","#283593")) + 
  theme(plot.title = element_text(lineheight=.8, size=16), axis.text=element_text(size=14),
        axis.title=element_text(size=14),legend.text=element_text(size=12), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
#panel부분 element_blank()

ggsave(file="bmi.pdf",width=7.5,height=7.5)
ggsave(file="bmi.jpg",dpi=200) #저장하기
getwd()



#####
#install packages
install.packages("DBI")
install.packages("rJAVA")
??rjava
install.packages("RJDBC")
library("DBI")
#C:\Program Files\Java\jre1.8.0_301
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_301")
library(rJava)
library(RJDBC)

#mysql-connector-java-8.0.27 (connector from R to MariaDB)
drv<-JDBC(driverClass = "com.mysql.cj.jdbc.Driver",
          classPath = "C:/Temp/Program/mysql-connector-java-8.0.27.jar")
conn<-dbConnect(drv,"jdbc:mysql://127.0.0.1:3306/work?serverTimezone=UTC",
                "scott","tiger")

# select 문장
dbGetQuery(conn,"select*from goods")
dbGetQuery(conn,"select code,name from goods where code=1 or code=2")

#create/ alter 문장
dbSendUpdate(conn,"create table goods1 as select *from goods")
dbSendUpdate(conn,"alter table goods1 rename to goods_original")
dbGetQuery(conn,"select * from goods_original")

#insert, update, delete 문장
dbSendUpdate(conn,"insert into goods values(5,'식기세척기',1,25000)")
dbSendUpdate(conn,"insert into goods values(6,'테스트',1,1000)")
dbGetQuery(conn,"select*from goods")
dbSendUpdate(conn,"update goods set name='테스트',where code=6")
dbSendUpdate(conn,"update goods set su=3 where code=6")
dbSendUpdate(conn,"delete from goods where code=6")

#inner/ outer/ left/ right join
dbGetQuery(conn,"select*from goods_original inner join goods on goods_original.code=goods.code")

#write table
setwd("C:/Users/dudtj/OneDrive - 숭실대학교 - Soongsil University/Desktop/전산통계1/데이터 자료/part2")
recode<-read.csv("recode.csv")
recode
class(recode)
dbWriteTable(conn,"goods_new",recode)
dbGetQuery(conn,"select * from goods_new")

#disconnect
dbDisconnect(conn)

#아래는 maria DB MySQL 사용
# Enter password: ****
#   Welcome to the MariaDB monitor.  Commands end with ; or \g.
# Your MariaDB connection id is 4
# Server version: 10.6.4-MariaDB mariadb.org binary distribution
# 
# Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
# 
# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
# 
# MariaDB [(none)]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   +--------------------+
#   4 rows in set (0.009 sec)
# 
# MariaDB [(none)]> create database work;
# Query OK, 1 row affected (0.002 sec)
# 
# MariaDB [(none)]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [(none)]> use work;
# Database changed
# MariaDB [work]> show tables;
# Empty set (0.001 sec)
# 
# MariaDB [work]> create table goods(
#   -> code int primary key,
#   -> name varchar(20) not null,
#   -> su int,
#   -> dan int);
# Query OK, 0 rows affected (0.018 sec)
# 
# MariaDB [work]> show tables
# -> ;
# +----------------+
#   | Tables_in_work |
#   +----------------+
#   | goods          |
#   +----------------+
#   1 row in set (0.001 sec)
# 
# MariaDB [work]> insert into goods values(1,'냉장고',2,850000);
# Query OK, 1 row affected (0.010 sec)
# 
# MariaDB [work]> insert into goods values(2,'세탁기',3,550000);
# Query OK, 1 row affected (0.002 sec)
# 
# MariaDB [work]> insert into goods values(3,'전자레인지',2,350000);
# Query OK, 1 row affected (0.001 sec)
# 
# MariaDB [work]> insert into goods values(3,'HDTV',3,150000);
# ERROR 1062 (23000): Duplicate entry '3' for key 'PRIMARY'
# MariaDB [work]> insert into goods values(4,'HDTV',3,1500000);
# Query OK, 1 row affected (0.001 sec)
# 
# MariaDB [work]> select * from goods;
# +------+------------+------+---------+
#   | code | name       | su   | dan     |
#   +------+------------+------+---------+
#   |    1 | 냉장고     |    2 |  850000 |
#   |    2 | 세탁기     |    3 |  550000 |
#   |    3 | 전자레인지 |    2 |  350000 |
#   |    4 | HDTV       |    3 | 1500000 |
#   +------+------------+------+---------+
#   4 rows in set (0.001 sec)
# 
# MariaDB [work]> create user 'scott'@'localhost'identified by 'tiger'
# -> ;
# Query OK, 0 rows affected (0.005 sec)
# 
# MariaDB [work]> select Host,User,Password from mysql.user;
# +-----------------+-------------+-------------------------------------------+
#   | Host            | User        | Password                                  |
#   +-----------------+-------------+-------------------------------------------+
#   | localhost       | mariadb.sys |                                           |
#   | localhost       | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | desktop-ro4riae | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | 127.0.0.1       | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | ::1             | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | %               | root        | *A4B6157319038724E3560894F7F932C8886EBFCF |
#   | localhost       | scott       | *F2F68D0BB27A773C1D944270E5FAFED515A3FA40 |
#   +-----------------+-------------+-------------------------------------------+
#   7 rows in set (0.010 sec)
# 
# MariaDB [work]> grant all privileges on work.* to 'scott'@'localhost';
# Query OK, 0 rows affected (0.001 sec)
# 
# MariaDB [work]> flush privileges;
# Query OK, 0 rows affected (0.001 sec)
# 
# MariaDB [work]> show tables;
# +----------------+
#   | Tables_in_work |
#   +----------------+
#   | goods          |
#   | goods1         |
#   | goods_new      |
#   | goods_original |
#   +----------------+
#   4 rows in set (0.003 sec)
# 
# MariaDB [work]> select * from goods_new
# -> ;
# +------+-------------+------+---------+
#   | code | name        | su   | dan     |
#   +------+-------------+------+---------+
#   |    1 | 냉장고      |    2 |  850000 |
#   |    2 | 세탁기      |    3 |  550000 |
#   |    3 | 전자레인지  |    2 |  350000 |
#   |    4 | HDTV        |    2 | 1500000 |
#   |    5 | 식기세척기  |    1 |  250000 |
#   +------+-------------+------+---------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [work]> drop table goods;
# Query OK, 0 rows affected (0.012 sec)
# 
# MariaDB [work]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [work]> yse sys;
# ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'yse sys' at line 1
# MariaDB [work]> use sys;
# Database changed
# MariaDB [sys]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   | work               |
#   +--------------------+
#   5 rows in set (0.001 sec)
# 
# MariaDB [sys]> drop database work;
# Query OK, 3 rows affected (0.037 sec)
# 
# MariaDB [sys]> show databases;
# +--------------------+
#   | Database           |
#   +--------------------+
#   | information_schema |
#   | mysql              |
#   | performance_schema |
#   | sys                |
#   +--------------------+
#   4 rows in set (0.001 sec)
# 
# MariaDB [sys]>quit;
#   bye