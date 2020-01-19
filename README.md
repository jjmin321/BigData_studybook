# R의 데이터타입 (R Data Type)
1. 숫자 : 정수, 실수
2. 문자 : "". ''
3. 논리 : true,false
4. 범주(factor) : 범주형으로 다루는 데이터 ex) 남, 여 , 군필, 미필
5. 날짜(as.date)
6. 날짜, 시간(as.POSIXct) 

# R의 데이터구조 (R Data Structure) - 데이터 분석에서 벡터, 데이터프레임만 사용함
|         |1차원 | 2차원  | 3차원  |
|:------:|:------------:|:-----------------:|:-----------------:|
| 동일형 | 백터(Vactor) | 행렬(Matrix)        |   배열(Array)        |
| 다중형     | 리스트(List)  | 데이터 프레임(Data Frame) | X |

### Vertor(백터) : 동일한 데이터 타입의 값을 일렬로 나열한 데이터 구조(같은 타입)
    - Vertor의 내장 함수들
        1. c() : combaine, 여러 벡터 데이터를 연결하여 하나의 긴 벡터를 만드는 함수
        ```R
        x3 <-c(10,15,27,34,49) #연속되지 않는 데이터
        x4 <- c(1:10)
        x5 <- c("John", "Mark", "Peter")
        class(x5)
        x6 <- c("ABC", 10, 10.5) #문자열의 벡터 데이터 
        x7 <- c(1,2,3, c(4,5), c(6,7,8))
        ```
        2. seq() : sequence, 값을 연속적으로 나타내는 함수
        ```R
        x8 <- seq(1, 10, 3) # 1부터 10까지 3씩 증가
        x9 <- seq(from=1, to=10, length.out=3)
        ```
        3. rep() : repeat, 값을 반복해서 나타내는 함수
        ```R
        x10 <- rep(1,10)
        x11 <- rep("It's rep()", 2)
        x12 <- rep(c("A","B","C"),3)
        x13 <- rep(seq(1,4), times=3)
        x14 <- rep(seq(1,4), each=3)
        x15 <- rep(seq(1,4), length.out=10)
        x16 <- rep(seq(1,4), 3)
        ```
    - Vertor의 정렬
    ```R
    # 백터의 정렬(sort)
    # 오름차순 정렬(Ascending sort)
    sort(v1)
    # 내림차순 정렬(Descending sort)
    sort(v1,decreasing = TRUE) # Python은 reverse , R은 decreasing
    ```
### Data Frame (데이터 프레임) - 2차원 형태(직사각형, 테이블, 표)의 데이터 구조 (여러 가지 타입), 실제로 데이터 분석을 위한 구조

##### 데이터 프레임을 생성하는 방법 1

```R
id <- 1:10;
gender <- c("M", "F", "M", "F", "F", "M", "F", "M", "F", "F");
area <- c("제주", "대구", "인천", "서울", "부산", "전주", "광주", "대구", "서울", "부산")
age <- c(20, 35, 65, 45, 33, 32, 33, 71, 23, 22, 20)
```

##### 데이터프레임의 정보를 확인 
```R
View(member) # 표를 만들어서 모든 데이터를 보여줌
head(member) # 앞에서부터 6개의 데이터만 출력
head(member,8) # 앞에서부터 x개의 데이터만 출력 
tail(member) # 뒤에서부터 6개의 데이터만 출력
tail(member, 8) # 뒤에서부터 x개의 데이터만 출력
summary(member) # 데이터를 각 변수별로 요약해서 확인 
```

##### 데이터프레임에 각 변수의 정보를 확인
```R
member$id
member$gender
member$area
member$age
mean(age)
```

# R 패키지를 설치/부착/확인/제거/업데이트
```R
# ggplot2 패키지 - 시각화를 위한 다양한 함수를 내장하는 패키지, 다양한 데이터셋(dataset)을 포함하는 패키지

# install.packages() 패키지 설치
# installed.packages() 패키지 설치 확인 

install.packages("ggplot2") # ggplot2 패키지 설치
library(ggplot2) # ggplot2 사용 

detach("package:ggplot2") # ggplot2 미사용 
installed.packages()
# update.packages() 설치된 모든 패키지 자동 업데이트 
```

