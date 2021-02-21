library(httr)
library(rvest)

data = list()

for(i in 0:1){
  
  ticker = list()
  url = paste0('https://finance.naver.com/sise/sise_market_sum.nhn?',
  'sosok=', i, '&page=1')

  navi.final = GET(url)

  navi.final = read_html(navi.final, encoding="EUC-KR") %>% 
  html_nodes('.pgRR') %>% 
  html_nodes('a') %>% 
  html_attr('href') %>% 
  strsplit('=') %>% 
  unlist() %>% 
  tail(1) %>% 
  as.numeric()
  
  # 종목정보 + ticker 정보 얻어오기
  for(j in 1:navi.final){
    url = paste0('https://finance.naver.com/sise/sise_market_sum.nhn?',
    'sosok=', i, '&page=', j)
    down_table = GET(url)
    
    Sys.setlocale("LC_ALL", "English")
    # 한글 오류 방지를 위해 영어로 로케일 언어 변경
    
    ## 종목정보 테이블 만들기
    table = read_html(down_table, encoding="EUC-KR") %>% 
    html_table(fill=TRUE)

    table = table[[2]]
    
    Sys.setlocale("LC_ALL", "Korean")
    # 한글을 읽기 위해 로케일 언어 재변경
    
    table[,ncol(table)] = NULL
    table = na.omit(table)
    
    ## 티커 정보 획득하기
    symbol = read_html(down_table, encoding="EUC-KR") %>% 
      html_nodes('tbody') %>% 
      html_nodes('tr') %>% 
      html_nodes('td') %>% 
      html_nodes('.tltle') %>% 
      html_attr('href')
    
    symbol = sapply(symbol, function(x){
      substr(x, nchar(x)-5, nchar(x))
    })
    
    table$N = symbol
    colnames(table)[1] = '종목코드'
    
    rownames(table) = NULL
    ticker[[j]] = table    
    
    Sys.sleep(0.5) # 페이지당 0.5초의 슬립 적용
  }
  
  ticker = do.call(rbind, ticker)
  data[[i + 1]] = ticker # 0 은 없는 index임, +1 필수
}

# 코스피와 코스닥 테이블 묶기
data = do.call(rbind, data)
