library(DESeq2)
library(vsn)
library(matrixStats)
library(readr)
library(dplyr)
library(tibble)
library(ggfortify)

setwd("/Users/cmdb/qbb2024-answers/week5")

data <- readr::read_tsv("salmon.merged.gene_counts.tsv")

data <- column_to_rownames(data, var = "gene_name")

data <- data %>% select(-gene_id)

data <- data %>% dplyr::mutate_if(is.numeric, as.integer)

data <- data[rowSums(data) > 100, ]

narrow <- data %>% dplyr::select(matches("A1|A2-3|Cu|LFC-Fe|Fe|P1|P2-4"))

narrow = dplyr::select(data,"A1_Rep1":"P2-4_Rep3")

metadata <- tibble(
  tissue = as.factor(c(
    "A1", "A1", "A1",
    "A2-3", "A2-3", "A2-3",
    "Cu", "Cu", "Cu",
    "LFC-Fe", "LFC-Fe", "Fe",
    "LFC-Fe","Fe","Fe",
    "P1","P1","P1",
    "P2-4","P2-4","P2-4"
  )),
  rep = as.factor(c(
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3",
    "rep1", "rep2", "rep3"))
)



narrowdata <- DESeqDataSetFromMatrix(countData = as.matrix(narrow), 
                              colData = metadata, 
                              design = ~tissue)

vst_data <- vst(narrowdata)

meanSdPlot(assay(vst_data))

pca_data = plotPCA(vst_data, intgroup=c("rep","tissue"), returnData=TRUE)
ggplot(pca_data, aes(PC1, PC2, color=tissue, shape=rep)) +
  geom_point(size=5)

ggsave("~/qbb2024-answers/week5/PCA.png")

matrix_data <- as.matrix(assay(vst_data))

combined = matrix_data[,seq(1, 21, 3)]
combined = combined + matrix_data[,seq(2, 21, 3)]
combined = combined + matrix_data[,seq(3, 21, 3)]
combined = combined / 3
matrix_data = matrix_data[rowSds(combined) > 1,]

set.seed(42)

k=kmeans(matrix_data, centers=12)$cluster
ordering = order(k)
k = k[ordering]

png("~/qbb2024-answers/week5/heatmap.png")
heatmap(matrix_data[ordering,],Rowv=NA,Colv=NA,RowSideColors = RColorBrewer::brewer.pal(12,"Paired")[k])
dev.off()

gene_names = rownames(matrix_data[k == 1,])
write.table(gene_names, "~/qbb2024-answers/week5/gene_names.txt", sep="\n", quote=FALSE, row.names=FALSE, col.names=FALSE)






