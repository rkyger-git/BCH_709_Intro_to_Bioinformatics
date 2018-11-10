#Starting with Data
library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
interviews

    args(read_csv)

dim(interviews)

head(interviews)

    args(head)

names(interviews) 

str(interviews)

summary(interviews)

interviews[1, 1]

interviews[1, 6]

interviews[1]

## first three elements in the 7th column (as a vector)
interviews[1:3, 7]

interviews["village"]       # Result is a data frame
interviews[, "village"]     # Result is a data frame
interviews[["village"]]     # Result is a vector
interviews$village          # Result is a vector

