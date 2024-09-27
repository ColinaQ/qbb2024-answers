library(ggplot2)
library(dplyr)

setwd("/Users/cmdb/qbb2024-answers/week2")

data <- read.table("snp_counts.txt", header = TRUE, sep = "\t")
data$MAF <- as.numeric(data$MAF)

data <- data %>%
  mutate(log2_enrichment = log2(Enrichment))

ggplot(data, aes(x = MAF, y = log2_enrichment, color = Feature, group = Feature)) +
  geom_line(size = 1) +
  labs(title = "SNP Enrichment at Different MAFs",
       x = "MAF",
       y = "log2-Transformed SNP Enrichment")

ggsave("snp_enrichments.pdf", width = 8, height = 6)