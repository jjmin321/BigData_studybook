# 빅데이터 분석 4번째 수업 - 20200202(일)

# Switch문

x <- "two"

switch(x, "one" = 1, "two" = 2, "three" = 3, 4)

# 사용자 정의 함수 생성
# 함수
fn_score <- function(age) {
  print(ifelse(age >= 70, "노년", 
               ifelse(age >= 40, "중년", 
                      ifelse(age >= 20, "청년", "소년")
               )))
}

fn_score(60)

# 반복문 
# for, while, repeat
# 2-1 for문 
s <- 0
for(i in 1:10) {
  s <- s + i
}

# 2-2 while문 
s <- 0
i <- 1
while(i <= 10) {
  s <- s + i
  i <- i + 1
}

# 2-3 repeat문 - 조건 반복이 아닌 무한 반복 
# break 문이랑 사용 
s <- 0
i <- 1
repeat {
  s <- s + i
  i <- i + 1
  if (i > 10){
    break
  }
}

## 반복문(for문) 연습
# 1. 1부터 100까지 출력
s <- 0
repeat{
  s <- s + 1
  print(s)
  if(s >= 100){
    break
  }
}

# 2. 문자 벡터를 값들을 차례대로 출력 
str <- c('고하늘', '박성순', '배명수', '백승수', '김사부')
for (i in str) {
  print(i)
}

# 3. 1부터 100까지의 정수 중에서 홀수를 출력
for (i in 1:100){
  if (i %% 2 != 0){
    print(i)
  }
}

# 4. 1부터 100까지의 정수 중에서 3의 배수이면서 4의 배수인 수를 출력 
for (i in 1:100){
  if (i %% 3 == 0 & i %% 4 == 0){
    print(i)
  }
}

# 5. 1부터 100까지의 정수중에서 5의 배수거나 7의 배수인 수를 출력
for (i in 1:100){
  if (i %% 5 == 0 || i %% 7 == 0){
    print(i)
  }
}

# 6. 1부터 10까지의 정수중에서 7이 되었을 때 반복문을 탈출
for (i in 1:10){
  if (i == 7){
    print(i)
    break
  }
}

# 7. 1부터 10까지의 정수중에서 5를 제외한 값을 출력
for(i in 1:10){
  if (i == 5){
    next
  }
  print(i)
}

### 2. 사용자 함수 정의 - 반복문을 활용
# 문제) 1부터 n까지를 출력하는 함수를 생성하고, 활용
fn_loop <- function(x){
  for (i in 1:x){
    print(i)
  }
}
fn_loop(10)

###################

library(readxl)
library(ggplot2)
library(dplyr)

midwest <- as.data.frame(ggplot2::midwest)
View(midwest)

# 1. midwest에서 poptotal 변수를 total, popasian 변수를 asian으로 바꾸시오.

midwest <- rename(midwest, total = poptotal, asian = popasian)
View(midwest)

# 2. total, asian 변수를 이용하여 '전체 인구 대비 아시아 인구의 백분율'을 나타내는 파생변수 ratio를 생성하시오.
midwest <- within(midwest, ratio <- asian/total*100)
View(midwest)

# 3. 아시아 인구 백분율 전체 평균을 구하는 파생변수 average를 만들고, 이 평균을 초과하면 'large', 그 외에는 'small'이라는 값을 대입하는 파생변수 group을 생성하시오.
midwest$average <- mean(midwest$ratio)
View(midwest)
midwest$group <- ifelse(midwest$ratio > midwest$average, 'large', 'small')
View(midwest)

# 4. 'large'와 'small'에 해당하는 지역이 얼마나 되는지 빈도표와 빈도 막대 그래프를 그리시오.
table(midwest$group)
qplot(midwest$group)

###############3# 데이터 가공
exam <- read_excel("../../data1/excel_exam.xlsx")
View(exam)

# 1. filter()함수 - 조건에 따른 행(데이터, 레코드)를 추출 (dplyr패키지 안에 있음)
# %>% - 디플라이어 패키지에서 사용하는 연산자, 파이프 연산자, 체인 연산자 
# %in# - 매칭 연산자 
exam_ClassThree <- exam %>% filter(class == 3)
exam_GeniusAtMath <- exam %>% filter(math >= 70)
exam_ClassNotOne <- exam %>% filter(class != 1)
exam_ClassOneThreeFive <- exam %>% filter(class == 1 | class == 3 | class == 5)
exam_ClassOneThreeFive2 <- exam %>% filter(class %in% c(1,3,5))
exam_GeniusAtMathAndScience <- exam %>% filter(math >= 60 & science >= 70) 

# 문제 1) 1반과 2반의 학생 정보를 확인할 수 있는 class12 라는 데이터프레임을 생성하시오.
class12 <- exam %>% filter(class == 1 | class == 2)
class12

# 문제 2) 수학, 영어, 과학 점수가 모두 60점 이상인 학생의 정보
classGenius <- exam %>% filter(math >= 60 & english >= 60 & science >= 60)
classGenius

mpg <- as.data.frame(ggplot2::mpg)
# 문제1) 자동차 배기량(displ)에 따라 고속도로 연비가 다른지 확인하고자 할 때, 배기량이 4이하인 자동차와 배기량이 5이상인 자동차 중에서 어떤 자동차의 고속도로 연비(hwy)가 평균적으로 더 높은지 확인하시오.
exam_lowDispl <- mpg %>% filter(displ <= 4)
View(exam_lowDispl)
exam_highDispl <- mpg %>% filter(displ >= 5)
View(exam_highDispl)
if(mean(exam_lowDispl$hwy) > mean(exam_highDispl$hwy)){
  print("배기량이 4이하인 자동차의 고속도로 연비가 더 높다")
}else{
  print("배기량이 5이상인 자동차의 고속도로 연비가 더 높다")
}
# 문제2) 자동차 제조회사에 따라 도시연비가 다른지 확인하고자 할 때, "audi"와 "toyota"중에서 어느 자동차 제조회사의 도시연비가 평균적으로 더 높은지 확인하시오.
exam_audi <- mpg %>% filter(manufacturer == 'audi')
View(exam_audi)
exam_toyota <- mpg %>% filter(manufacturer == 'toyota')
View(exam_toyota)
if(mean(exam_audi$cty) > mean(exam_toyota$cty)){
  print("아우디의 도시연비가 더 높다")
}else{
  print("토요타의 도시연비가 더 높다")
}
# 문제3) "chevrolet", "ford", "honda" 3개 제조회사의 자동차의 고속도로 연비의 평균을 확인하고자 할 때 , 이 회사의 데이터를 추출하여 저장한 후 , 고속도로연비의 전체 평균을 구하시오.
exam_chevrolet <- mpg %>% filter(manufacturer == 'chevrolet')
View(exam_chevrolet)
exam_ford <- mpg %>% filter(manufacturer == 'ford')
View(exam_ford)
exam_honda <- mpg %>% filter(manufacturer == 'honda')
View(exam_honda)
exam_averageHwy <- mean(mean(exam_chevrolet$hwy), mean(exam_ford$hwy), mean(exam_honda$hwy))
print(exam_averageHwy)

# select() 함수 - 구하고자 하는 열(변수) 추출 
exam %>% select(math, science)
exam %>% select(class, english, science)
exam %>% select(-id, -english)
exam %>%  select(-english) %>% filter(class == 1 | class ==2)
exam %>% filter(class %in% c(1,2,3) & math >= 60 & science >= 60) %>% select(class, math, science)

### arrange() 함수 - 행을 정렬하는 함수(오름차순, 내림차순)
exam %>% arrange(desc(english)) %>%
head(5)

# 문제) 3반이 아니며 수학,과학 점수가 60점이상인 학생 중 영어 점수를 제외하고, 수학점수를 기준으로 내림차순 정렬하고, 수학점수가 같다면 과학점수를 기준으로 내림차순 정렬하라.
exam %>% filter(class != 3 & math >= 60 & science >= 60) %>% 
  select(-english) %>% 
  arrange(-math, -science) 
