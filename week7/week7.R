library(tidyverse)
library(broom)
library(DESeq2)
library(ggthemes)

setwd("/Users/cmdb/qbb2024-answers/week7")

metadata <- read_delim("gtex_metadata_downsample.txt")
counts <- read_delim("gtex_whole_blood_counts_downsample.txt")
gene_loc <- read_delim("gene_locations.txt")

counts_df <- column_to_rownames(counts, var = "GENE_NAME")
metadata_df <- column_to_rownames(metadata, var = "SUBJECT_ID")

dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)

vsd <- vst(dds)

sex_PCA <- plotPCA(vsd, intgroup = "SEX")
age_PCA <- plotPCA(vsd, intgroup = "AGE")
dthhrdy_PCA <- plotPCA(vsd, intgroup = "DTHHRDY")

ggsave("exer1_sexPCA.png",sex_PCA)
ggsave("exer1_agePCA.png",age_PCA)
ggsave("exer1_dthhrdyPCA.png",dthhrdy_PCA)

# Step 1.3.3
# PC1: 48% variance
# PC2: 7% variance

# 48% of the variance is explained by the cause of death, and 7% of the variance
# is explained by sex. The individuals cluster more by the former, and
# somewhat cluster weakly by the latter.

# Exercise 2

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata_df, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# WASH7P does not show significant evidence of sex-differential expression
# because the p value for SEXmale is 2.792437e-01, and this is not significant

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

# SLC25A47 does show significant evidence of sex-differential expression
# because the p value for SEXmale is 2.569926e-02, and this is significant


dds <- DESeq(dds)

dds_sex <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

# Step 2.3.2

dds_sex <- dds_sex %>%
  filter(padj < 0.1) %>%
  arrange(padj)

dim(dds_sex)[1]

# 262 genes exhibit significant differential expression between males and females 
# at a 10% FDR

# Step 2.3.3

gene_location = read.delim("gene_locations.txt")

gene_loc_merged = left_join(gene_loc,dds_sex,by="GENE_NAME") %>% arrange(padj)

# The Y chromosomes encode the genes that are most strongly upregulated in males
# The X chromosomes encode the genes that are most strongly upregulated in females
# There are more male-upregulated genes near the top of the list

WASH7DE_loc = gene_loc_merged %>% filter(GENE_NAME == "WASH7")
SLC25A47_loc = gene_loc_merged %>% filter(GENE_NAME == "SLC25A47")

# The result is consistent for the SLC25A47 gene, but the WASH7DE gene could 
# not be found

# Step 2.4.1
dds_dthhrdy <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

dds_dthhrdy <- dds_dthhrdy %>%
  filter(padj < 0.1) %>%
  arrange(padj)

dim(dds_dthhrdy)[1]

# 16069 genes are differentially expressed according to death classification 
# at a 10% FDR

# 2.4.2
# Since the previous analyses showed that 48% of the variance is explained by 
# the cause of death and 7% of the variance is explained by sex, it make sense 
# that there would be more genes differentially expressed based on type of 
# death compared to the number of genes differentially expressed according 
# to sex


volcano_plot <- ggplot(data = dds_sex, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = (abs(log2FoldChange) > 1 & -log10(padj) > 1))) +
  labs(title = "Differential Results by Sex") +
  theme(legend.position = c(0.2, 0.8),
        legend.text = element_text(size = 8)) +
  scale_color_colorblind(name = "Significant", labels = c("No", "Yes")) +
  labs(y = expression(-log[10]("padj")), x = expression(log[2]("Fold Change")))

ggsave("exer3_volcano_plot.png", volcano_plot)