#!/usr/bin/env python

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']

graph = set()

k = 3

for read in reads:
    for i in range(len(read) - k):
        kmer1 = read[i:i+k]
        kmer2 = read[i+1:i+1+k]
        graph.add(f"{kmer1} -> {kmer2}")

for edge in graph:
    print(edge)

with open("step_2_1.txt", "w") as file:
    for edge in graph:
        file.write(edge + "\n")