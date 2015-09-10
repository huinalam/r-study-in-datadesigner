# reference
# http://wsyang.com/2011/07/r%EC%97%90%EC%84%9C-sas%EC%9D%98-%EC%98%81%EA%B5%AC%ED%8C%8C%EC%9D%BC-sas7bdat-%EC%9D%B4%EC%9A%A9%ED%95%98%EA%B8%B0/
# data source
# https://www.kli.re.kr/klips/ko/datadown/lst.klips-0700#none

install.packages("sas7bdat")
library(sas7bdat)
klips <- read.sas7bdat("Try1\\klips15h.sas7bdat")

summary(klips)
head(klips)


# ==========================
# 엑셀로 읽기 위해 테스
# install.packages("xlsx")
install.packages("openxlsx")
library(openxlsx)
cost <- read.xlsx('Try1\\cost.xlsx')
head(cost)

install.packages('rJava')
library(rJava)
