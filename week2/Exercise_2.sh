#!/bin/bash

echo -e "MAF\tFeature\tEnrichment" > snp_counts.txt

for MAF in 0.1 0.2 0.3 0.4 0.5
do 
    maf_file=chr1_snps_${MAF}.bed

    bedtools coverage -a genome_chr1.bed -b ${maf_file} > coverage_${MAF}.txt 

    total_SNP=$(awk '{s+=$4}END{print s}' coverage_${MAF}.txt)
    total_bases=$(awk '{s+=$6}END{print s}' coverage_${MAF}.txt)
    density=$(echo "scale=6; ${total_SNP}/${total_bases}" | bc -l)


    for feature in exons introns cCREs other
    do
        feature_file=${feature}_chr1.bed

        bedtools coverage -a ${feature_file} -b ${maf_file} > ${MAF}_${feature}.txt

        feature_total_SNP=$(awk '{s+=$4}END{print s}' ${MAF}_${feature}.txt)
        feature_total_bases=$(awk '{s+=$6}END{print s}' ${MAF}_${feature}.txt)
        echo ${feature_total_bases}

        feature_density=$(echo "scale=6; ${feature_total_SNP}/${feature_total_bases}" | bc -l)
        enrichment=$(echo "scale=6; ${feature_density}/${density}" | bc -l)

        echo -e "${MAF}\t${feature}\t${enrichment}"  >> snp_counts.txt
        
    done
done

