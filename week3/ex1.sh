#!/usr/bin/env bash

#Question 1.1

read_length=$(awk 'NR % 4 == 2 { total_length += length($0); count++ } END { print total_length/count }' A01_09.fastq)
echo $read_length

# The length of the sequencing reads is 76 bp.


#Question 1.2

read_count=$(($(wc -l < A01_09.fastq) / 4))
echo $read_count

#There are 669548 sequencing reads.

#Question 1.3

sac_genome_len=$(wc -m < sacCer3.fa)
cov=$(echo "${read_count} * ${read_length} / ${sac_genome_len}" | bc -l)
echo $cov

#The expected average depth of coverage is 4.1 x.

#Question 1.4

echo -n "" > sizes.txt
for i in 09 11 23 24 27 31 35 39 62 63
do
    file=A01_${i}.fastq
    file_size=$(du -m ${file} | cut -f1)
    echo -e "${file}: ${file_size}M" >> sizes.txt
done

max=$(sort -k2 -nr sizes.txt | head -n 1)
min=$(sort -k2 -n sizes.txt | head -n 1)

echo $max
echo $min

#The A01_62.fastq file has the largest file size. The A01_27.fastq has the smallest file size.

fastqc *.fastq

#The median base quality along the read is around 36.
#This means the probability of a given base being an error is around 1 in 4000 bases or 0.0251%.
#I don't see much variation in quality with respect to the position in the read. The quality of the sequences is generally high.
#Though there is a little variation at the beginning and the end of the reads.
