library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)

# to create a visualization based on dataset that shows which democratic party candidate
# has the most weekly cable channel video/audio clips from CNN FOX MSNBC
# December 30th, 2018, to September 8th, 2019
# line graph to see which candidate has most views over time.

politics <- cable_weekly
politics
str(politics)
class(politics)
colnames(politics)
rownames(politics)
unique(politics$name) 

politics$date <- as.Date(as.character(politics$date))

max(politics$matched_clips) # 3393
min(politics$matched_clips) # 0 
max(politics$date) # 2019-09-08
min(politics$date) # 2018-12-30

politics <- select(politics, date, name, matched_clips)
politics <- data.table::setcolorder(politics, c("name", "matched_clips", "date"))
politics

politics1 <- pivot_wider(politics, id_cols = NULL, names_from = name, values_from = matched_clips)
politics1
politics1 <- select(politics1, 'date','Andrew Yang','Bernie Sanders','Pete Buttigieg',
                    'Elizabeth Warren','Joe Biden','Cory Booker')
politics1

politics2 <- pivot_longer(politics1, c('Andrew Yang','Bernie Sanders','Pete Buttigieg','Elizabeth Warren',
                                       'Joe Biden','Cory Booker'), names_to = 'name', values_to = 'matched_clips')

politics2
str(politics2)

ggplot(politics2, aes(x = date, y = matched_clips, color = name, group = name)) +
  geom_line(linetype = 1, size = 0.8) +
  ggtitle('Democratic Political Candidate Exposure') +
  xlab('December 30, 2018 - September 30, 2019') +
  ylab('Number of Commercials on Cable TV') +
  scale_x_discrete() +
  scale_y_continuous(breaks = scales::pretty_breaks(15))
  
