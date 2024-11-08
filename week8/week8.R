#BiocManager::install("zellkonverter")
library("zellkonverter")
library("ggplot2")
library("scuttle")
library("scater")
library("scran")  

setwd("/Users/cmdb/qbb2024-answers/week8")

gut <- readH5AD("v2_fca_biohub_gut_10x_raw.h5ad")
assayNames(gut) <- "counts"
gut <- logNormCounts(gut)

# Exercise 1
# Question 1
# 13407 genes are quantitated. 11788 cells are in the data set.
reducedDims(gut)
# X-pca, X_tsne, and X_umap dimension reduction data sets are available.

# Question 2
colData(gut)
# There are 39 columns in colData(gut).
# The age, n_genes, and annotation columns are the most interesting because
# the age column could help us examine senescence, the n_genes column gives
# useful information on how many genes are counted, and the annotation column
# gives details on cell type.

set.seed(42)
plotReducedDim(gut,"X_umap",color="broad_annotation")

genecounts <- rowSums(assay(gut))

#Question 3
summary(genecounts)
# The mean genecount is 3185 and the median genecount is 254. It seems that
# the data is very skewed. While most genes do not have much expression,
# a few genes must have very high expression.
sort(genecounts,TRUE)[1:3]
# The three genes with the highest expression are Hsromega, CR45845, and roX1.
# These genes all encode for non-coding RNA.

#Question 4a
cellcounts <- colSums(assay(gut))
hist(cellcounts)
summary(cellcounts)
# The mean number of counts per cell is 3622. The cells with much higher total 
# counts (>10,000) are the majority of cells that the sample depicts.

#Question 4b
celldetected <- colSums(assay(gut)>0)
hist(celldetected)
summary(celldetected)
# The mean number of genes detected per cell is 1059.
1059/13407
# The fraction of the total number of genes represents is 7.90%.

mito <- grep("^mt:",rownames(gut),value=TRUE)
df <- perCellQCMetrics(gut,subsets=list(Mito=mito))
df <- as.data.frame(df)
summary(df)
colData(gut) <- cbind( colData(gut), df )

# Question 5
plotColData(gut, y = "subsets_Mito_percent", x = "broad_annotation") +
  theme(axis.text.x = element_text(angle = 90))
# Epithelial cells, gland cells, gut cells, and somatic precursor cells may 
# have a higher percentage of mitochondrial reads. This is the case because
# there is high metabolic activity in these cell types and that requires
# a lot of energy input. 

# Question 6a
coi <- colData(gut)$broad_annotation == "epithelial cell"
epi <- gut[,coi]
plotReducedDim(epi, "X_umap", colour_by="annotation" )

marker.info <- scoreMarkers( epi, colData(epi)$annotation )
chosen <- marker.info[["enterocyte of anterior adult midgut epithelium"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])
# Question 6b
# The six top marker genes in the anterior midgut are Mal-A6, Men-b, vnd, betaTry, 
# Mal-A1, and Nhe2.
# This region of the gut appear to specialize in metabolizing carbohydrates.

plotExpression(gut, "Mal-A6", x="annotation" ) +
  theme(axis.text.x = element_text(angle = 90))

coi_2 <- colData(gut)$broad_annotation == "somatic precursor cell"
spc <- gut[,coi_2]
spc.marker.info <- scoreMarkers( spc, colData(spc)$annotation )
chosen_spc <- spc.marker.info[["intestinal stem cell"]]
ordered_spc <- chosen_spc[order(chosen_spc$mean.AUC, decreasing=TRUE),]

# Question 7
goi <- rownames(ordered_spc)[1:6]
plotExpression(spc, features = goi, x = "annotation") +
  theme(axis.text.x=element_text(angle=90)) 
# Enteroblasts and intestinal stem cells are more similar.
# DI looks most specific for intestinal stem cells
