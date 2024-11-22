#!/usr/bin/env python

import numpy as np
import scipy
import matplotlib.pyplot as plt
import imageio
import plotly.express as px
import plotly
import os

genes = ["APEX1", "PIM2", "POLR2B", "SRSF1"]
fields = ["field0", "field1"]
channels = ["DAPI", "nascentRNA", "PCNA"]

img_data = []

for gene in genes:
    for field in fields:
        img_array = np.zeros((imageio.v3.imread(f"{gene}_{field}_DAPI.tif").shape[0],
                              imageio.v3.imread(f"{gene}_{field}_DAPI.tif").shape[1],
                              len(channels)), dtype=np.uint16)
        for i, channel in enumerate(channels):
            img_array[:, :, i] = imageio.v3.imread(f"{gene}_{field}_{channel}.tif").astype(np.uint16)
        img_data.append(img_array)
img_data = np.array(img_data)

masks = []

def find_labels(mask):
    l = 0
    labels = np.zeros(mask.shape, np.int32)
    equivalence = [0]
    for x in range(mask.shape[0]):
        for y in range(mask.shape[1]):
            if mask[x, y]:
                neighbors = []
                if x > 0 and labels[x - 1, y]:
                    neighbors.append(labels[x - 1, y])
                if y > 0 and labels[x, y - 1]:
                    neighbors.append(labels[x, y - 1])
                if neighbors:
                    labels[x, y] = min(neighbors)
                    for n in neighbors:
                        equivalence[n] = min(equivalence[n], labels[x, y])
                else:
                    l += 1
                    equivalence.append(l)
                    labels[x, y] = l
    equivalence = np.array(equivalence)
    for i in range(len(equivalence))[::-1]:
        labels[labels == i] = equivalence[i]
    ulabels = np.unique(labels)
    for i, j in enumerate(ulabels):
        labels[labels == j] = i
    return labels

def filter_by_size(labels, minsize, maxsize):
    sizes = np.bincount(labels.ravel())
    for i in range(1, sizes.shape[0]):
        if sizes[i] < minsize or sizes[i] > maxsize:
            labels[labels == i] = 0
    ulabels = np.unique(labels)
    for i, j in enumerate(ulabels):
        labels[labels == j] = i
    return labels

output_file = "nuclei.tsv"
with open(output_file, "w") as file:
    file.write("Gene_ID\tnascentRNA\tPCNA\tlog2ratio\n")

    for img_index, img_array in enumerate(img_data):
        dapi_img = img_array[:, :, 0]
        nrna_img = img_array[:, :, 1]
        pcna_img = img_array[:, :, 2]

        mask = dapi_img >= np.mean(dapi_img)
        labels = find_labels(mask)
        labels = filter_by_size(labels, 100, np.inf)

        sizes = np.bincount(labels.ravel())[1:]
        mean_size = np.mean(sizes)
        std_size = np.std(sizes)
        labels = filter_by_size(labels, mean_size - std_size, mean_size + std_size)

        num_nuclei = np.max(labels) + 1
        for nuc in range(1, num_nuclei):
            where = np.where(labels == nuc)
            nrna_signal = np.mean(nrna_img[where])
            pcna_signal = np.mean(pcna_img[where])
            log2_ratio = np.log2(nrna_signal / pcna_signal) if pcna_signal > 0 else np.nan
            gene = genes[img_index // 2]
            
            file.write(f"{gene}\t{nrna_signal}\t{pcna_signal}\t{log2_ratio}\n")
