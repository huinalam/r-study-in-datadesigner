# 웹 크롤링 & 스크랩핑
# http://lumiamitie.github.io/r_tutorial/datadesigner_03_web_scraping.html
install.packages("rvest")
library("rvest")

# 주소
url = "https://en.wikipedia.org/wiki/List_of_South_Korean_regions_by_GDP"
# html 코드를 긁어온다
wiki = html(url)
# html에서 table 태그를 긁어온다.
# class 를 읽어오고 싶으면 ".{className}"
# Id를 읽어오고 싶으면 "#{IdName}"
# 예제, table 태그 & Id = "id"인 경우
# "table#id" 검색
node = html_node(wiki, "table")
# table을 data.frame으로 변경
table = html_table(node)

install.packages("RCurl")
library(bitops)
library("RCurl")

# 웹 읽기 
library(XML)
library(rvest)
basebool = "http://score.sports.media.daum.net/record/baseball/kbo/prnk.daum"
daumHtml = getURL(basebool)
basebool_table = readHTMLTable(daumHtml)$table1
names(basebool_table) = repair_encoding(names(basebool_table))

# XML 데이터 읽어오기
# library("rvest")
boxoffice = rvest::xml("boxoffice/boxoffice0831.xml", encoding="UTF-8")
daily = rvest::xml_node(boxoffice, "dailyboxofficelist")
head(daily)
rank = rvest::xml_text(rvest::xml_nodes(daily, "rank"))
movienm = rvest::xml_text(rvest::xml_nodes(daily, "movienm"))
audicnt = rvest::xml_text(rvest::xml_nodes(daily, "audicnt"))
