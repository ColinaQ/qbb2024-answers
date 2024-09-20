#!/usr/bin/env python

import numpy as np
import scipy

genome = 1000000
read_length = 100
#coverage = 30
size_30x = 300000

coverage_array = np.zeros(genome, dtype = int)

start_pos = np.random.randint(0, 999901, size = size_30x)

for start in start_pos:
    coverage_array[start:start + read_length] += 1

np.savetxt('coverage_30x.txt', coverage_array, fmt='%d')