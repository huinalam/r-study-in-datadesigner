# Data Wrangling
# http://lumiamitie.github.io/r_tutorial/datadesigner_2/datadesigner_04_data_wrangling.html
# 원본 데이터를 다른 데이터로 쉽게 변경하는 작업
# 어떤 데이터가 필요할까?

# Tidy Data
# 각 변수는 하나의 열을 가짐
# 관측치는 하나의 행을 구성함
# 하나의 테이블에는 동일한 관측

# Raw Data -> Tidy Data -> 여러 시각화

# tidyr
# data.frame 만 가능
# resharpe2 패키시 사용
install.packages('tidyr')
library(tidyr)

# wide format -> long format
weather_wide = read.csv("Lecture4\\weather_wide.csv", fileEncoding = 'UTF-8')
weather_long = tidyr::gather(weather_wide, hour, temp, hour03:hour21)


install.packages('dplyr')
library(dplyr)

#### dplyr::select
# 선택해서 출력함
dplyr::select(weather_long, temp)
# 선택해서 출력, 이름을 변경 가능
dplyr::select(weather_long, loc = location, temp)

#### dplyr::filter
# 특정 범위 검색
dplyr::filter(weather_long, location == '강릉' & temp > 26)

#### dplyr::mutate
# 열 생성 가능
dplyr::mutate(weather_long, country = '한국')


#### 문제
# 섭씨 = 화씨
# F = (9/5) * C + 32
# 1) temp 온도를 temp_f 화씨로 변경
w_f = weather_long %>%
  dplyr::mutate(temp_f = (9/5) * temp + 32)
w_f
# 2) 화씨 90도 넘는 경우, location temp 출력
w_f %>%
  dplyr::filter(temp_f > 90) %>%
  dplyr::select(location, temp)


#### dplyr::summarise
# 데이터 요약 가능
dplyr::summarise(weather_long, mean(temp))
dplyr::summarise(weather_long, count = n())

#### dplyr::group_by
# 그룹 지정 
weather_long %>%
  dplyr::group_by(temp)

weather_long %>%
  dplyr::group_by(hour)

#### 샘플
weather_loc = dplyr::group_by(weather_long, location)
weather_hour = dplyr::group_by(weather_long, hour)

dplyr::summarise(weather_loc, mean_temp = mean(temp))
dplyr::summarise(weather_hour, mean_temp = mean(temp))

dplyr::mutate(weather_loc, mean_temp = mean(temp))
dplyr::mutate(weather_hour, mean_temp = mean(temp))

#### dplyr::arrange
# 특정 열을 정리한다
dplyr::arrange(weather_long, desc(temp), hour)

# 각 지역 별 평균 온도
summary_loc = dplyr::summarise(weather_loc, mean_temp = mean(temp))
summary_loc

# 정렬
dplyr::arrange(summary_loc, mean_temp)
dplyr::arrange(summary_loc, location)

# 1) Sepal.Width, Sepal.Length 평균 구하시오
iris %>%
  dplyr::summarise(width_mean = mean(Sepal.Width),
                   length_mean = mean(Sepal.Length))
iris %>%
  dplyr::summarise(w_max = max(Sepal.Width),
                   w_min = min(Sepal.Width))


#### 과제
weather_wide_full = read.csv("Lecture4\\weather_wide_full.csv", fileEncoding = 'UTF-8')
weather_long_full = tidyr::gather(weather_wide, hour, temp, hour03:hour21)

# 지역별 평균 구하기
weather_long_full %>%
  dplyr::group_by(location) %>%
  dplyr::summarise(temp_mean = mean(temp))

# 시간별 평균 구하기
weather_long_full %>%
  dplyr::group_by(hour) %>%
  dplyr::summarise(temp_mean = mean(temp))

# 파이프 예제
weather_long_full %>%
  dplyr::group_by(location) %>%
  dplyr::summarise(temp_mean = mean(temp)) %>%
  dplyr::mutate(diff = temp_mean - mean(temp_mean)) %>%
  dplyr::filter(diff > 0) %>%
  dplyr::select(location, temp_mean) %>%
  dplyr::arrange(desc(temp_mean))


#### 실습
### 웹페이지 실습 따라함
install.packages('gcookbook')
library(gcookbook)
head(tophitters2001)

names(tophitters2001)

hitter_avg = select(tophitters2001, name, team, lg, avg)

hitter_avg %>%
  top_n(1, wt = avg)

# 각 팀의 타율 1위
hitter_avg %>%
  group_by(team) %>%
  top_n(1, wt=avg)
