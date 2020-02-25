# 빅데이터 분석 6번째 수업 - 20200209(일)

library(readxl)
library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)

### 확인학습 - 결측치 데이터 처리 
# 결측치 데이터 삽입
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
View(mpg)

# 문제1) 구동방식별로 고속도로연비의 평균이 어떻게 다른지 확인하려고 할 때, 결측치 데이터를 확인하시오.
mpgNahwy <- mpg %>% filter(is.na(hwy))
View(mpgNahwy)
# 문제2) 어떤 구동 방식의 고속도로연비의 평균이 높은지 확인하시오. 
whatIsHigherThan_drv <- mpg %>% group_by(drv) %>% 
  filter(!is.na(hwy)) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))
  
View(whatIsHigherThan_drv)

### 이상치 데이터를 판별하는 방법
# 박스플롯(boxplot, 그림상자) - 데이터를 4등분해서 그림으로 표현해주는 그래프
# 밑에서부터 하위 극단치 경계 0%, 1분위수(25%), 2분위수(50%): 중앙값, 3분위수(75%), 상위 극단치(100%), 하위 극단치와 상위 극단치의 경계를 벗어나는 지점의 값(이상치)

# 1단계 : 이상치를 판별
boxplot(mpg$hwy) # 그래프로만 확인 
# 분위수의 값을 통해서 이상치를 판별
boxplot(mpg$hwy)$stats # 분위수의 값을 확인 
# 0%, 25%, 50%, 75%, 100%
# 12 18 25 27 37
# 2단계 : 이상치를 결측치로 변경 
mpg$hwy <- ifelse(mpg$hwy<12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy)) # 결측치 3개 증가 

# 3단계 : 결측치를 제외하고 분석
# 구동방식별로 고속도로연비의 평균을 확인

mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))

############### 
# 시각화 - ggplot2 패키지에 있는 다양한 함수들을 통해서 시각화 학습
# 분석에서 결과를 보여주는 가장 마지막 작업, 가장 효율적인 방법

### 1. 산점도 - x축, y축에 점으로 데이터를 표현, 변수와 변수와의 관계를 나타낼 때 사용
# 배기량(displ)별 고속도로 연비를 산점도로 표현하시오.
ggplot(data=mpg, aes(x = displ, y = hwy)) + # 데이터, 축
  geom_point() + # 그래프의 종류 
  xlim(3, 6) + # x축의 범위 
  ylim(10, 30) # y축의 범위

### 2. 막대그래프 - 데이터의 크기(값)을 막대로 표현, 그룹간의 차이를 나타낼 때 사용 
# 구동방식별  고속도로연비의 평균을 막대그래프로 표현
table(is.na(mpg$drv)) # NA가 없음 
table(is.na(mpg$hwy)) # NA가 없음 
# 이상치 판별 
boxplot(mpg$hwy)$stats
mpg$hwy <- ifelse(mpg$hwy<12 | mpg$hwy>37, NA, mpg$hwy)
table(is.na(mpg$hwy)) # NA : 3, 이상치 -> 결측치 

mpg_drv_hwy <- mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))
mpg_drv_hwy 

#정렬 x 
ggplot(data=mpg_drv_hwy, aes(x=drv, y=mean_hwy)) + geom_col()

#정렬 o 
ggplot(data=mpg_drv_hwy, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()

### 3. 막대 그래프 - 빈도를 나타내는 그래프
# 예) 구동방식에 따른 자동차의 수를 막대 그래프로 표현
ggplot(data = mpg, aes(x=drv)) + geom_bar()

# geom_col() 함수를 활용 -> 정렬이 가능
mpg_drv_count <- mpg %>% group_by(drv) %>% 
  summarise(count = n()) 
mpg_drv_count

ggplot(data=mpg_drv_count, aes(x=reorder(drv, count), y=count)) + geom_col()
### 막대 그래프 : 값(요약 정보: 평균, 합계) -> geom_col()
# 막대 그래프 : 빈도(누적한 수) -> geom_bar()

### 확인학습 - 산점도, 막대그래프
# 문제1) mpg에서 도시연비와 고속도로연비 간에 어떤 관계가 있는지 살펴보려고 합니다. 산점도 그래프로 확인하시오.
mpg_geom_point <- ggplot(data=mpg, aes(x = cty, y = hwy)) +
                  geom_point() 
mpg_geom_point

# 문제2) midwest에서 전체인구와 아시아 인구 간에 어떤 관계가 있는지 살펴보려고 합니다. x축은 전체인구, y축은 아시아인구로 구성된 산점도 그래프를 만들어 확인하시오.
midwest <- as.data.frame(ggplot2::midwest)
midwest_geom_point <- ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
                      geom_point() +
                      xlim(0, 500000) +
                      ylim(0, 10000)
midwest_geom_point

# 문제3) mpg에서 어떤 회사에서 생산한 "suv"차종의 도시연비가 높은지 확인하려고 합니다. "suv"차종을 대상으로 도시연비의 평균이 가장 높은 회사 5곳을 막대그래프로 표현하시오. 막대는 도시연비가 높은 순으로 정렬하여 표현하시오.
mpg_avg_cty <- mpg %>% group_by(manufacturer) %>%
  filter(class == 'suv') %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(5)
View(mpg_avg_cty)
#
ggplot(data = mpg_avg_cty, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()
# 문제 4) mpg에서 자동차 중에서 어떤 차종이 많은지 확인하려고 합니다. 자동차 종류별 빈도를 표현한 막대그래프를 만들어 확인하시오.
# geom_bar : 쓰기 편한데 정렬 안됨 
ggplot(data = mpg, aes(x=class)) + geom_bar()
# geom_col : 쓰기 어려운데 정렬 됨 
mpg_class <- mpg %>% group_by(class) %>% 
  summarise(count = n())
mpg_class
ggplot(data=mpg_class, aes(x=reorder(class,-count), y=count)) + geom_col()


### 4. 선그래프 - 시간에 따라 변화하는 데이터를 표현할 때 주로 사용, 시계열 그래프 
# ex) 날씨, 주식, 환율, 부동산 가격 ....
# 1967 ~ 2015 년 까지의 소비율, 저축율, 실업율 등에 관한 정보를 담고 있는 데이터셋
eco <- economics

# 시간에 따라 실업자 수와 증감 추이를 선그래프로 표현 
ggplot(data=eco, aes(x=date, y=unemploy)) + geom_line()

# 시간에 따라 개인별 저축률의 증감 추이를 선그래프로 표현 
View(eco)
ggplot(data=eco, aes(x=date, y=psavert)) + geom_line(size=2, color="orange")

### 5. 상자그림 - 데이터의 분포를 직사각형 형태의 상자모양으로 표현 
# 상자그림으로 데이터를 확인하면 평균을 볼 때보다 좀 더 데이터의 특징을 명확하게 파악 가능 

# 예) 구동방식별 고속도로연비를 상자그림으로 표현
ggplot(data =mpg, aes(x=drv, y=hwy)) + geom_boxplot()

### 확인학습 - 선그래프, 상자그림 
# 문제) 날짜에 따라 온도의 변화를 선그래프로 나타내시오.
View(airquality)
airquality <- within(airquality, date <- Month*100+Day)
View(airquality)
ggplot(data=airquality, aes(x=date, y=Temp)) + geom_line(size=1, color = "cyan")

##########
#### 응용 그래프 
mtcars <- mtcars
# 1. 누적 막대 그래프 
# 실린더 종류별 빈도를 파악하여, 기어를 누적 막대 그래프로 표현 
ggplot(data=mtcars, aes(x=cyl)) + geom_bar() # 실린더별 빈도를 표현 

# 2. 선버스트 그래프
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(aes(fill=factor(gear))) + coord_polar()

# 3. 원형 그래프 
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(aes(fill=factor(gear))) + coord_polar(theta="y")

# 4. 히스토그램 - 도수분포를 기둥 모양의 그래프로 표현 
# 온도의 변화를 도수 분포로 표현 
ggplot(data=airquality, aes(x=Temp)) + geom_histogram(binwidth=0.5)

# 5. 선그래프의 응용 
# 시간에 따른 저축률의 변화 - 기울기, y절편 활용 
# y절편 : intercept - 12.18671, 기울기 : slope - -0.000544
ggplot(data=eco, aes(x=date, y=psavert)) + geom_line() + geom_abline(intercept = 12.18671, slope = -0.000544)          

# 시간에 따른 저축률의 변화 - 저축률의 평균 수평선을 활용 
ggplot(data=eco, aes(x=date, y=psavert)) + geom_line() + geom_hline(yintercept = mean(eco$psavert))
