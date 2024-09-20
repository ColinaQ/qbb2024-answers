#!/usr/bin/env python

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']

graph = set()

k = 3

for read in reads:
    for i in range(len(read) - k):
        kmer1 = read[i:i+k]
        kmer2 = read[i+1:i+1+k]
        graph.add((kmer1, kmer2))

with open("step_2_3.dot", "w") as file:
    file.write("digraph G {\n")
    for kmer1, kmer2 in graph:
        file.write(f'    "{kmer1}" -> "{kmer2}";\n')
    file.write("}\n")