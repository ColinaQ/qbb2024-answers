# day2-lunch answers

# BioMart
## Answer 1

- `head hg38-gene-metadata-feature.tsv`
- `cut -f 7 hg38-gene-metadata-feature.tsv | sort | uniq -c`

- `cut -f 7 hg38-gene-metadata-feature.tsv | sort | uniq -c | grep "protein_coding"`
- There are 19618 protein_coding genes. I want to learn more about miRNA because it is important in regulating gene expression.

## Answer 2

- `head hg38-gene-metadata-go.tsv`
- `cut -f 1 hg38-gene-metadata-go.tsv | sort | uniq -c | sort -n`
- The ENSG00000168036 ensembl_gene_id has the most go_ids. 
- `grep -w "ENSG00000168036" hg38-gene-metadata-go.tsv > ENSG00000168036.txt | sort -k3 > ENSG00000168036.txt`
- I think this gene codes for a structural protein.

# GENCODE
## Answer 1

- `grep -w -e "IG...gene" -e "IG....gene" gene.gtf | cut -f 1 | sort | uniq -c`
- The number of IG genes present on each chromosome is as follows:
  91 chr14
  16 chr15
   6 chr16
  52 chr2
   1 chr21
  48 chr22

- `grep -w -e "IG.pseudogene" -e "IG...pseudogene" gene.gtf | cut -f 1 | sort | uniq -c`
- The number of IG pseudogenes present on each chromosome is as follows:
   1 chr1
   1 chr10
  84 chr14
   6 chr15
   8 chr16
   1 chr18
  45 chr2
  48 chr22
   1 chr8
   5 chr9

## Answer 2

- This is not an effective way because it is not specific enough. It would grep everything with "pseudogene", not just the ones in the gene_type column. It would be better to cut that column first, for example, using grep -w 'gene_type "pseudogene"' gene.gtf


## Answer 3

- `sed "s/ /\t/g" gene.gtf > gene-tabs.gtf`
- `cut -f 1,4,5,14 gene-tabs.gtf > gene-tabs.bed`
