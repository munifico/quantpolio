library(httr)
library(rvest)

i = 0 # 0 = kospi, 1 = kosdak
j = 1 # page number

ticker=list()
url = paste0('https://finance.naver.com/sise/sise_market_sum.nhn?',
  'sosok=', i, '&page=1')

Sys.setlocale("LC_ALL", "English")
down_table = GET(url)

navi.final = read_html(down_table, encoding = "EUC-KR") %>% 
  html_nodes('.pgRR') %>% 
  html_nodes('a') %>% 
  html_attr('href')

print(navi.final)

navi.final = navi.final %>%
  strsplit('=') %>%
  unlist() %>%
  tail(1) %>%
  as.numeric()

print(navi.final)

table = read_html(down_table, encoding = "EUC-KR") %>% 
  html_table(fill = TRUE)

table = table[[2]]

Sys.setlocale("LC_ALL", "Korean")

head(table)

table[, ncol(table)] = NULL
table = na.omit(table)

symbol = read_html(down_table, encoding = "EUC-KR") %>% 
  html_nodes(., 'tbody') %>% 
  html_nodes(., 'td') %>%
  html_nodes(., 'a') %>% 
  html_attr(., 'href')

print(head(symbol, 10))

symbol = sapply(symbol, function(x){
  substr(x, nchar(x)-5, nchar(x))})

print(head(symbol, 10)) # url은 벡터의 name으로 들어가있음
symbol = unique(symbol)
print(head(symbol, 10))

table$N = symbol
colnames(table)[1] = '종목코드'

rownames(table)=NULL
ticker[[j]] = table