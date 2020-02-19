# 빅데이터 분석 3번째 수업

### 데이터 파일 읽기(불러오기)/쓰기(저장)
# 2. csv 파일 읽어오기/저장하기

df_csv_exam1 <- read.csv('../../data1/csv_exam.csv', stringsAsFactors = F)
View(df_csv_exam1)
head(df_csv_exam1)
head(df_csv_exam1, 3) #앞에서부터 3개만
tail(df_csv_exam1, 3) #뒤에서부터 3개만
dim(df_csv_exam1)
class(df_csv_exam1)
df_csv_exam1 <- within(df_csv_exam1, tot <- (math+english+science))
View(df_csv_exam1)
write.csv(df_csv_exam1, file = "/users/jejeongmin/documents/r/work/df_csv_exam1.csv")
 
# 3. txt(메모장) 파일 불러오기/저장하기
  
df_txt_data1 <- read.table('../../data2/data_ex.txt')
View(df_txt_data1)
write.table(df_txt_data1, "/users/jejeongmin/documents/r/work/df_txt_exam1.txt")

library(ggplot2)
as.data.frame(ggplot2::mpg)

# 4. 외부 패키지의 데이터셋을 데이터프레임으로 저장하는 방법

################
# dplyr 패키지 - R에서 dataframe을 분석하는 다양한 함수들을 포함하고 있는 패키지
install.packages("dplyr")
library(dplyr)
library(readxl)

score <- read_excel('../../data1/excel_exam.xlsx');
View(score)

# 1. 변수명(열이름) 변경
score <- rename(score, mat = mat, eng = english, sci = science)
View(score)

# 2. 파생변수(derived variable) - 존재하는 변수로부터 새롭게생성된 변수
# 2. 파생변수 생성
score <- within(score, tot <-c(mat+eng+sci))
View(score)

# 삼항연산자 (ifelse)
score <- within(score, result <- ifelse(tot >= 210, 'pass', 'fail'))
View(score)

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

# 문제 1) mpg에서 cty와 hwy를 이용한 복합연비 tot파생변수를 생성하시오.
mpg <- within(mpg, tot <- cty+hwy)
View(mpg)

# 문제 2) mpg에서 cty를 city, hwy를 highway로 변수명을 변경하시오.
mpg <- rename(mpg, city = cty, highway = hwy)
View(mpg)
# 문제 3) tot가 30이상이면 "Excellent", 20이상이면 "Good", 20미만이라면 "Bad"라고 나타내는 eff파생변수를 생성하시오.
mpg <- within(mpg, eff <- ifelse(tot >= 30, 'Excellent',
                                 ifelse(tot >= 20, 'Good', 'Bad'))
)
View(mpg)

##########
# 데이터 결합(join)하는 방법 - dplyr 패키지 안에 함수들을 활용
# 1. 가로 결합 - left_join() 함수 : 가로 결합 시에 가장 많이 사용하는 함수
library(dplyr)
test1 <- data.frame(id = 1:5, midterm  = c(60, 80, 70, 90, 85), stringsAsFactors = F)
test2 <- data.frame(id = 1:5, finalterm = c(70, 83, 65, 95, 80), stringsAsFactors = F)
test3 <- left_join(test1, test2, by = "id")
View(test3)

# 2. 세로 결합 - bind_rows() 함수 : 세로 결합시에 가장 많이 사용하는 함수
group1 <- data.frame(id = 1:5,
                     test = c(60,80,70,90,85), stringsAsFactors = F)
group2 <- data.frame(id = 6:10,
                     test = c(70, 83, 65, 95, 80), stringsAsFactors = F)
group3 <- bind_rows(group1, group2)

#데이터 결합 함수 - 다양한 결합 함수 사용
# 1. 세로 결합(조인)
a <- data.frame(A = c("a", "b", "c"),
                B = c("t", "u", "v"),
                C = c(1,2,3), stringsAsFactors = F)
b <- data.frame(A = c("a", "b", "c"),
                B = c("t", "u", "w"),
                C = c(1, 2, 4), stringsAsFactors = F)

# 1-1 . bind_rows() - 데이터 아래에 데이터2를 세로로 합침.
ab1 <- bind_rows(a, b)
View(ab1)

# 1-2 . insersect() - 데이터 1과 데이터2중에서 같은 데이터만 합침.
ab2 <- intersect(a, b)
View(ab2)

# 1.3 . setdiff() - 데이터1을 기준으로 데이터2와 비교해서 서로 다른 데이터만 합침.

# 2. 가로 결합(조인)
A <- data.frame(id = c(1,2,3),
                locale = c('서울','부산','대구'), stringsAsFactors = F)

B <- data.frame(id = c(1, 2, 4),
                sex = c('남성', '여성', '남성'), stringsAsFactors = F)

# 2-1 . left_join() - 왼쪽 데이터를 기준으로 오른쪽 데이터를 기준컴럼(변수)로 가로로 합침.
AB1 <- left_join(A, B, by="id")
AB1

# NA - Not Available , 결측치 데이터, missing data

# 2-2 right_join() - 오른쪽 데이터를 기준으로 왼쪽 데이터를 기준컬럼(변수)로 가로로 합침.
AB2 <- right_join(A, B, by="id")
AB2 

#################################################################################
# 문제) mpg에서 fl에 해당하는 연료의 가격을 갖는 price라는 파생변수를 생성하시오.
# 1번 방법(ifelse)
View(mpg)
table(mpg$fl) # 데이터 빈도 확인하는 함수
# c : 2.35, d : 2.38, e: 2.11, p: 2.76, r: 2.22
mpg <- within(mpg, price <- ifelse(fl == 'c', 2.35, 
                              ifelse(fl =='d', 2.38,
                                 ifelse(fl == 'e', 2.11,
                                      ifelse(fl == 'p', 2.76, 2.22)
                                               ))))
View(mpg)

# 2번 방법(결합)
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price2 = c(2.35, 2.38, 2.11, 2.76, 2.22), stringsAsFactors = F)
mpg <- left_join(mpg, fuel, by="fl")
View(mpg)
#################################################################################

#################################################################################
### 조건문, 반복문, 함수
# 1. 조건문
# 1-1. if문

x <- 75

if (x>=90){
  print("A")
} else if ( x>=80 ){
  print("B")
} else{
  print("C")
}