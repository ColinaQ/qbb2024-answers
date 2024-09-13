library(tidyverse)
library(ggplot2)
library(ggthemes)

#Q7

dicts_expr <- read_tsv(file = "/Users/cmdb/qbb2024-answers/day4_morning/dicts_expr.tsv")

new_dicts_expr <- dicts_expr %>% 
  dplyr::mutate(Tissue_Gene=paste0(Tissue, " ", GeneID),
                Log_Expr = log2(Expr + 1))

ggplot(new_dicts_expr, aes(x = Log_Expr, y = Tissue_Gene)) + 
  geom_violin() +
#  coord_flip() +
  labs(
    title = "Gene expression by tissue and gene",
    x = "Log-transformed expression",  # Label for x-axis
    y = "Tissue and gene"
  )
  

#It looks like that some tissues exhibit low variability and others 
#show broader distributions. Pancreas and testis tissues show lower 
#variability while others show higher variability. This could be that
#tissues with more specialized functions or more tightly regulated 
#gene expression might show lower variability; tissues 
#involved in diverse functions or responding to different environmental 
#conditions might show higher variability.


