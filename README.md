# 📖 중요한 것들 총 정리 📖

## 🚀 R_공부한 내용 🚀

🌟2020년 1 ~ 3월동안 관심이 많은 분야였던 빅데이터에 대해 통계부터 시각화까지 공부하면서 데이터 분석에 대한 지식을 쌓을 수 있었고 이를 토대로 어떤 데이터든 처리할 수 있다는 자신감이 생기게 되었습니다. 

👨
💻StudySpace - 이 폴더는 R언어 문법과 다양한 사용법, 기술에 대해 알려줍니다. 이 경로를 통해 학습을 할 수 있습니다.

## 앞으로의 학습 목표 

1. 데이터 수집 및 전처리 : R을 통하여 데이터의 결측치와 이상치를 어떻게 처리할 것인지 고민해보고 이를 통하여 분석 및 시각화가 진행 될 수 있게 한다. 

2. 데이터 분석 및 시각화 : dplyr, ggplot2를 사용하여 데이터를 분석하고 시각화해보고 그 과정에서 중앙값, 빈도, 평균등을 통해 좀 더 심도있는 데이터 분석을 해보고 막대 그래프, 선 그래프 등 다양한 그래프를 통해 어떻게 비전공자들에게 내용을 직관적으로 전달할 수 있을지 고민해본다.

3. 머신러닝 구현 : scikit-learn을 사용하여 DecisionTree와 RandomForest등 의 분류기 등을
익힌다, 앙상블 모델, K-Fold 교차검증, 부스팅 알고리즘(XGBoost, LightGBM) 등을 익힌다

4. 딥러닝(신경망) 구현 : 구글 텐서플로나 케라스를 사용하여 신경망 구현 방법을 익힌다
Linear Regression, Logistic Regression, Classification 기법등을 익히고
CNN, RNN, DQN 등 다양한 신경망 구현 방법을 익힌다
영상이미지 인식기법을 익힌다

5. 자연언어처리 : nltk, konlpy 등을 사용하여 형태소 분석 및 토큰화와 벡터화 방법을 익히고
텍스트분석,감성분석, 챗봇구현등 자연언어처리 기법을 익힌다
BERT 와 같은 공개된 우수한 pre-training 모델을 사용하여 정확도를 올린다

6. kaggle등 국내외 다양한 데이터 과학 경진대회에 참여하여 경험을 쌓는다

## ✍️중요한 문법 ✍  
```R
########################################## 기초적이지만 중요한 것들 ##########################################
### 1. ifelse : 데이터를 분석할 때 가장 많이 쓰이는 기초 문법 
result <- ifelse(tot >= 210, 'pass', 'fail')

### 2. c() : combaine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터를 만드는 함수
a <- c(1, 2, 3, 4, 5)

### 3. View() : 표를 새로 만들어 데이터프레임을 정리하여 보여주는 함수 
View(mpg)

### 4. data.frame() : 데이터 프레임을 만들어주는 함수
fruit_shop <- data.frame(fruit = c("사과", "딸기", "수박", "포도", "바나나"), 
                         price = c(1500, 3000, 15000, 4500, 2500))

### 5. read_excel() : 엑셀 파일 불러오기 [readxl 함수]
df_exam1 <- read_excel("/Users/jejeongmin/Documents/R/data1/excel_exam.xlsx")

### 6. read.csv(), read.table() : csv, txt 파일 불러오기
df_csv_exam1 <- read.csv('../../data1/csv_exam.csv', stringsAsFactors = F) 
df_txt_data1 <- read.table('../../data2/data_ex.txt')

### 7. 결측치, 이상치 처리 
# NA는 %>% filter(!is.na(score)) [dplyr]으로 처리 
# 이상치는 boxplot(mpg$hwy)$stats [ggplot2]으로 확인후 ifelse로 NA로 변경 
```

## 💻 통계, 분석, 데이터 처리 💻
```R
############################################ 데이터 통계 함수 ############################################

### 1. table(is.na()) : NA 수를 TRUE FALSE로 알려주는 함수
table(is.na(df))

### 2. sum(), mean(), max(), min(), median(), sd(), n(): 데이터 통계 함수
sum(fruit_shop$price) #총합계
mean(fruit_shop$price) #평균
max(fruit_shop$price) #최댓값
min(fruit_shop$price) #최솟값 
median(fruit_shop$price) #중앙값 
sd(fruit_shop$price) #표준편차 
summarise(n_price = n()) #빈도 

### 3. within(), rename(), filter(), select(), arrange(), head(), tail(), group_by(), summarise(), %>%  :  [dplyr 함수]
mtcars <- within(mtcars, mc <- mpg/cyl) # mtcars에 mc라는 파생변수를 생성 
score <- rename(score, mat = math) # score에 mat를 math로 이름 변경 
score <- filter(score, class==3) # score에서 class가 3인 애들만 필터링함
score <- select(score, math, science) # score에서 math, science의 값(행)들만 가지고 온다
score <- arrange(score, math) # score에서 math를 기준으로 오름차순 정렬
score <- arrange(score, -math) # score에서 math를 기준으로 내림차순 정렬
score <- head(score, 5) # score에서 앞에서부터 값 5개만 가지고 옴 
score <- tail(score, 5) # score에서 뒤에서부터 값 5개만 가지고 옴
mpg_class_desc <- mpg %>% group_by(class) %>%  # group_by로 변수별로 정렬을 함
                  summarise(mean_cty = mean(cty)) # 정렬된 변수를 통해 새로운 값을 생성해줌
```
## 📑 데이터 시각화 그래프 📑
```R
############################################ 데이터 시각화 함수 ############################################

### 1. 산점도 - x축, y축에 점으로 데이터를 표현, 변수와 변수와의 관계를 나타낼 때 사용
ggplot(data=mpg, aes(x = displ, y = hwy)) + # 데이터, 축
      geom_point() + # 그래프의 종류 
      xlim(3, 6) + # x축의 범위 
      ylim(10, 30) # y축의 범위
```
<img width="507" src="https://user-images.githubusercontent.com/52072077/75213169-aae06900-57cc-11ea-9fff-8a2840594cf9.png">
 
```R
### 2. 막대그래프 - 데이터의 크기(값)을 막대로 표현, 그룹간의 차이를 나타낼 때 사용 

#정렬 x 
ggplot(data=mpg_drv_hwy, aes(x=drv, y=mean_hwy)) + geom_col()

#정렬 o 
ggplot(data=mpg_drv_hwy, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()
```
<img width="507" src="https://user-images.githubusercontent.com/52072077/75213179-ae73f000-57cc-11ea-886d-eddd3cf8cd7d.png">

```R
### 3. 선그래프 - 시간에 따라 변화하는 데이터를 표현할 때 주로 사용, 시계열 그래프 
ggplot(data=eco, aes(x=date, y=unemploy)) + geom_line(size=1, color="cyan")
```

<img width="507" src="https://user-images.githubusercontent.com/52072077/75213279-f3982200-57cc-11ea-8c8c-c0860380caac.png">

```R
### 4. 상자그림 - 데이터의 분포를 직사각형 형태의 상자모양으로 표현 
# 상자그림으로 데이터를 확인하면 평균을 볼 때보다 좀 더 데이터의 특징을 명확하게 파악 가능 
ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()
```

<img width="507" src="https://user-images.githubusercontent.com/52072077/75213281-f4c94f00-57cc-11ea-8466-af80c7a92793.png">

```R
### 5. 히스토그램 - 도수분포를 기둥 모양의 그래프로 표현 
ggplot(data=airquality, aes(x=Temp)) + geom_histogram(binwidth=0.5)
```

<img width="507" src="https://user-images.githubusercontent.com/52072077/75213283-f561e580-57cc-11ea-94a9-198052ae4a1d.png">
