url.aapl = "https://www.quandl.com/api/v3/datasets/WIKI/AAPL/
data.csv?api_key=xw3NU3xLUZ7vZgrz5QnG"
data.aapl = read.csv(url.aapl)

head(data.aapl)

library(quantmod)

getSymbols('AAPL')

head(AAPL)

chart_Series(Ad(AAPL))

data = getSymbols('AAPL',
  from = '2000-01-01', to = '2018-12-31',
  auto.assign = FALSE)

head(data)

chart_Series(Ad(data))

ticker = c("FB", "NVDA")
getSymbols(ticker)

head(FB)

head(NVDA)

getSymbols('DGS10', src='FRED')

chart_Series(DGS10)

getSymbols('DEXKOUS', src='FRED')
tail(DEXKOUS)
