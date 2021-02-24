library(httr)
library(rvest)
library(readr)

gen_otp_url = 'http://data.krx.co.kr/comm/fileDn/GenerateOTP/generate.cmd'
gen_otp_data = list(
  mktId='STK',
  trdDd='20210223',
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
  trdDd='20210223',
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

ifelse(dir.exists('data'), FALSE, dir.create('data'))
write.csv(down_sector, 'data/krx_sector.csv')

