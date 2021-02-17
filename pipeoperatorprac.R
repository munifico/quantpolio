x = c(0.3078, 0.2577, 0.5523, 0.0564, 0.4685,
      0.4838, 0.8124, 0.3703, 0.5466, 0.1703)

x1 = log(x)
x2 = diff(x1)
x3 = exp(x2)
round(x3, 2)

round(exp(diff(log(x))), 2)

library(magrittr)

x %>% log() %>% diff() %>% exp() %>% round(., 2)

