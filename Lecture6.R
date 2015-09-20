### ggplot2
### Gram of Graphics (?) 의 준
### 슬라이드 자료 :
### http://www.slideshare.net/neuroassociates/week8rggplot2
### 연습문제 자료 :
### http://lumiamitie.github.io/r_tutorial/datadesigner_2/06_ggplot2.html

# plot()
# 데이터 형태에 따라 시각화 방식을 제공

# R에 있는 기본 그래프
plot(iris)
plot(Nile)
plot(Titanic)

# 점
plot(BOD)
# 선
plot(BOD, type='l')
# 막대 그래프
barplot(BOD$demand)

# 필요 요소 (Layer 기반하여 동작함)
# Data : 데이터, 변수 1개, 데이터 1개
# Mapping : 데이터의 요소와 그래프의 요소(x축,y축, 점 색상 매칭)
# Geometric Obejct : 줄여서 geom, 어떤 그래프를 그릴 것인지?
# Position :  그래프에서 각 도형을 어떤 식으로 배치될지 결정
# Statistical Transformation : 값이 어떻게 그래프에 반영되는지 결정함. 
install.packages('ggplot2')
library(ggplot2)
ggplot2::ggplot() +
  ggplot2::geom_point(data = iris,
                      aes(x = Sepal.Length,
                          y = Sepal.Width,
                          colour = Species))

# 그래프 2개를 해봄
ggplot2::ggplot() +
  geom_point(
    data = iris,
    aes(x = Sepal.Length,
        y = Sepal.Width)
  ) +
  geom_smooth(
    data = iris,
    aes(x = Sepal.Length,
        y = Sepal.Width)
  )

# 위를 요약함
iris_plot = ggplot2::ggplot(data = iris,
                            aes(
                              x = Sepal.Length,
                              y = Sepal.Width,
                              colour = Species
                            ))
iris_plot + geom_point() + geom_smooth()

# data = diamonds
# 연습
dia_plot = ggplot2::ggplot(data = diamonds,
                            aes(
                              x = carat,
                              y = price,
                              colour = color
                            ))
dia_plot + ggplot2::geom_point()

# parameter를 넣을 수 있다
# stat smooth?
iris_plot + 
  ggplot2::geom_point(size = 3, colour = 'red') +
  ggplot2::geom_smooth(method = 'lm')

iris_plot + 
  ggplot2::geom_point(size = 3, colour = 'red') +
  ggplot2::geom_smooth(linetype = 2)

iris_plot + 
  ggplot2::geom_point(size = 3, colour = 'red') +
  ggplot2::geom_smooth(se = F)


iris_plot2 = ggplot2::ggplot(data = iris,
                            aes(
                              x = Species,
                              y = Sepal.Width
                            ))
iris_plot2 +
  ggplot2::geom_boxplot(fill = '#3399ff',
                        colour = '#c8b923')

# Position Adjustmnet
ggplot(data = mpg, aes(displ,hwy)) +
  geom_point(position = 'jitter') +
  geom_smooth()

# 아래는 그래프를 그려보는 예제이다.
# factor :
# 예) 2,4,6 이렇게 값이 있을 경우, 1,3,5 가 그래프에 나오는 것을 삭제해줌
mtcars_plot = ggplot2::ggplot(mtcars, 
                              aes(factor(cyl),
                                  fill = factor(vs))
                              )
mtcars_plot + geom_bar()
mtcars_plot + geom_bar(position = 'stack')
mtcars_plot + geom_bar(position = 'fill')
mtcars_plot + geom_bar(position = 'dodge')

names(diamonds)
dia_plot2 = ggplot2::ggplot(diamonds,
                            aes(x = clarity,
                            fill = cut))
dia_plot2 + ggplot2::geom_bar()

# RColorBrewer
# 색상을 나누어져 있음
RColorBrewer::display.brewer.all()

# Scale 
# scael_xxx_brewer
dia_bar <-
  ggplot(diamonds, aes(x = cut, fill = cut)) +
  geom_bar()
dia_bar + scale_fill_brewer(palette = 'Accent')

mpg_plot = ggplot(data = mpg, aes(displ, hwy))
mpg_plot + geom_point() + geom_smooth() + scale_x_continuous(limits = c(4,6))

iris_plot + geom_point() + facet_wrap(~Species) + scale_fill_brewer(palette = 'Accent')

# http://docs.ggplot2.org/current/