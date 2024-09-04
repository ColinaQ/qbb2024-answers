#!/usr/bin/env python3

import sys

my_file = open(sys.argv[1])

for i in my_file:
    line1 = i.rstrip("\n")
    if "##" in i:
        continue
    line2 = line1.split("\t")
    line3 = line2[8].split(";")
    line4 = line3[2]
    line5 = line4.lstrip("gene_name \"").rstrip("\"")
    print(line2[0]+ "\t" + line2[3] + "\t" + line2[4] + "\t" + line5)

