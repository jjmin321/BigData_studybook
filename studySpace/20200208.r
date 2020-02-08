# 빅데이터 분석 5번째 수업 - 20200208 (토)

library(readxl)
library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
midwest <- as.data.frame(ggplot2::midwest)

### dplyr 패키지의 filter(), select(), arrange() 함수를 사용하는 문제 
# 문제1) 자동차종류(class), 도시연비(cty) 변수를 추출하여 새로운 데이터프레임 mpg_class_cty를 만드시오.
mpg_class_cty <- mpg %>% select(class, cty)
View(mpg_class_cty)

# 문제2) "audi"에서 생산한 자동차 중에서 어떤 자동차 모델의 고속도로연비가 높은지 1~5위에 해당하는 자동차의 데이터를 출력하시오.
mpg_audi <- mpg %>% filter(manufacturer == 'audi') %>% arrange(desc(hwy)) %>% 
            head(5)
View(mpg_audi)

# 문제3) 자동차종류(class)가 "suv"인 자동차와 "compact"인 자동차 중에서 어떤 자동차의 연비의 평균이 더 높은지 확인하시오.
View(mpg)
mpg_classIsSuv <- mpg %>% filter(class == 'suv')
mpg_classIsCompact <- mpg %>% filter(class == 'compact')
if(mean(mpg_classIsSuv$cty) > mean(mpg_classIsCompact$cty)){
  print("suv인 자동차가 연비의 평균이 더 높다")
}else{
  print("compact인 자동차가 연비의 평균이 더 높다")
}

### 4. mutate() - 파생변수를 생성하는 함수

exam <- read_excel("../../data1/excel_exam.xlsx")
View(exam)

exam <- exam %>% mutate(tot = math + english + science, avg = tot / 3)
View(exam)

exam <- exam %>% mutate(test = ifelse(avg >= 60, 'pass', 'fail'))
View(exam)

### dplyr패키지의 filter(), select(), arrange(), mutate()함수를 활용하는 문제 
# 문제 ) mpg에서 도시연비(cty)와 고속도로연비(hwy)의 복합연비를 tot라는 파생변수로 생성하고 이 복합연비가 가장 높은 자동차의 데이터를 가장 높은 5개의 자동차 데이터를 출력하시오.
mpg <- mpg %>% mutate(tot = cty + hwy)
View(mpg)
mpg_highTot <- mpg %>% arrange(desc(tot)) %>% 
              head(5)
View(mpg_highTot)

### 5. group_by(), summarise() - 그룹별로 평균이나 그룹별 빈도와 같은 각 그룹을 요약한 값을 확인하는 함수

# 문제) mpg에서 차종별로 도시연비의 평균을 높은순으로 확인하시오.
mpg_class_desc <- mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))
View(mpg_class_desc)
# 문제) exam에서 반별로 수학점수의 평균이 높은순으로 확인하시오.
View(exam)
View(exam %>% group_by(class) %>%  summarise(mean_math = mean(math)))
exam_highMath <- exam %>% group_by(class) %>% # 반 별로 정렬하고
  summarise(mean_math = mean(math)) %>% # 반의 수학점수를 평균내고
  arrange(desc(mean_math)) # 성적이 높은순대로 정렬 
View(exam_highMath)

# summarise() 함수 안에서 사용할 수 함수
# mean() : 평균, sum() : 합계, max() : 최댓값, min() : 최솟값, median() : 중앙값, sd(): 표준편차, n() : 빈도 

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            max_math = max(math),
            min_math = min(math),
            n_math = n())

##### 확인학습 - dplyr패키지를 사용하여 데이터의 전처리(정제)
# 문제1) 회사별로 그룹을 나눈 후, 다시 구동방식(drv)별로 나누어서 도시연비(cty)의 평균을 확인하시오
View(mpg)
mpg_cty_avg <- mpg %>% group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty))
View(mpg_cty_avg)

# 문제2) 회사별로 그룹을 나눈 후, 'suv'의 데이터를 추출하고, 도시연비와 고속도로연비의 복합연비 파생변수를 생성한 후 복합연비의 평균이 높은 순으로 5건의 정보를 확인하시오.
mpg_tot_avg <- mpg %>% group_by(manufacturer) %>% filter(class == 'suv') %>% 
    summarise(mean_tot = mean(tot)) %>% 
    arrange(desc(mean_tot)) %>% 
  head(5)
View(mpg_tot_avg)  

# 문제3) 차종별로 도시연비의 평균을 높은순으로 확인하시오.
View(mpg)
mpg_high_cty <- mpg %>% group_by(model) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))
View(mpg_high_cty) 

# 문제4) 고속도로연비가 가장 높은 회사 3곳의 정보를 확인하시오.
View(mpg)
mpg_high_hwy_manufacturer <- mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)
View(mpg_high_hwy_manufacturer)              

# 문제5) 회사별로 "compact" 차종의 수를 내림차순으로 정렬하여 확인하시오.
View(mpg)
mpg_how_many_compact <- mpg %>% group_by(manufacturer) %>% 
  summarise(sum_compact = sum(class == 'compact')) %>% 
  arrange(desc(sum_compact))
View(mpg_how_many_compact)

#################################3
# 결측치 데이터를 다루는 방법
# 결측치(missing value) - 확인할 수 없는 값, 존재하지 않는 값, 알 수 없는 값
# NA - not available

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5,4,3,4,NA), stringAsFactors = F)
df
mean(df$score)

# 결측치 데이터를 확인하는 함수
is.na(df)
is.na(df$sex)
is.na(df$score)

# 결측치 데이터를 확인하는 함수
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

mean(df$score) # NA, score에 결측치 데이터가 있기 때문

### 결측치가 있는 데이터를 분석하는 방법 
# 1. 결측치 데이터를 제거하고 분석하는 방법 
# 결측치가 있는 행을 제거 - 데이터 양이 충분히 많을 때 
df %>% filter(is.na(score)) # 결측치가 있는 행을 선택
df %>% filter(!is.na(score)) # 결측치가 아닌 행을 선택 

df_1 <- df %>% filter(is.na(score)) # 결측치가 아닌 행의 데이터를 저장
df_1

mean(df_1$score) # 4. score 변수의 결측치 데이터를 제거했기 때문

# 1-2. 결측치 데이터가 여러 개의 변수에 있을 때 행을 제거 
df_2 <- df %>% filter(!is.na(sex) & !is.na(score))
df_2

# 1-3. 데이터의 모든 변수에 대해서 결측치가 있는 행을 제거
df_3 <- na.omit(df)
df_3

# 2. 결측치 데이터를 제거하지 않고 분석하는 방법
# 데이터의 양이 많지 않을 때, 하나의 데이터라도 사용해야 할 때 
# 2-1. 결측치의 값을 제외하고, 평균 합계를 구하는 방법
# na.rm = T 옵션은 na값을 제외하고 계산 
mean(df$score) # NA
mean(df$score, na.rm=T) # 4

sum(df$score) # NA
sum(df$score, na.rm = T) # 16

# 2-2. 결측치의 값을 활용하는 방법 - 결측치를 평균 값으로 대체한다.
mean(df$score, na.rm = T)
# NA값을 나머지 값의 평균값인 4로 대체하는 방법
df_copy <- df
df_copy[5, "score"] <- 4
df_copy

mean(df_copy$score)

exam <- read_excel("../../data1/excel_exam.xlsx")
View(exam)

# 2-2 연습
exam <- read_excel("../../data1/excel_exam.xlsx")
# exam의 3, 8, 15번 학생의 'math'점수를 NA데이터로 변경 
exam[c(3,8,15), "math"] <- NA

mean(exam$math)
mean(exam$math, na.rm = T)

# math의 NA값을 평균값인 55점으로 대체하는 방법
exam$math <- ifelse(is.na(exam$math), 55, exam$math)

#######################################
# 이상치(outlier) - 존재할 수 없는 값, 너무 극단적인 값(정상 범위를 벗어난 값)
# < 이상치의 데이터를 처리하는 순서 >
# 1단계 : 이상치 판별 
# 2단계 : 이상치 값을 결측치 값으로 변경
# 3단계 : 결측치 값을 처리

# 1단계 - 이상치 판별 
# 기준 - sex : 남자 = 1, 여자 = 2, 3은 이상치, score : 0 ~ 5 사이의 값, 6은 이상치
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6), stringsAsFactors = F)
mean(outlier$score) # 4, 잘못된 평균 -> 이상치 값인 6이 포함되어 있기 때문 

table(outlier$sex)

# 빈도를 통해 이상치 데이터를 판별 
table(outlier$sex)
table(outlier$score)

# 2단계 - 이상치를 결측치로 변경
outlier$sex <- ifelse(outlier$sex == 1 | outlier$sex == 2, outlier$sex, NA)
outlier$score <- ifelse(outlier$score >= 0 & outlier$score <= 5, outlier$score, NA)
View(outlier)

# 3단계 - 결측치 데이터 처리 
# 분석 작업 - 성별에 따른 점수의 평균 
outlier %>% filter(!is.na(outlier$sex) & !is.na(outlier$score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))