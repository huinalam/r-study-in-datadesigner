### Data Wrangling
### Join ###
# DyplyR 이 SQL과 비슷한 문법을 가짐

bo_this = read.csv("Lecture5/weekly_thiswk.csv", stringsAsFactors = FALSE)
bo_last = read.csv("Lecture5/weekly_lastwk.csv", stringsAsFactors = FALSE)
bo_data = read.csv("Lecture5/weekly_boxoffice_data.csv", stringsAsFactors = FALSE)
# stringsAsFactors = FALSE

library(dplyr)

names(bo_this)
names(bo_last)
names(bo_data)

bo_this
bo_last

# innter : 둘을 합
# left : 왼쪽을 기준으로 정리
# right : 오른쪽을 기준으로 정리
bo_this %>%
  inner_join(bo_last, by = 'title')
bo_this %>%
  left_join(bo_last, by = 'title')
bo_this %>%
  right_join(bo_last, by = 'title')
bo_this %>%
  left_join(bo_data, by = c('title' = 'titl'))
bo_data %>%
  left_join(bo_this, by = c('titl' = 'title'))

# 나중에 문서 보세요
vignette('two-talbe')


### NA ###
# Not Avaliable

movie_rank = 
  bo_this %>%
  left_join(bo_last, by = 'title')

movie_rank$lastwk

# is.na : NA 값이 나오면 T
is.na(movie_rank$lastwk)
# complete.cases : 정상 값이면(NA가 아니면) T
# !is.na : 위와 동
complete.cases(movie_rank)
!is.na(movie_rank$lastwk)

movie_rank %>%
  filter(is.na(movie_rank$lastwk))

movie_rank %>%
  filter(complete.cases(movie_rank))


# NA 생략하려면?
num = c(1:4, NA, 5:10)
num
# NA 값 생략해버릴 수 있음
mean(num, na.rm = T)
# 그러나 문제 : NA를 0으로 처리한 것이 아니라
# 평균 계산시 숫자가 들어가므로 문제가 발생
# 10 개 중 평균 5가 나와야 하지만, 11개로 처리가 됨

# NA 값을 0으로 처리하는 방식
num_nona = ifelse(is.na(num) == T, 0, num)
mean(num_nona)

# 주의! NA를 무조건 0으로 처리할 수는 없다!
# 그래프 상에 공백으로 표현하고 싶으면, 아마 라이브러리마다 사용법이 다를 것이다.

movie_rank %>%
  mutate(
    lastwk_na = ifelse(is.na(lastwk) == T, 'NEW', lastwk) 
  )


bo_data %>%
  left_join(bo_this, by = c('titl' = 'title')) %>%
  right_join(bo_last, by = c('titl' = 'title')) %>%
  mutate( ## 열 생성
    rank = ifelse(is.na(thiswk) == T, 'New', thiswk)
  ) %>% 
  arrange(thiswk, rank) %>% ## arrange : 정렬 
  mutate(
    new_title = stringr::str_replace(titl, 'war', 'happy')
  )


library(dplyr)
bo_this[sort(bo_this$thiswk), ] %>% 
  arrange(desc(thiswk))


### stringr
install.packages('stringr')
library(stringr)

stringr::str_replace('꿈꾸는 데이터 디자이너', '꿈꾸는', '나는')
stringr::str_replace_all('꿈꾸는 꿈꾸는 데이터 디자이너', '꿈꾸는', '나는')
# '^sony' sony로 시작하는 단어만 검색
# 'pictures$' pictures로 끝나는 단어만 검

### Date
time = Sys.time()
# 요일
weekdays(time)
# 월
months(time)
# 분기
quarters(time)

# 09/09
# 포멧
strftime(time, "%m/%d")

str_time = '20150909'
as.Date(str_time, format = '%Y%m%d')

install.packages('gcookbook')
library(gcookbook)

names(aapl)
aapl %>%
  mutate(year = strftime(date, '%Y')) %>%
  group_by(year) %>%
  summarise(price = mean(adj_price)) %>%
  print(n = 30)

aapl %>%
  mutate(weekday = weekdays(date)) %>%
  group_by(weekday) %>%
  summarise(price = mean(adj_price))


## 과제
names(bo_this)
bo_this

library(dplyr) 
bo_this %>%
  mutate(
    modify_title = stringr::str_replace(title, 'War', 'happy')
  )

str_detect(bo_this$title, '^War')

# 과제
bo_data %>%
  mutate(
    cumGross = stringr::str_replace(cumGross, '\\$', '')
  ) %>%
  mutate(
    cumGross = stringr::str_replace_all(cumGross, ',', '')
  ) %>%
  mutate(
    cumGross = as.numeric(cumGross)
  ) %>%
  filter(cumGross > mean(cumGross)) %>%
  group_by(distributor) %>%
  summarise(price = mean(cumGross)) %>%
  arrange(price)

# 도전과제
# 과제로 진행한 값(cumGross)에서
# cumGross 값 중에 평균 이상 값에서
# distributor을 그룹으로 묶어서
# 그 그룹의 cumGross 값 평균으로 요약(price)하고
# 이를 price로 정렬하세요


aapl %>%
  mutate(year_month = strftime(date, "%Y%m")) %>%
  group_by(year_month) %>%
  summarise(price = mean(adj_price))
