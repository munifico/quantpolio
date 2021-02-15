pkg = c('magrittr', 'quantmod', 'rvest', 'httr',
        'jsonlite', 'readr', 'readxl', 'stringr', 'lubridate',
        'dplyr', 'tidyr', 'ggplot2', 'corrplot', 'dygraphs',
        'highcharter', 'plotly', 'PerformanceAnalytic',
        'nloptr', 'quadprog', 'RiskPortfolios', 'cccp',
        'timetk', 'broom', 'stargazer')

new.pkg = pkg[!(pkg %in% installed.packages()[,"Package"])]

if (length(new.pkg)){
  install.packages(new.pkg, dependencies=TRUE)}
