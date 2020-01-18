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

- Vertor(백터) : 동일한 데이터 타입의 값을 일렬로 나열한 데이터 구조(같은 타입)
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

- Data Frame(데이터 프레임)