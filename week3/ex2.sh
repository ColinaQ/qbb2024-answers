#!/usr/bin/env bash

# Step 2.1

#wget https://hgdownload.cse.ucsc.edu/goldenPath/sacCer3/bigZips/sacCer3.fa.gz
#gunzip sacCer3.fa.gz
#bwa index sacCer3.fa
head sacCer3.fa.amb
# There are 17 chromosomes in the yeast genome.

# Step 2.2 and Step 2.4

sac_genome="sacCer3.fa"

samples=("A01_09" "A01_11" "A01_23" "A01_24" "A01_27" "A01_31" "A01_35" "A01_39" "A01_62" "A01_63")

for sample in "${samples[@]}"
do
    fastq_file="${sample}.fastq"
    sam_file="${sample}.sam"
    
    bwa mem -t 4 -R "@RG\tID:${sample}\tSM:${sample}" $sac_genome $fastq_file > $sam_file
    
    sorted_bam_file="${sample}_sorted.bam"
    
    samtools sort -O bam -o $sorted_bam_file $sam_file

    samtools index $sorted_bam_file
done


# Question 2.2

grep -v '^@' A01_09.sam | wc -l

# There are 669548 total read alignments recorded in the SAM file.

# Question 2.3

grep -v '^@' A01_09.sam | awk '$3 == "chrIII"' | wc -l

# There are 17815 alignments that are to loci on chromosome III

# Step 2.5

# Question 2.4
# The depth of coverage does not seem to match what I estimated in Step 1.3. Some regions have higher coverage while other regions
# have lower coverage. This is because the number from Step 1.3 is an average of coverage across the entire genome.

# Question 2.5
# From what I observed, I think there are 2 SNPs, since they appear across multiple reads. However, there is one location where
# it only appears in two reads. It's hard to say if it's an SNP or not without deeper sequencing.

# Question 2.6
# The position of the SNP in this window is chrIV:825,834. It does not fall within a gene based on the RefSeq annotation.

