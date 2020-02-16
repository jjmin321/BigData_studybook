# 빅데이터 분석 8번째 수업 - 20200216(일)

library(readxl)
library(ggplot2)
library(dplyr)

############
# < 2번째 프로젝트 - 나이에 따른 월급 차이 >
welfare <- read.csv("/users/jejeongmin/documents/r/work/welfare.csv")
View(welfare)
welfare <- welfare %>% select(-X)

#############
# < 2번째 프로젝트 - 나이에 따른 월급 차이 >
# [1단계] 변수 검토 및 전처리 (나이, 월급)
# 1-1. 나이 변수 확인 ( 결측치, 이상치 확인)
class(welfare$birth) #integer
table(welfare$birth)
summary(welfare$birth) #int형일 때는 summary로 확인하는 게 좋다.

# 출생년도에 대한 통계자료를 확인 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1907    1947    1967    1969    1989    2017 

#만약 결측치 데이터가 있다면 그에 대한 처리를 해주어야 한다.
table(is.na(welfare$birth)) # FALSE : 14923, TRUE : 0

# 출생년도에 이상치 데이터 확인 -> 조사설계서를 통해 확인 
# N(1900 ~ 2017) : 정상범위의 값
# 만약에 이상치 데이터가 존재한다면, 결측치로 변경한 다음 처리를 해주어야 함.

# 출생년도 변수로 통해 나이 파생변수를 생성 
welfare$age <- 2018 - welfare$birth + 1
summary(welfare$age)

# 1-2. 월급 변수 확인 (결측치 확인)
class(welfare$income) # integer
summary(welfare$income)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.0   140.0   212.0   263.6   342.0  4800.0   10360 

# 월급 변수의 결측치 데이터 확인 
table(is.na(welfare$income)) # FALSE : 4563, TRUE : 10360

# 월급 변수의 이상치 데이터 확인 -> 조사설계서를 통하여 확인
# N(1 ~ 9998) : 정상범위의 값
welfare$income <- ifelse(welfare$income < 1 | welfare$income > 9998, NA, welfare$income)

# 이상치를 결측치로 바꾸고 확인했더니 결측치가 7개 늘어남 , 0이 7개가 있었다.
table(is.na(welfare$income)) # FALSE : 4556, TRUE : 10367

#이상치를 결측치로 바꾼 후 통계 자료 확인 
summary(welfare$income)

# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 5.0   140.0   212.0   264.0   342.2  4800.0   10367 

# [2단계] 분석표(요약통계표)
# 2. 나이에 따른 월급 평균 분석표
age_income <- welfare %>% filter(!is.na(welfare$income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income)) 
View(age_income)
summary(age_income)
# age      mean_income    
# Min.   :19   Min.   : 10.00  
# 1st Qu.:37   1st Qu.: 79.85  
# Median :55   Median :197.22  
# Mean   :55   Mean   :194.54  
# 3rd Qu.:73   3rd Qu.:316.33  
# Max.   :91   Max.   :378.14 

# [3단계] 시각화(그래프)
# 3. 나이에 따른 월급 평균 그래프 - 선(시계열) 그래프
ggplot(data=age_income, aes(x=age, y=mean_income)) + geom_line(color = "blue") +
  geom_point(color = "red", size = 1)

# [4단계] 결과분석
# 20대 초반에는 100만 정도의 월급을 받고, 이후에 지속적으로 증가하다가 30대에는 250만 정도의 급여를 받으며, 40대 중반에 가장 많은 월급인 378만원 정도의 월급을 받으며, 50대 중반정도까지는 월급의 변화가 적다가, 50대 중반 이후로 지속적으로 감소하게 되며, 70대에는 20대초반의 월급과 비슷한 100만원 정도의 월급을 받게 되며, 80대 이후에는 50만원에도 못 미치는 월급을 받게됨을 알 수 있다.


####################################
# < 3번째 프로젝트 - 연령대에 따른 월급의 차이 >
# [1단계] 변수 검토 및 전처리 (연령대, 월급)
# 1-1. 연령대 변수 전처리 - 연령대 파생 변수 생성 
# age(나이) 변수로부터 파생변수 ageg(연령대)를 생성
# 연령대의 구분 - 초년 : 30세 미만 , 중년 : 30 ~ 60세 미만 , 노년 : 60세 이상 
# ageg - young : 초년, middle: 중년, old : 노년 
welfare$ageg <- ifelse(welfare$age < 30, "young", 
                      ifelse(welfare$age < 60, "middle", "old"))

# 연령대 변수의 빈도 확인 
table(welfare$ageg)
# middle    old  young 
# 5223   6021   3679 

# 연령대 변수의 결측치 확인 -> 결측치 데이터는 없음.
table(is.na(welfare$ageg))  #FALSE : 14923, TRUE : 0

# 1-2. 월급 변수 전처리
# 1번째, 2번째 프로젝트에서 이미 처리함.

# [2단계] 분석표(통계요약표)
ageg_income <- welfare %>% filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

# [3단계] 시각화(그래프)
ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col()

# x축의 변수명을 지정해서 나열하는 방법 (아주 많이 씀 )
ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# [4단계] 결과분석 
# 초년에는 188만원의 평균월급을 받고, 중년에는 320만원의 평균월급을 받다가, 노년에는 135만원 평균월급으로 초년보다 더 적은 평균월급을 받게 됨을 알 수 있다.


#################3
# < 4번째 프로젝트 - 나이별 성별 월급 차이 >
# [1단계] 변수 검토 및 전처리 (나이 , 성별, 월급)
# 1-1. 나이 변수 전처리 
# 2번째 프로젝트에서 이미 처리

# 1-2. 성별 변수 전처리
# 1번째 프로젝트에서 이미 처리

# 1-3. 월급 변수 전처리
# 1, 2번째 프로젝트에서 이미 처리 
View(welfare)

welfare$sex <- ifelse(welfare$sex ==1, "male", "female")
# [2단계] 분석표(통계요약표)
age_sex_income <- welfare %>% filter(!is.na(welfare$income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))
View(age_sex_income)

# [3단계] 시각화(그래프)
ggplot(data=age_sex_income, aes(x=age, y = mean_income, col = sex)) + geom_line()

# [4단계] 결과분석
# 남성의 평균월급은 40대 중반까지는 지속적으로 증가하다가 50대 중반까지 평균월급이 유지되다가 50대 중반이후로 급격한 감소를 하게 된다. 여성의 평균 월급은 30세까지는 증가하다가 50세까지 평균월급이 유지되다가 50세 이후로 급격한 감소를 하게 된다.

#####################
# < 5번째 프로젝트 - 연령대별 성별 월급 차이 >
# [1단계] 변수 검토 및 전처리 (연령대, 성별, 월급)
# 1-1. 연령대 변수 전처리 
# 3번째 프로젝트에서 이미 처리 

# 1-2. 성별 변수 전처리 
# 1번째 프로젝트에서 이미 처리 

# 1-3. 월급 변수 전처리 
# 1, 2번째 프로젝트에서 이미 처리 

# [2단계] 분석표(통계요약표)
ageg_sex_income <- welfare %>% filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))
View(ageg_sex_income)

# [3단계] 시각화(그래프) - 막대 그래프 
# 누적 막대 그래프 
ggplot(data=ageg_sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col() 

ggplot(data=ageg_sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col(position = "dodge")  + scale_x_discrete(limits = c("young", "middle", "old"))

# [4단계] 결과분석 
# 초년에는 남성이 206만원, 여성이 178만원으로 차이가 조금 밖에 나지 않지만, 중년이 되면 남성이 400만원, 여성이 220만원으로 거의 두 배 가까운 차이를 보이게 되며, 노년에는 남성이 203만원, 여성은 83.8만원으로 2배가 넘는 차이를 보이게 된다

###############
# < 6번째 프로젝트 - 직업에 따른 월급의 차이 > 
# [1단계] 변수 검토 및 전처리 (직업, 월급)
# 1-1 . 직업 변수 전처리 
class(welfare$code_job) # integer
summary(welfare$code_job)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 111.0   313.0   611.0   590.9   873.0  1012.0    7940 

# 직업 코드의 결측치 데이터 확인 
table(is.na(welfare$code_job)) # FALSE : 6983, TRUE : 7940

# code_job(직업코드) 변수를 통해서 job(직업) 파생변수를 생성
# 직종코드에 대한 직업을 가진 데이터프레임을 생성
list_job <- read_excel("/users/jejeongmin/documents/r/data1/Koweps_Codebook.xlsx", col_names= T, sheet=2)
View(list_job)
View(welfare)
# 두 개의 데이터프레임을 결합(join)
# welfare, list_job dataframe을 결합하여 job이라는 파생변수를 생성
welfare <- left_join(welfare, list_job, id = "code_job")

# 1-2. 월급 변수 전처리 
# 1, 2번째 프로젝트에서 이미 처리

# job, income 모두가 NA가 아닌 빈도를 확인 
table(!is.na(welfare$job) & !is.na(welfare$income))

# [2단계] - 분석표(통계요약표)
# 2. 직업에 따른 월급 평균의 차이 (상위 10개, 하위 10개)
# 2-1. 직업별 상위 10개의 월급평균의 차이 
job_income_top10 <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(10)
job_income_top10
# job                                  mean_income
# <chr>                                      <dbl>
# 1 보험 및 금융 관리자                         822.
# 2 의회의원 고위공무원 및 공공단체임원         765.
# 3 인사 및 경영 전문가                         752 
# 4 연구 교육 및 법률 관련 관리자               736.
# 5 제관원 및 판금원                            695.
# 6 의료진료 전문가                             686.
# 7 항공기 선박 기관사 및 관제사                634.
# 8 법률 전문가                                 631.
# 9 문화 예술 디자인 및 영상 관련 관리자        607.
# 10 통신 및 방송송출 장비 기사                  586.

# 2-2. 직업별 하위 10개의 월급의 차이
job_income_bottom10 <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(mean_income) %>% 
  head(10)
job_income_bottom10
# job                           mean_income
# <chr>                               <dbl>
# 1 기타 서비스관련 단순 종사원          79.7
# 2 청소원 및 환경 미화원                85.5
# 3 가사 및 육아 도우미                  91.0
# 4 의료 복지 관련 서비스 종사자        109. 
# 5 축산 및 사육 관련 종사자            112. 
# 6 음식관련 단순 종사원                121. 
# 7 판매관련 단순 종사원                142. 
# 8 농립어업관련 단순 종사원            142. 
# 9 큐레이터 사서 및 기록물관리사       150  
# 10 문리 기술 및 예능 강사              154.

# [3단계] 시각화(그래프) 
# 3-1. 직업별 월급 평균의 차이 - 막대 그래프 
# - 상위 10개 - 
# 세로 막대 그래프 - x축의 제목이 길어서 보기에 불편 
ggplot(data=job_income_top10, aes(x=job, y=mean_income)) + geom_col()

# 가로 막대 그래프 
ggplot(data=job_income_top10, aes(x=reorder(job, mean_income), y=mean_income)) + 
  geom_col() + 
  coord_flip()

# - 하위 10개 -
# 세로 막대 그래프 - x축의 제목이 길어서 보기에 불편 
ggplot(data=job_income_bottom10, aes(x = job, y = mean_income)) + geom_col()

# 가로 막대 그래프 
ggplot(data=job_income_bottom10, aes(x=reorder(job, mean_income), y = mean_income)) + geom_col() +
  coord_flip()

# [4단계] - 분석결과 
# 가장 많은 월급을 받는 직업은 '보험 및 금융 관리자'으로 822만원이고, 가장 작은 월급을 받은 직업은 '기타 서비스관련 단순 종사원'으로 79.7만원으로 거의 10배가 넘는 월급의 차이를 보이고 있다.