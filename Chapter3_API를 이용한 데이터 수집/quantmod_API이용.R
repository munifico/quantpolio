url.aapl = "https://www.quandl.com/api/v3/datasets/WIKI/AAPL/
data.csv?api_key=xw3NU3xLUZ7vZgrz5QnG"

data.aapl = read.csv(url.aapl)
# csv파일을 R에서 직접 다운로드한다.

head(data.aapl)

library(quantmod)

quantmod::getSymbols('AAPL')
# getSymbols 를 이용하여 티커데이터를 티커이름 변수에 저장합니다.

head(AAPL)

quantmod::chart_Series(quantmod::Ad(AAPL))

data = getSymbols('AAPL',
  from = '2000-01-01', to = '2018-12-31',
  auto.assign = FALSE) 
# auto.assign=FALSE를 이용하여 원하는 변수이름으로 저장합니다. 

head(data)

chart_Series(Ad(data))

ticker = c("FB", "NVDA")
getSymbols(ticker)

head(FB)

head(NVDA)

getSymbols('DGS10', src='FRED')
# 미 국채 10년물 금리를 FRED(Federal Reserve Economic Data) 로부터 다운받습니다.
chart_Series(DGS10)

getSymbols('DEXKOUS', src='FRED')
tail(DEXKOUS)
