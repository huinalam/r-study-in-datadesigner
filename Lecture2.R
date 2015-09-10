# 수업 자료 : http://www.slideshare.net/neuroassociates/2-week3-r-basic

# == 수업예제 ==

data <- c('may', 'day')
'May' %in% data
# result : False
'may' %in% data
# result : True 

# == for, if 예 ==
UpDownLetters <- c(letters, LETTERS)
vowel <- c('a','e','i','o','u', 'A', 'E', 'I', 'O', 'U')
for (ch in UpDownLetters){
  if (ch %in% vowel){
    print(ch)
  }
}
sort(UpDownLetters)

# weather_data.csv
# d:\\Temp\\weather_data.csv
# == 파일 읽기 ==
temp = read.csv('Lecture2\\weather_data.csv',
                fileEncoding = 'UTF-8')

str(temp)
temp$location <- as.character(temp$location)
temp$date <- as.character(temp$date)

# == 서울 온도만 가져오기 ==
select_seoul <- temp$location == '서울'
seoul_temp = temp[select_seoul, 'temp']
barplot(seoul_temp)

# == 평균 온도 ==
temp_avr = mean(temp$temp)

# == 평균 이상일 경우, 칼라 지정해보기 ==
seoul_color = c()
for (tp in seoul_temp){
  if (tp > temp_avr){
    seoul_color = c(seoul_color, '#821122')
  } else {
    seoul_color = c(seoul_color, '#cccccc')
  }
}

## 칼라가 적용된 표 그려보
barplot(seoul_temp, col = seoul_color, border = NA)

## 과제 
select_deagu <- temp$location == '대구'
deagu_temp = temp[select_deagu, 'temp']
barplot(deagu_temp)

deagu_color = c()
for (tp in deagu_temp){
  if (tp > temp_avr){
    deagu_color = c(deagu_color, '#821122')
  } else {
    deagu_color = c(deagu_color, '#cccccc')
  }
}

barplot(deagu_temp, col = deagu_color, border = NA)

# 나홀로 챌린지, 함수 만들어보기
vectorToColorPlot <- function(src, location){
  select_loc <- src$location == location
  loc_temp = temp[select_loc, 'temp']
  barplot(loc_temp)
  
  loc_color = c()
  for (tp in loc_temp){
    if (tp > temp_avr){
      loc_color = c(loc_color, '#821122')
    } else {
      loc_color = c(loc_color, '#cccccc')
    }
  }
  
  barplot(loc_temp, col = loc_color, border = NA)
}
vectorToColorPlot(temp, '서울')
vectorToColorPlot(temp, '대구')

# nemes : 열 이름이 나옴
names(temp)
# dim : 행, 열의 값을 준다.
dim(temp)

for (index in 1:dim(temp)[1]) {
  temp[index, 'dummy'] <- temp[index, 2]
  print(temp[index,2])
}
# 열 삭제
temp$dummy <- NULL
names(temp)


sapply(iris[,-5], mean)
sapply(temp['temp'], mean)
sapply(temp['temp'], max)
