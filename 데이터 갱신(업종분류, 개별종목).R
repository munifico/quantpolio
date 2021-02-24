library(httr)
library(rvest)
library(stringr)

url = 'https://finance.naver.com/sise/sise_deposit.nhn'

biz_day = GET(url) %>% 
  read_html(encoding = "EUC-KR") %>% 
  html_nodes(xpath = 
      '//*[@id="type_0"]/div/ul[2]/li/span') %>% 
  html_text() %>% 
  str_match(('[0-9]+.[0-9]+.[0-9]+') ) %>% 
  str_replace_all('\\.', '')
  
print(biz_day)

# 획득한 날짜 이용하여 데이터 자동획득 시스템 생성, 그냥 붙여넣기

# 업종분류
gen_otp_url = 'http://data.krx.co.kr/comm/fileDn/GenerateOTP/generate.cmd'
gen_otp_data = list(
  mktId='STK',
  trdDd=biz_day,
  money='1',
  csvxls_isNo='false',
  name='fileDown',
  url='dbms/MDC/STAT/standard/MDCSTAT03901'
)

otp = POST(gen_otp_url, query = gen_otp_data) %>% 
  read_html() %>% 
  html_text()

down_url = 'http://data.krx.co.kr/comm/fileDn/download_csv/download.cmd'
  
down_KS = POST(down_url, query=list(code=otp),
  add_headers(referer = gen_otp_url)) %>% 
  read_html(encoding = 'EUC-KR') %>% 
  html_text() %>% 
  read_csv()

gen_otp_data = list(
  mktId='KSQ',
  trdDd=biz_day,
  money='1',
  csvxls_isNo='false',
  name='fileDown',
  url='dbms/MDC/STAT/standard/MDCSTAT03901'
)

otp = POST(gen_otp_url, query = gen_otp_data) %>% 
  read_html() %>% 
  html_text()

down_KQ = POST(down_url, query=list(code=otp),
  add_headers(referer = gen_otp_url)) %>% 
  read_html(encoding = 'EUC-KR') %>% 
  html_text() %>% 
  read_csv()

down_sector = rbind(down_KS, down_KQ)

write.csv(down_sector, 'data/krx_sector.csv')

# 개별종목 

gen_otp_data = list(
  searchType='1',
  mktId='ALL',
  trdDd=biz_day,
  csvxls_isNo='false',
  name='fileDown',
  url='dbms/MDC/STAT/standard/MDCSTAT03501'
)

otp = POST(gen_otp_url, query = gen_otp_data) %>%
  read_html() %>%
  html_text()

down_ind = POST(down_url, query = list(code = otp),
  add_headers(referer = gen_otp_url)) %>% 
  read_html(encoding = 'EUC-KR') %>% 
  html_text() %>% 
  read_csv()

write.csv(down_ind, 'data/krx_ind.csv')
