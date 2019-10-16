
library(ggplot2)
#install.packages(c("dplyr", "lme4"), lib="C:\\Users\\jkg209\\r_packages")
library(dplyr, lib.loc = "C:\\Users\\jkg209\\r_packages")
library(lme4, lib.loc = "C:\\Users\\jkg209\\r_packages")

source('R/functions.R')

data <- file_read('data\\gapminder-FiveYearData.csv') %>% 
  mutate(lnLifeExp=log(lifeExp),
         lnGdpPercap=log(gdpPercap))

model <- lmer(lnLifeExp ~ lnGdpPercap + year + (1 | continent), data = data)

lines_data  <-  data %>% mutate(predicted = predict(model)) %>% ddply(.(continent) , summarise_data)

makeFigure(data, lines_data)
