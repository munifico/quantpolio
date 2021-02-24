down_sector = read.csv('data/krx_sector.csv', stringsAsFactors = FALSE, row.names=1)

down_ind = read.csv('data/krx_ind.csv', row.names= 1, stringsAsFactors = FALSE)

intersect(names(down_sector), names(down_ind))

setdiff(down_sector[,'종목명'], down_ind[,'종목명'])

KOR_ticker = merge(down_sector, down_ind, 
  by = intersect(names(down_sector), names(down_ind)),
  all = FALSE)

KOR_ticker = KOR_ticker[order(-KOR_ticker['시가총액']),]
head(KOR_ticker)

library(stringr)

# KOR_ticker[grepl('스팩', KOR_ticker[, '종목명']), '종목명']

# SPAC: 기업인수목적회사(企業引受目的會社) / Special Purpose Acquisition Company

# KOR_ticker[str_sub(KOR_ticker[,'종목코드'], -1, -1) != 0, '종목명']  

# 우선주: 보통주에 비해서 특정한 우선권을 부여한 주식. 
# 우선권이 있는 대신 보통주와 달리 주주총회에서 의결권을 행사할 수 없다. 
# 보통 배당에 대해서 약간의 이익이 더 있는 수준. 주식시장에서 회사명+"우"라고 표기되어 거래된다.

# 일반적으로 우선주는 의결권이 없기 때문에 보통주보다 낮은 가격에 거래가 된다.
# 그러나 우선주의 배당률이 높게 정해져 있거나 대주주의 지분율이 너무 높아서 유통되는
# 보통주의 의결권의 가치가 사실상 없는 경우에는 우선주의 주가가 보통주의 주가보다 높아지기도 한다.

# 소정비율의 우선배당을 받고도 이익이 남을 경우 보통주와 더불어서 추가적인 배당을 받을 수 있는 참가적 우선주(없으면 비참가적 우선주), 
# 해 영업 연도에 소정의 우선배당을 받지 못할 경우 다음 영업연도에 이를 보상받을 수 있는 누적적 우선주(보증주. 보상이 안 되면 비누적적 우선주) 등이 있다
# 회사채발행, 은행대출은 이자를 지급하기 어려워서 못하겠고
# 유상증자는 최대주주 지분율이 낮아질까봐 못하는 재무상태가 막장인 기업이 우선주를 발행하게 되므로
# 우선주를 발행한 기업을 부정적으로 봐야 한다는 것이 일반적인 이론이다
# 하지만 과거 국내에서는 기업에게 유리한 우선주의 존재를 상법이 보장하니까 일단 발행하고 보자라는 도덕적 해이가
# 기업가들 사이에 만연했기 때문에 우선주를 발행한 기업이 매우 많다
# 코스피 지수가 2,000을 넘나드는 시기에 한국증권거래소는 각 기업들의 우선주를 소각하려고 하고 있지만 아직 관련법 개정이 이루어지고 있지는 않다.

# 우선주는 보통주보다 선순위 변제권을 갖는다. 하지만 자진청산의 경우를 제외하면 기업이 망했을 때
# 회사채 보유자들도 손해를 보는 경우가 일반적이기에 우선주의 선순위 변제권은 실질적 의미가 없다.

KOR_ticker = KOR_ticker[!grepl('스팩', KOR_ticker[, '종목명']), ]
KOR_ticker = KOR_ticker[str_sub(KOR_ticker[, '종목코드'], -1, -1) == 0, ] 
# 종목코드 마지막 숫자가 0인 기업을 택한다.
# ▷ 마지막 1자리는 보통주/우선주 구분
# 보통주는 0이 배정

rownames(KOR_ticker) = NULL
write.csv(KOR_ticker, 'data/KOR_ticker.csv')
