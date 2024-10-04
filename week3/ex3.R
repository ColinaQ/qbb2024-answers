library(ggplot2)

setwd("/Users/cmdb/qbb2024-answers/week3")

af_data <- read.csv("AF.txt")

ggplot(af_data, aes(x = Allele.Frequency)) +
  geom_histogram(bins = 11, color = "black", fill = "royalblue") +
  labs(title = "Allele Frequency Spectrum", 
       x = "Allele Frequency", 
       y = "Number of Variants")



# Read the read depths from the DP.txt file
dp_data <- read.csv("DP.txt")

# Create a histogram with 21 bins, with x-axis limit set to 20
ggplot(dp_data, aes(x = Read.Depth)) +
  geom_histogram(bins = 21, color = "black", fill = "royalblue") +
  labs(title = "Read Depth Distribution", 
       x = "Read Depth", 
       y = "Number of Variants") +
  xlim(0, 20)


