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
View(mpg)
mpgNahwy <- mpg %>% filter(is.na(hwy))
View(mpgNahwy)
# 문제2) 어떤 구동 방식의 고속도로연비의 평균이 높은지 확인하시오. 
whatIsHigherThan_drv <- mpg %>% group_by(drv) %>% 
  filter(!is.na(hwy)) %>% 
  summarise(mean_hwy = mean(hwy)) 
  
View(whatIsHigherThan_drv)
