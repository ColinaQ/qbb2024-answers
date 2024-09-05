##open file
##skip 2 lines
##split column header by tabs and skip first two entries
##create way to hold gene names
##create way to hold expression values
##for each line
##    split line
##    save field 1 into gene names
##    save 2+ into expression values


#!/usr/bin/env python3

import sys
import numpy

#open file
fs = open(sys.argv[1],mode='r')

#skip 2 lines
fs.readline()
fs.readline()

#
line = fs.readline()
fields = line.strip("\n").split("\t")
tissues = fields[2:]
gene_names = []
gene_IDs = []
expression = []

# for each line
for line in fs:
#   split line
    fields = line.strip("\n").split("\t")
#   save field 0 into gene IDs
    gene_IDs.append(fields[0])
#   save 2+ into expression values
    expression.append(fields[2:])
fs.close()

tissues = numpy.array(tissues)
gene_IDs = numpy.array(gene_IDs)
gene_names = numpy.array(gene_names)
expression = numpy.array(expression, dtype=float)

#######################################################
#Q4
tissue_expression_mean = numpy.mean(expression[:10,:], axis = 1)
#print(tissue_expression_mean)

#Q5
expression_mean = numpy.mean(expression[:,:])
expression_median = numpy.median(expression[:,:])

#print(expression_mean)
#print(expression_median)

#Q6
expression_log_1 = numpy.log2(expression + 1)
expression_log_mean = numpy.mean(expression_log_1)
expression_log_median = numpy.median(expression_log_1)
#print(expression_log_mean)
#print(expression_log_median)

#7
expression_log_copy = numpy.copy(expression_log_1)

expression_log_copy_sorted = numpy.sort(expression_log_copy, axis = 1)


#print(expression_log_copy_sorted)

#print(expression_log_copy_sorted[:,-1:])

expression_1st_2nd_diff = expression_log_copy_sorted[:,-1] - expression_log_copy_sorted[:,-2]
#print(expression_1st_2nd_diff)

#8
num_greater_10 = numpy.sum(expression_1st_2nd_diff >= 10)
#print(num_greater_10)





