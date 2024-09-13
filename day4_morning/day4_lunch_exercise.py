#!/usr/bin/env python3

import sys

import numpy

#Q1
# get file name
filename = sys.argv[1]
# open file
fs = open(filename, mode = 'r')
# create dict to hold samples for gene-tissue pairs
relevant_samples = {}
# step through file
for line in fs:
    # Split line into fields
    fields = line.rstrip("\n").split("\t")
    # Create key from gene and tissue
    key = (fields [0], fields[2])
    # Initialize dict from key with list to hold samples
    relevant_samples[key] = []
fs.close()

#print(relevant_samples)

#############################################################
#Q2
# get file name
filename = sys.argv[2]
# open file
fs = open(filename, mode = 'r')
# Skip line
fs.readline()
# Create dict to hold samples for tissue name
tissue_samples = {}
# Loop through file
for line in fs:
    # Split line into fields
    fields = line.rstrip("\n").split("\t")
    # Create key from gene and tissue
    key = fields[6]
    value = fields[0]
    # Initialize dict from key with list to hold samples
    tissue_samples.setdefault(key, [])
    tissue_samples[key].append(value)
fs.close()

#print(tissue_samples)

#############################################################
#Q3
# get file name
filename = sys.argv[3]
# open file
fs = open(filename, mode = 'r')
# Skip line
fs.readline()
fs.readline()
# Read the third line
header = fs.readline().rstrip("\n").split("\t")
# Remove the first two elements of the header list
header = header[2:]

# Initialize an empty dict to store the column indexes for each tissue type
tissue_columns = {}
# Loop over each tissue
for tissue, samples in tissue_samples.items():
    tissue_columns.setdefault(tissue, [])
    # Loop over each sample paired with the the specific tissue
    for sample in samples:
        # Check for the sample ID
        if sample in header:
            position = header.index(sample)
            tissue_columns[tissue].append(position)

#print(tissue_columns)

#############################################################
#Q4
# Create a dict to hold sampleID and column index
sample_column_index = {}

# Loop through each tissue and its relevant sample IDs
for tissue, samples in tissue_samples.items():
    for sample in samples:
        if sample in header:
            # Find the index of the sample in the header
            position = header.index(sample)
            # Map the sampleID to its column index
            sample_column_index[sample] = position


#print(sample_column_index)

#############################################################
# Q5

# Create a new dict to hold tissues and their column indexes
tissue_column_indexes = {}

# Loop through each tissue in the tissue_samples dict (from step 2)
for tissue, samples in tissue_samples.items():
    # Initialize the tissue in the new dict with an empty list
    tissue_column_indexes[tissue] = []
    # Loop through each sampleID for the current tissue
    for sample in samples:
        # Check if the sampleID has a column index in the sample_column_index dict (from step 4)
        if sample in sample_column_index:
            # Append the corresponding column index to the tissue's list
            tissue_column_indexes[tissue].append(sample_column_index[sample])

print(tissue_column_indexes)

# Check how many samples each tissue has by checking the length of each list
tissue_sample_counts = {tissue: len(columns) for tissue, columns in tissue_column_indexes.items()}
# Find the tissue with the most and fewest samples
max_samples_tissue = max(tissue_sample_counts, key=tissue_sample_counts.get)
min_samples_tissue = min(tissue_sample_counts, key=tissue_sample_counts.get)

#print(tissue_sample_counts)
#print(max_samples_tissue)
#print(min_samples_tissue)

#The skeletal muscle has the largest number of samples; the leukemia cell ine has the fewest number of samples.

#############################################################
#6 is shown as above.
#############################################################
