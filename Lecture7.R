### 상관관계 R 사용
### http://www.slideshare.net/neuroassociates/week9rstatics

## Read Data
score <- read.csv("Lecture7\\score_data.csv")
names(score)

## Data Cleasing
score
colnames(score) <- c("X1", "X2", "X3", "y")
score[is.na(score)] <- 0

## Sampling
# nrow : 전체 row의 갯수
# sample : 150개에서 50개의 샘플을 뽑겠다.
sample <- score[sample(nrow(score), 50),]
sample


### Descriptive Sattistic
### 기술 통계량
## 모집단의 정보
mean(score$X1) # 평균
var(score$X1) # 분산
sd(score$X1) # 표준편차
se = function(x) sd(x)/sqrt(length(x)) # 표준오차 함수 만들기
se(score$X1) # 표준오차

plot(density(score$X1)) # 분포 그려보기
qqnorm(score$X1); qqline(score$X1) # 정규분포를 따르는지 확인하기

summary(score$X1)
boxplot(score$X1) # Summary 정보를 표현하는 그림

## 샘플 정보
mean(sample$X1)
plot(density(sample$X1))
plot(sample$X1)

# 샘플의 T-Test
t.test(sample$X1, mu=60.16) # t검정


### Correlation Linear Regression
### 상호관계 선형 표현식
# 공분산 Covariance
# 상관계수 Correlation coefficient

### 상관관계 분석
x <- 1:10; y <- x^2
cor(x,y) 
# y는 지수로 증가하므로
# 증가는 맞지만, 명확하지 않으므로 0.974... 로 나온다

cor(attitude, method="pearson", use="pairwise.complete.obs")
# 상관관계 분석 방법 method = "pearson"을 사용
# missing 데이터를 중간에 빼고, 완벽한 데이터만으로 구하겠다 : use="pairwise.complete.obs"
# 피어슨 상관관계
pairs(attitude)

## 상관관계가 있을까?
cor.test(attitude$complaints, attitude$learning)
# 해석 방법
# 두 변수의 상관관계 계산
# 상관계수 : 0.5967 만큼의 상관관계를 가진다. 1일수록 강한 관계. 0일수록 관계없음
# P-Value : 믿을만한 값인지? 0.05보다 작으면 믿을만한 값이다.
cor.test(attitude$complaints, attitude$critical)

# 공분산 : 기울기 방향이 같은지
# 상관계수 : 일치하는지?
# 단순회귀분석 : 관계를 설명하는 직선 표현

# 단순회귀분
cars <- data.frame(cars)
out = lm(dist ~ speed, data = cars)
  # lm : 회귀분석에서 선을 찾는 명령(OSL이라는 방법이 있음)
  # y축 dist, x축 speed
summary(out)
  # y = a + bx
  # Intercept :
  # a(절편) : -17.5791
  # b(기울기) = 3.9324
  # 별표의 의미. 별표가 많으면 좋다.

# 그래프를 본다
plot(dist~speed, data=cars)
# 선을 그린
abline(out, col="red")


# score data를 사용하여 중간고사 점수가 기말고사 점수에 어떤 영향을 주는지
# 단순회귀분석을 시행하고 그 결과를 분석해보자
score_out = lm(X1 ~ X2, data = score)

# 상관계수, P-Value 확인
cor.test(score$X1, score$X2)
summary(score_out)

plot(X2~X1, data=score)
abline(score_out, col="red")
# p-value가 2.2e-14로 엄청 작음
# 상관계수가 0.649 정도로 나옴. 0.7 이상이면 매우 높은 수치임
