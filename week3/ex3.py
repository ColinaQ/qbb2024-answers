#!/usr/bin/env python

import sys
import pandas as pd
import numpy as np

vcf_file = sys.argv[1]

af_output = "AF.txt"

allele_freq = []

with open(vcf_file, "r") as vcf:
    for line in vcf:
        if line.startswith('#'):
            continue
        fields = line.rstrip('\n').split('\t')
        info = fields[7]
        info_write = info.split(';')
        for item in info_write:
            if item.startswith('AF='):
                af_value = float(item.split('=')[1])
                allele_freq.append(af_value)

allele_freq = np.array(allele_freq)

allele_freq_data = pd.DataFrame(allele_freq, columns=["Allele Frequency"])
allele_freq_data.to_csv(af_output, index=False)


# Question 3.1

# The resulting histogram looks kind of like a normalized shape, and most variants have allele frequencies of 0.5.
# This is expected because having a 0.5 allele frequency for most gene is beneficial in coping with the selective pressure.
# Some genes having either very small or large allele frequency also suggest a certain selective direction.

# Step 3.2

import sys

vcf_file = sys.argv[1]

DP_output = "DP.txt"

with open(vcf_file, 'r') as vcf, open(DP_output, 'w') as dp_out:
    dp_out.write("Read Depth\n")

    for line in vcf:
        if line.startswith('#'):
            continue

        fields = line.rstrip('\n').split('\t')
        format_field = fields[8]
        data = fields[9:] 
        format_items = format_field.split(':')

        if "DP" in format_items:
            dp_index = format_items.index("DP")

            for i in data:
                i_items = i.split(':')
                if len(i_items) > dp_index:
                    dp_value = i_items[dp_index]
                    dp_out.write(f"{dp_value}\n")


# Question 3.2

# The resulting plot looks skewed towards the left. This is expected because it looks like most regions have around 4x
# coverage. The other regions might have been the result of either improper library preparation or highly repetitive
# regions.