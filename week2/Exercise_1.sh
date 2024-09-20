#!/bin/bash

#Exercise 1

bedtools sort -i genes.bed > genes_chr1.bed
bedtools sort -i exons.bed > exons_chr1.bed
bedtools sort -i cCREs.bed > cCREs_chr1.bed

bedtools merge -i genes_chr1.bed > merged_genes_chr1.bed
bedtools merge -i exons_chr1.bed > merged_exons_chr1.bed
bedtools merge -i cCREs_chr1.bed > merged_cCREs_chr1.bed

bedtools subtract -a merged_genes_chr1.bed -b merged_exons_chr1.bed > introns_chr1.bed

bedtools subtract -a merged_genes_chr1.bed -b merged_exons_chr1.bed merged_cCREs_chr1.bed introns_chr1.bed > other_chr1.bed



