#### Homework 3

#### Barbara Klein

#### Purpose of script is to understand basic vectors and their outcomes/meaning in R
library(tidyverse)
library(ggplot2)
### tidyverse has already been installed, I need to load the package with the library() function

#####Vectors, types, and Coercion#########
class(c(TRUE, FALSE, FALSE)) #these are logicals

class(c(1, 2, 3)) #this is a numeric

class(c(1.3, 2.4, 3.5)) #this is also a numeric

class(c("a", "b", "c")) # this is a character

# what are the two types of vectors, and why?
# c(1, 2, "a")
# c(TRUE, FALSE, 2)

class(c(1, 2, "a")) #this is a character because R cannot distinguish the character
# I have given ("a"), from the numerics.


class(c(TRUE, FALSE, 2)) #this is a numeric because R has determined that I want to add logicals
# (which are stored as one's and zero's), with numerics, and has coerced the logical to be a numeric vector
# In R this is known as 'vector coercion'. 


#################
read_csv(med_enz.csz)
### assign the csv file to an 'object' using the <- operator

med_enz <- read_csv(med_enz)
### determine what class med_enz belongs to using the class() function

class(med_enz)   ### R told me the class is a "character"
### determine the structure of med_enz using the str() function

str(med_enz) ### R told me the structure is "chr"
### determine the number of rows of med_ens using the nrow() function

nrow(med_enz) ### R told me the number of rows is "NULL"
### Get a "glimpse" of med_enz using the glimpse() function

glimpse(med_enz) ### R told me the glimpse is: chr "med_enz.csv" 

### print and save a histogram of the activity.nmM.hr column using the following code:
search() ##lists tools and packages installed

df <- as.data.frame(med_enz)
## I cannot just copy and past the 4 command lines below. I have to go in, line by line, make sure
## R can read the line correctly, and press Ctrl + Enter.
## Don't try and copy/paste because you'll get an error every time. 
## Also, make sure path is correctly set vs. the example given.

p <- ggplot(data = med_enz, aes(x = activity.nM.hr)) + 
  geom_histogram()
print (p)
ggsave(filename = "~/micro_490/reproducible_data_analysis/plots/hmk_3_plot.png", plot = p, height = 3, width = 4, units = "in", dpi = 300)
