library(rvest)
library(httr)

url = paste0('https://finance.naver.com/news/news_list.nhn?',
             'mode=LSS2D&section_id=101&section_id2=258')
data = GET(url)

print(data)

data_title = data %>% 
  read_html(encoding = 'EUC-KR') %>% 
  html_nodes('dl') %>% 
  html_attr('a')

print(data_title)


