# 빅데이터 분석 1번째 수업 - 20200118(토)

# 변수(variable) - 값을 저장하는 공간

a = 10 #1번 방법
b <- 30 #2번 방법 - 최근 경향
B <- 50 #소문자와 대문자는 다름

rm(a) #변수 1개 삭제하는 방법 
rm(list = ls()) #변수 모두 삭제하는 방법

#데이터 타입(type) : 자료형
# 1. 숫자 : 정수, 실수
# 2. 문자 : "". ''
# 3. 논리 : true,false
# 4. 범주(factor) : 범주형으로 다루는 데이터 ex) 남, 여 , 군필, 미필
# 5. 날짜(as.date)
# 6. 날짜, 시간(as.POSIXct) 

x1 <- 10
class(x1)
typeof(x1)
x2 <- 10.5
class(x2)
x3 <- "10"
class(x3)

x4 <- factor(c("male", "female", "male", "female", "male"))
x5 <- as.Date("2020-12-25")
class(x5)

x6 <- as.POSIXct("2020-09-27 13:33:25")
class(x6)
rm(list = ls())

## 데이터 구조 

# 1. * Vertor(백터) * - 동일형, 1차원 - c() 로 만듦
# 2. Matrix(행렬) - 동일형, 2차원
# 3. Array(배열) - 동일형, 3차원 이상
# 4. List(리스트) - 다중형, 1차원
# 5. ***Data Frame(데이터 프레임) *** - 다중형. 2차원

#       |    1차원  |   2차원 |   다차원(3차원 이상)    |
#  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 동일형 |   *백터*  |     행렬  |        배열           |
#  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 다중형 |   리스트  |  @데이터프레임@ |       X           |
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

# Vertor(백터) : 동일한 데이터 타입의 값을 일렬로 나열한 데이터 구조(같은 타입)
x1 <- 10 # 단일 데이터 
x2 <- 1:10

x1 + 5
x2 + 5

x1 > 5
x2 > 5

# c() : combaine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터를 만드는 함수
x3 <-c(10,15,27,34,49) #연속되지 않는 데이터
x4 <- c(1:10)
x5 <- c("John", "Mark", "Peter")
class(x5)
x6 <- c("ABC", 10, 10.5) #문자열의 벡터 데이터 
x7 <- c(1,2,3, c(4,5), c(6,7,8))

# seq() : sequence, 값을 연속적으로 나타내는 함수
x8 <- seq(1, 10, 3) # 1부터 10까지 3씩 증가

x9 <- seq(from=1, to=10, length.out=3)

# rep() : repeat, 값을 반복해서 나타내는 함수
x10 <- rep(1,10)
x11 <- rep("It's rep()", 2)
x12 <- rep(c("A","B","C"),3)
x13 <- rep(seq(1,4), times=3)
x14 <- rep(seq(1,4), each=3)
x15 <- rep(seq(1,4), length.out=10)
x16 <- rep(seq(1,4), 3)

# 논리 데이터
x19 <- c(TRUE, FALSE, TRUE, FALSE);
class(x19)
x20 <- c(3,3,1)
x21 <- c(1,2,3)
x20 > x21

# A고등학교의 3학년 3반의 학생의 키 측정값 7개
v1 <- c(180,168,172,155,190,175,185)
max(v1) # 최댓값
mean(v1) # 평균값
min(v1) # 최솟값
sum(v1) # 합계값
v1[4]
v1[3:5]
v1[c(2,3,5)]
v1[c(1:2,4:7)]; # == v1[-3]
v1[-3]
v1[c(-3,-5,-6)]
v1[-2:-4]
v2 <- v1[c(-3,-5)]; v2

# 백터의 정렬(sort)
# 오름차순 정렬(Ascending sort)
sort(v1)
# 내림차순 정렬(Descending sort)
sort(v1,decreasing = TRUE) # Python은 reverse , R은 decreasing

# 2.Matrix(행렬) : 2차원 형태(직사각형)의 데이터 구조(같은 타입) 열 우선
x <- 1:6
m1 <- matrix(x, nrow=2, ncol = 3); m1
m2 <- matrix(x, nrow=3, ncol=2); m2
m3 <- matrix(x,nrow=2,ncol=3, byrow=TRUE); m3 #byrow = TRUE 하면 행 우선

dim(m1) # 행과 열 갯수 알려주는 함수
dim(m2)

# 3. Array(배열) - 3차원 이상의 격자형 데이터 구조(같은 타입)
a1 <- array(x, c(2,2,3)); a1 #행, 열, 면

# 4. List(리스트) - 1차원의 여러 가지 타입을 가지는 데이터 구조, 리스트의 원소가 다시 리스트가 될 수 있어서 대칭적인 구조를 가질 수가 있음
list1 <- list(c(1,2,3),c("john","mark","smith")); list1
class(list1)
