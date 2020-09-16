#### Purpose of script:

#### Assignment: Script of HW-3, basic visualization and input/output

#### Barbara Klein

#### notes of assignment are there to explain why code is written, not what it does or how it works. 
# example of a good note:
# Force = mass * acceleration

# example of a bad note:
# multiply m by a, and assign it to vector F
# F <- m * a

# object names:
# name lists, data frames, and function in "snake_case_ using a '_' separator: ex. med_enzymes
# name vectors in "snake.case" using a '.' separator: ex. site.temperatures

######################### beginning of assignment ###############################

setwd("C:/Users/User/Documents/micro_490/reproducible_data_analysis/data")

## must put quotation marks around the "path" of your working directory in order for R to recognize

install.packages(tidyverse)
library(tidyverse)

d <- read.csv("chris_names_wide.csv", header = TRUE) #list of baby names in csv file is not named 'chris' 

## now we convert to a long format done with tidyverse (its in wide format now)

installed.packages() ##shows installed packages to make sure you have what you need in tidyverse

d_long <- pivot_longer(d, cols = -year, names_to = "sex", values_to = "n" ) ## DO NOT put 'd =' otherwise you will get an error message

##### Line plot creation ####
setwd("C:/Users/User/Documents/micro_490/reproducible_data_analysis")
ggplot(data = d) + 
  geom_point(mapping = aes(x = year, y = male), color = "green") + 
  geom_point(mapping = aes(x = year, y = female), color = "yellow")
ggsave(filename = "plots/scatterplot_hw4.png")

#### format of same plot except with a "loess" -smoothed line representing data #####
ggplot(data = d) + 
  geom_smooth(mapping = aes(x = year, y = male), color = "green") + 
  geom_smooth(mapping = aes(x = year, y = female), color = "yellow")
ggsave(filename = "plots/smoothplot_hw4.png")

#### boxplot with sex on x-axis and number of people with that name on the y-axis ####

library(dplyr)
ggplot(data = d_long, aes(x = sex, y = n)) +
  geom_boxplot()
ggsave(filename = "plots/boxplot_hw4.png")
