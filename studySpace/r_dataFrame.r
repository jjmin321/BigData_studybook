# 빅데이터 분석 2번째 수업 - 20200119(일)

### 5. 데이터 프레임 (Data Frame) - 2차원 형태(직사각형, 테이블, 표)의 데이터 구조 (여러 가지 타입), 실제로 데이터 분석을 위한 구조

# 데이터 프레임을 생성하는 방법 1
# A클럽의 회원의 정보를 생성 - 10명 
id <- 1:10;
gender <- c("M", "F", "M", "F", "F", "M", "F", "M", "F", "F");
area <- c("제주", "대구", "인천", "서울", "부산", "전주", "광주", "대구", "서울", "부산")
age <- c(20, 35, 65, 45, 33, 32, 33, 71, 23, 22, 20)

member <- data.frame(id, gender, area, age)
member
class(member)
dim(member) # 데이터들이 10개씩 있고 변수는 4개가 있다. # 10행 4열 

# 데이터프레임의 정보를 확인 
View(member) # 표를 만들어서 모든 데이터를 보여줌
head(member) # 앞에서부터 6개의 데이터만 출력
head(member,8) # 앞에서부터 x개의 데이터만 출력 
tail(member) # 뒤에서부터 6개의 데이터만 출력
tail(member, 8) # 뒤에서부터 x개의 데이터만 출력
summary(member) # 데이터를 각 변수별로 요약해서 확인 

# 데이터프레임에 각 변수의 정보를 확인
member$id
member$gender
member$area
member$age
mean(age)

# 문제 ) member의 정보에서 지역정보만 ma로 저장하시오.
ma <- member$area


# 데이터프레임을 생성하는 방법 2
# 과일가게에서 과일의 가격과 수량 정보를 생성 
fruit_shop <- data.frame(fruit = c("사과", "딸기", "수박", "포도", "바나나"), 
                         price = c(1500, 3000, 15000, 4500, 2500),
                         volume = c(30, 25, 13, 27, 40))
fruit_shop
View(fruit_shop)

# 통계 함수
sum(fruit_shop$volume) #과일의 갯수의 총합계
mean(fruit_shop$price) #과일의 가격의 평균
max(fruit_shop$volume) #과일 재고량의 최댓값
min(fruit_shop$price) #과일 가격의 최솟값 

###### 패키지를 설치/부착/확인/제거
# ggplot2 패키지 - 시각화를 위한 다양한 함수를 내장하는 패키지, 다양한 데이터셋(dataset)을 포함하는 패키지

# install.packages() 패키지 설치
# installed.packages() 패키지 설치 확인 

install.packages("ggplot2") # ggplot2 패키지 설치
library(ggplot2) # ggplot2 사용 

detach("package:ggplot2") # ggplot2 미사용 
installed.packages()
# update.packages() 설치된 모든 패키지 자동 업데이트 

mpg <- as.data.frame(ggplot2::mpg)
View(mpg) # 표 만들어서 보여주는 함수 
dim(mpg) # 행, 렬 알려주는 함수

# 도움말 보기
help(mpg)
?mpg
head(mpg, 5)
tail(mpg, 5)
mpg$hwy

mtcars <- mtcars # mtcars : R에 내장되어 있는 데이터 프레임 
View(mtcars)

### 생성된 데이터프레임에 열(변수) 추가/삭제/수정
# B클럽 회원의 신장 정보를 생성하는 데이터프레임 
df1 <- data.frame(name=c("kim", "Lee", "Park", "kang", "Han"),
                  age=c(33, 25, 41, 52, 29),
                  height=c(180, 178, 172, 176, 185), stringsAsFactors = FALSE)
df1
View(df1)
dim(df1)
df1[3,] # 3행만 출력 
df1[4,2] # 4행 2열만 출력 
df1[4,3] <- 173 # 값 변경 
df1[4,3]
df1[5, ] <- c("pong", 30, 175)
df1[5, ]
df1[6, ] <- c("choi", 45, 176)
View(df1)
df1[-3,] # 3행 정보를 제외하고 확인
df2 <- df1[-3, ]
df1[,c(2,3)] # 2, 3열의 정보를 확인 

mtcars <- mtcars
class(mtcars)
dim(mtcars)

# mpg를 cyl로 나눈 결과를 저장
mt1 <- mtcars$mpg/mtcars$cyl
View(mt1) #1번 방법 (주로 사용)
mt2 <- with(mtcars,mpg/cyl)
View(mt2) #2번 방법

# 데이터프레임에 새로운 열(변수) 생성하여 저장
# 파생변수를 생성하는 방법 
mtcars <- within(mtcars, mc <- mpg/cyl)
View(mtcars)

### 연산자(operator) 정리
x <- 1:5
x2 <- 6:10
x3 <- 1:7

# 1. 산술 연산자 : +, -, *, /, %/%(몫), %%(나머지), ** === ^ (제곱)
x1 + 3
x1 - 3
x1 * 3
x1 / 3
x1 %/% 3
x1 %% 3
x1^3
x1 ** 3

# 2. 비교 연산자 : >, <, >=, <=, ==, !=, 결과는 항상 논리형(TRUE, FALSE)
x4 <- c(3,2,5,4,1)
x1 > x4
x1 >= x4
x1 < x4
x1 == x4
x1 != x4

# 3. 논리 연산자 : &(AND), |(OR)
# & : 모두 참일때 전체 결과가 참 
# | : 그 중에서 하나만 참이라도 전체 결과가 참
x1 > 3 & x1 < 5 # 3보다 크고 5보다 작은 경우 참
x1 > 3 & x1 < 5 # 3보다 크거나 5보다 작으면 참 

#################

### 데이터 타입 읽기(불러오기)/쓰기(저장)
# 1. 엑셀(xls, xlsx) 파일 읽기/쓰기 
# readx1 패키지 : 엑셀 패키지, 읽기만 가능 
install.packages("readxl")
library("readxl")

df_exam1 <- read_excel("/Users/jejeongmin/Documents/R/data1/excel_exam.xlsx")
df_exam1
View(df_exam1)
dim(df_exam1)

df_exam2 <- read_excel("/Users/jejeongmin/documents/r/data1/excel_exam_novar.xlsx") # 첫 줄을 열 제목으로 인식
View(df_exam2)

df_exam3 <- read_excel("/Users/jejeongmin/documents/r/data1/excel_exam_novar.xlsx", col_names = FALSE)
View(df_exam3)

# 1-2 xlsx 패키지 : 엑셀 파일 읽기/쓰기, 다양한 옵션을 활용
# 주의) 자바 프로그램으로 만들어져있어 jdk를 설치해야 사용할 수 있다. 
install.packages("xlsx")
library("xlsx")

df_exam4 <- read_xlsx("/users/jejeongmin/documents/r/data1/excel_exam.xlsx", sheetIndex = 1)

df_exam5 <- read_xlsx("/users/jejeongmin/documents/r/data1/excel_exam_novar.xlsx", sheetIndex = 1)
View(df_exam5)

df_exam6 <- read.xlsx("/users/jejeongmin/documents/r/data1/excel_exam_novar.xlsx", sheetIndex = 1, header = F)

class(df_exam6)
dim(df_exam6)

# 문제 ) df_exam1에서 math, english, science를 더해서 tot, mean이라는 파생변수를 만들어라

View(df_exam1)
df_exam1 <- within(df_exam1, tot <- math+english+science)
df_exam1 <- within(df_exam1, mean <- (math+english+science)/3)
View(df_exam1)

# 데이터프레임을 엑셀파일로 저장
write.xlsx(df_exam1, file = "/users/jejeongmin/documents/r/data1/excel_exam.xlsx")