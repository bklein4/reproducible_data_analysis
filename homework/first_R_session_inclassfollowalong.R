####

#Sept. 9 in class lecture

####

2 + 2
c <- 2
a <- 3
a + b
a + c

## Vectors and vectorization Lesson

##example is going to be calculating the circumference of multiple tree trunks

trunk.diameters <- c(13, 4, 7, 19.2) # this is a vector

# a vector is a 1-dimensional set of numbers, so there is an order to the numbers
# for example, 4 is the second number
#Object name is Trunk diameteres 
# c is "concatinate" meaning, put together
#the values are put in after

trunk.circ <- 2 * pi * trunk.diameters #this is a vectorized operation
trunk.diameters

#We want to operate on a whole bunch of values at a time (i.e. trunk diameters)

##############DATA TYPES

some.words <- c("foot", "effervescent", "paramount") 
some.words # R decided to auto-print some.words because we didn't tell it

trunk.diameters + some.words
class (trunk.diameters)
class (some.words)
# We cannot add a numeric character (some.words) to a numeric character (trunk.diameter) 
# which is why we got an error message


str(trunk.diameters) #stands for structure
str(some.words) #you should know the outcome of the str function on every object you assign it

######## other classes of vectors 
my.boolean <- c(TRUE, FALSE, TRUE) # these are "logical" which are just 'true or false'
my.int <- as.integer (c(1, 2, 3)) # these are integers

my.var <- my.int + trunk.diameters


my.boolean + trunk.diameters 
# it added 13 to true and got 14, and added 14 to false and got 4...etc
# True and false are stored as ones and zeroes which is efficient
# R has made the decision that sometimes you want to add vectors of logicals to vectors of numerics
# R has coerced the vector to be a numeric vector rather than a boolean
# this is vector coercion
# coercion will also happen within a vector

new.char <- c(1, 4, TRUE, "pants") #R turns 
class (new.char)

c(1, "pants") + c(1, 2) #these cannot be added. Vector coercion prevents this from working

# Watch out for factors! It's another type of vector with confusing behavior

# Dreaded recycling
length(trunk.diameters)
length(my.int)
trunk.diameters + my.int 
# R converted my.int into a length for vector 
# by recycling the first element out and putting it into the fourth element's place
# this has made a seventh length vector

# there is one occasion where this is a good idea
trunk.diameters + 5
# 5 is added to every item of trunk.diameters
## usually its a bad idea tho, and rarely used

################### PACKAGES ######################################################

# R by itself, is kind of powerful. 
# we downloaded "base R"
# the real power of R comes from downloadable packages from the CRAN website, or others
# most packages just do one specific thing

# install.packages ("tidyverse")
# this would install a very common package used in R
install.packages ("tidyverse") # Do this only when you upgrade your version of R
.libPaths()
library(tidyverse) #this is putting our package into our "search path"


# Everytime I start a new project, I reinstall the packages I need

####### GETTING HELP ###########
# tidyverse is entirely based on "data frames"

# each variable is in its own column
# each observation is in its own row
# each value has its own cell



