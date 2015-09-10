plot(Nile)
str(Nile)
head(Nile)
tail(Nile)

filled.contour(volcano)
str(volcano)
head(volcano)

hist(Nile)
plot(cars)
str(cars)
head(cars)

boxplot(InsectSprays$count ~ InsectSprays$spray)

vector01 = c(1, 2, 3, 4, 5)
vector02 = 1:10
vector03 = c('a', 'b', 'c', 'd')
vector01 %% 2 == 0

# 조건을 이용하여 데이터 값 추출
select = (vector02 %% 2 == 1)
vector02[select]


score_data_frame = data.frame(
  math = c(40,70,80),
  korean = c(50,60,70),
  english = c(30,40,50),
  art = c('A','A','B')
)
score = score_data_frame

# 나홀로 챌린지, 함수 만들기
artToScore <- function(x) {
  ifelse(x == 'A', 100, 
         ifelse(x == 'B', 80,
                ifelse(x == 'C', 60, 
                       0))
         )
}
artToScore2 <- function(arr) {
  art_score = c()
  for(ch in arr){
    if (ch == 'A') {
      art_score <- c(art_score, 100)
    } else if (ch == 'B') {
      art_score <- c(art_score, 80)
    } else if (ch == 'C') {
      art_score <- c(art_score, 60)
    } else {
      art_score <- c(art_score, 0)
    }
  }
  return(art_score)
}

score$sum = score$math + score$korean + score$english + artToScore2(score$art)
score


colMeans(score[,1:3]) 

plot(score_data_frame)
head(score_data_frame)
tail(score_data_frame)

score_data_frame$math

score[, c(1,3)]
score[score$math>50,]

# Homework
# [ 1 ]
select = (iris$Species == 'virginica')
tail(select)
iris2 = iris[select,]
tail(iris2)
plot(iris2$Sepal.Length, iris2$Sepal.Width)

# [ 2 ]


# [ 3 ]
nile_avr = mean(Nile)
Nile2 = Nile[Nile > nile_avr]
hist(Nile2)

sort_data = sort(Nile, decreasing = T)
tail(sort_data)
