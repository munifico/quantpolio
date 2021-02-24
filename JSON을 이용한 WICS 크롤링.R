# GICS란? 
# Global Industry Classification Standard (국제산업분류기준)

# GICS는 MSCI Inc의 독점지적재산권으로 명시되어있어서 사용하는데 무리가 있다고 함
# 그래서 와이즈인덱스의 WICS 산업분류를 이용한다.

# json 형식으로 제공되는 데이터
# 문법이 단순하고 용량이 작아 XML 대신 사용.
# jsonlite의 fromJSON()을 통해 크롤링할 수 있음.

library(jsonlite)

url = paste0(
  'http://www.wiseindex.com/Index/GetIndexComponets',
  '?ceil_yn=0&dt=20210224&sec_cd=G10')
data = fromJSON(url)
data
lapply(data, head)

sector_code = c('G25', 'G35', 'G50', 'G40', 'G10',
  'G20', 'G55', 'G30', 'G15', 'G45')
data_sector = list()

for (i in sector_code){
  url = paste0(
  'http://www.wiseindex.com/Index/GetIndexComponets',
  '?ceil_yn=0&dt=20210224&sec_cd', i)
  data = fromJSON(url)
  data = data$list
  
  data_sector[[i]] = data
  
  Sys.sleep(1)
}

data_sector = do.call(rbind, data_sector)  

write.csv(data_sector, 'data/KOR_sector.csv')

