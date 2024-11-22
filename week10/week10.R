library(ggplot2)

setwd("/Users/cmdb/qbb2024-answers/week10")

data <- read.table("nuclei.tsv", header = TRUE, sep = "\t")

nascent_plot <- ggplot(data, aes(x = Gene_ID, y = nascentRNA)) +
  geom_violin(trim = FALSE, fill = "skyblue") +
  labs(title = "Nascent RNA by gene KD", x = "Gene", y = "Mean Nascent RNA Signal")

ggsave("nascentRNA.png", plot = nascent_plot)

PCNA_plot <- ggplot(data, aes(x = Gene_ID, y = PCNA)) +
  geom_violin(trim = FALSE, fill = "orange") +
  labs(title = "PCNA by gene KD", x = "Gene", y = "Mean PCNA Signal")

ggsave("PCNA.png", plot = PCNA_plot)

log_plot <- ggplot(data, aes(x = Gene_ID, y = log2ratio)) +
  geom_violin(trim = FALSE, fill = "hotpink") +
  labs(title = "Log2 Ratio (Nascent RNA / PCNA) by gene KD", x = "Gene", y = "Log2 Ratio")

ggsave("log2ratio.png", plot = log_plot)

