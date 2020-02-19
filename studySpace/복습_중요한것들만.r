# 복습 전용 파일 (중요한 것만 골라서)

### 1. ifelse : 데이터를 분석할 때 가장 많이 쓰이는 기초 문법 
result <- ifelse(tot >= 210, 'pass', 'fail')

### 2. for, while, repeat : 반복문을 사용해야할 때 쓰이는 기초 문법 
for(i in 1:10) {
  s <- s + i
}

while(i <= 10) {
  s <- s + i
  i <- i + 1
}

repeat { 
  s <- s + i
  i <- i + 1
  if (i > 10){
    break
  }
}

### 1. c() : combaine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터를 만드는 함수
a <- c(1, 2, 3, 4, 5)

### 2. View() : 표를 새로 만들어 데이터프레임을 정리하여 보여주는 함수 
View(mpg)

### 3. data.frame() : 데이터 프레임을 만들어주는 함수
fruit_shop <- data.frame(fruit = c("사과", "딸기", "수박", "포도", "바나나"), 
                         price = c(1500, 3000, 15000, 4500, 2500))

### 4. sum(), mean(), max(), min() : 데이터 통계 함수
sum(fruit_shop$price) #총합계
mean(fruit_shop$price) #평균
max(fruit_shop$price) #최댓값
min(fruit_shop$price) #최솟값 

### 5. within(), rename(), filter(), select(), arrange(), head(), tail(), %>%  :  [dplyr 함수]
mtcars <- within(mtcars, mc <- mpg/cyl) # mtcars에 mc라는 파생변수를 생성 
score <- rename(score, mat = math) # score에 mat를 math로 이름 변경 
score <- filter(score, class==3) # score에서 class가 3인 애들만 필터링함
score <- select(score, math, science) # score에서 math, science의 값(행)들만 가지고 온다
score <- arrange(score, math) # score에서 math를 기준으로 오름차순 정렬
score <- arrange(score, -math) # score에서 math를 기준으로 내림차순 정렬
score <- head(score, 5) # score에서 앞에서부터 값 5개만 가지고 옴 
score <- tail(score, 5) # score에서 뒤에서부터 값 5개만 가지고 옴
score %>% filter(class != 3 & math >= 60 & science >= 60) %>% 
          select(-english) %>% 
          arrange(-math, -science) # 파이프 함수를 사용하여 여러가지 함수를 같이 사용 가능




### 6. read_excel() : 엑셀 파일 불러오기 [readxl 함수]
df_exam1 <- read_excel("/Users/jejeongmin/Documents/R/data1/excel_exam.xlsx")

### 7. read.csv(), read.table() : csv, txt 파일 불러오기
df_csv_exam1 <- read.csv('../../data1/csv_exam.csv', stringsAsFactors = F) 
df_txt_data1 <- read.table('../../data2/data_ex.txt')
