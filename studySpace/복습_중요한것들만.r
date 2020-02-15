# 복습 전용 파일 (중요한 것만 골라서)

### 1. 변수 저장 하는 법 
a <- 2

### 2 c() : combaine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터를 만드는 함수
a <- c(1, 2, 3, 4, 5)

### 3. View() : view, 표를 새로 만들어 데이터프레임을 정리하여 보여주는 함수 
View(mpg)

### 4. data.frame() : dataframe, 데이터 프레임을 만들어주는 함수
fruit_shop <- data.frame(fruit = c("사과", "딸기", "수박", "포도", "바나나"), 
                         price = c(1500, 3000, 15000, 4500, 2500))
View(fruit_shop)

### 5. $ : $, 데이터 프레임의 변수를 
fruit_shop$fruit
fruit_shop$price

### 6. sum(), mean(), max(), min() : sum, mean, maximum, minimum, 데이터 통계 함수
sum(fruit_shop$price) #총합계
mean(fruit_shop$price) #평균
max(fruit_shop$price) #최댓값
min(fruit_shop$price) #최솟값 
