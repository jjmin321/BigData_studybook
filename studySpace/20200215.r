# 빅데이터 분석 7번째 수업 - 20200215(토)

library(readxl)
library(ggplot2)
library(dplyr)

##### 시각화 응용
# 7. 그래프를 강조하는 방법 1 - 도형, 화살표, 텍스트
# 자동차 무게(wt)에 따른 효율(mpg)를 산점도로 효율
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point() +
  annotate("rect", xmin=3, xmax=4, ymin=12, ymax =21, fill="cyan", alpha = 0.5) + 
  annotate("segment", x=2.5, xend=3.7, y=10, yend=17, color="pink", arrow=arrow()) +
  annotate("text", x=2.5, y=10, label="Important", color = "orange") +
  annotate("text", x=3.8, y=18, label="granduer 2020", color = "red", size = 3)

# 8. 그래프를 강조하는 방법 2 막대그래프에서 활용 
# 기어 갯수별 자동차 수를 표현 
ggplot(data=mtcars, aes(x=gear)) + geom_bar() +
  labs(x="기아수", y="자동차수", title="기어수별 자동차수")

# 다양한 테마를 적용 - gray, bw, minimal, classic ...
ggplot(data=mtcars, aes(x=gear)) + geom_bar() +
  labs(x="기아수", y="자동차수", title="기어수별 자동차수") +
  theme_minimal()

##### 인터렉티브 그래프를 만드는 방법 
# plotly 패키지 - ggplot2에서 생성한 그래프를 인터렉티브하게 만들어주는 패키지 
install.packages("plotly")
library(plotly)

mpg <- as.data.frame(ggplot2::mpg)
# 배기량에서 구동방식을 추가하여 고속도로연비와의 관계를 산점도로 표현하는 그래프 
# 1번 
ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) + geom_point()
ggplotly(ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) + geom_point())
# 2번 
graph_hwy <- ggplot(data=mpg, aes(x=displ, y=hwy, col=drv)) + geom_point()
ggplotly(graph_hwy)

dia <- diamonds
View(dia)
#다이아몬드 커팅에 따른 선명도를 누적해서 표현 
d <- ggplot(data=dia, aes(x=cut, fill=clarity)) + geom_bar()
ggplotly(d)

#다이아몬드의 커팅에 따른 선명도를 따로 분리해서 표현 
ggplot(data=dia, aes(x=cut, fill=clarity)) + geom_bar(position = "dodge")

# 10. 인터렉티브 그래프를 만드는 방법 
# dygraphs - 시계열 그래프를 인터렉티브하게 만들어주는 그래프 
install.packages("dygraphs")
library(dygraphs)

eco <- economics
View(eco)

# dygraphs 패키지를 활용할 때 주의할 점 
# - 데이터의 시간 순서의 속성을 xts 데이터타입으로 설정되어 있어야만 함.
install.packages("xts")
library(xts)

# 시간에 따른 실업률을 xts형식으로 저장
eco2 <- xts(eco$unemploy, order.by = eco$date)
View(eco2)

dygraph(eco2) %>% dyRangeSelector()

# 시간에 따른 저축률을 xts형식으로 저장 
eco3 <- xts(eco$psavert, order.by = eco$date)
View(eco3)
dygraph(eco3) %>% dyRangeSelector()

# 시간에 따른 실업률과 저축률을 하나의 그래프에 표현 
# 실업률과 저축률의 x축의 단위를 일치시켜야함.
# 실업률을 1000으로 나누어서 다시 저장함.

eco4 <- xts(eco$unemploy/1000, order.by = eco$date)
View(eco4)

# 실업률과 저축률을 하나의 그래프로 표현 
eco_merge <- cbind(eco3, eco4) # eco3 : 저축률, eco4 : 실업률 
View(eco_merge)

# 컬럼명 변경 
# eco3 : 저축률, eco4 : 실업률 
colnames(eco_merge) <- c("저축률", "실업률")
View(eco_merge)

dygraph(eco_merge) %>%  dyRangeSelector()

###########################################################################
# 한국복지패널 - 전 국민의 표본(15000건)을 수백가지의 변수를 통해 조사한 내용을 참고
# foreign 패키지 - spss 데이터를 R에서 데이터프레임으로 가져와서 사용할 수 있도록 해주는 패키지
install.packages("foreign")
library(foreign)

raw_welfare <- read.spss("/Users/jejeongmin/documents/r/work/Koweps_hpc13_2018_beta1.sav", to.data.frame = T)
welfare <- raw_welfare

# 가공할 데이터를 다양한 형식의 파일로 저장 
write.table(welfare, "/Users/jejeongmin/documents/r/work/welfare.txt") # txt 파일로 저장
write.csv(welfare, "/Users/jejeongmin/documents/r/work/welfare.csv") # csv 파일로 저장

# welfare 데이터 확인 
View(welfare)
class(welfare) # "data.frame"
dim(welfare) # [1] 14923 1026

############### 준비 작업 
# 1. 분석할 데이터에서 사용할 변수 추출  - 
# 성별, 출생년도 ,종교유무,  결혼여부, 월급, 직업, 지역 
# 성별 - h13_g3 -> sex
# 출생년도 - h13_g4 -> birth
# 결혼여부 - h13_g10 -> marriage
# 종교유무 - h13_g11 -> religion
# 월급 - p1302_8aq1 -> income
# 직업 - h13_eco9 -> code_job
# 지역 - h13_reg7 -> code_region

# 분석에 사용할 7개 변수를 추출 
welfare <- welfare %>% select(h13_g3, h13_g4, h13_g10, h13_g11, p1302_8aq1, h13_eco9, h13_reg7)
View(welfare)

# 분석에 사용할 7개의 변수명 변경 
welfare <- rename(welfare, sex=h13_g3, birth=h13_g4, marriage=h13_g10, religion=h13_g11, income = p1302_8aq1, code_job = h13_eco9, code_region=h13_reg7)

# 변수 추출, 변수명 변경 -> 파일로 저장 
write.csv(welfare, "/users/jejeongmin/documents/r/work/welfare.csv")

##############
# < 1번째 프로젝트 - 성별에 따른 월급의 차이 >
# [1단계] 변수 검토 및 전처리 (성별, 월급)
# 1-1. 성별 변수 확인 (결측치, 이상치 확인)
# 성별의 빈도 - 1: 남성, 2: 여성 = 6749, 8174
table(welfare$sex)
# FALSE : 14923, TRUE : 0 -> 성별 변수에는 결측치, 이상치 데이터는 존재하지 않음 
# 만약에 이상치가 있었다면 -> 결측치를 바꾸고, 분석할 때 제외 
table(is.na(welfare$sex)) 

# 성별 변수의 값을 변경 - 1: male, 2:female
welfare$sex <- ifelse(welfare$sex==1, "male", "female")

# 성별의 빈도 
table(welfare$sex) # female : 8174, male: 6749

# 성별의 빈도 - 그래프 
qplot(welfare$sex)

# 1-2. 월급 변수 확인 (결측치, 이상치 확인) 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.0   140.0   212.0   263.6   342.0  4800.0   10360 
summary(welfare$income)
table(is.na(welfare$income)) # FALSE : 4563, TRUE : 10360 -> 결측치가 10360

# 이상치 데이터 판별 -> 이상치를 결측치로 변경
# 1 ~ 9998 사이의 값이 정상적인 값 
welfare$income <- ifelse(welfare$income < 1 | welfare$income > 9998, NA, welfare$income)
table(is.na(welfare$income)) # FALSE : 4556, TRUE : 10367

# [2단계] 분석표(통계요약표)
# 2. 성별 별 월급의 평균 분석표 
sex_income <- welfare %>% filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income)) 
sex_income

# [3단계] 시각화(그래프)
# 3. 성별에 따른 월급 그래프 - 막대 그래프 
ggplot(data=sex_income, aes(x=sex, y=mean_income)) + geom_col()

# [4단계] 분석 결과
# 남성은 평균 347만원, 여성은 평균 179만원의 월급을 받고 있으며, 남성이 여성의 약 2배에 가까운 월급을 받고 있음을 알 수 있습니다.

