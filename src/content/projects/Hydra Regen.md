---
title: Hydra Regeneration
status: archived
summary: Rotation project about Hydra scRNAseq
link: https://github.com/marionhardy/hydra-regen
stack:
  - "[R]"
image: /projects/attachments/Pasted image 20260703142338.png
---
# Interstitial stem cells population and transcription factors in *Hydra Vulgaris* regeneration over 96 hours

Rotation in [Celina Juliano's lab](https://juliano.faculty.ucdavis.edu) studying the timeline of *Hydra* regeneration after bisection using scRNAseq obtained from Panagiotis Papasaikas from the [Tsiairis lab](https://www.fmi.ch/research-groups/groupleader.html?group=137).

## Introduction

### The Organism

*Hydra Vulgaris* is a fresh water polyp that spans about a millimeter and can regenerate any of its parts, even after bisection. It has an active stem cell population that supports fast and continual renewal of the entire animal within 4 days. *Hydra Vulgaris* is a very tractable model organism as it has a simple and well understood body plan with around 25 cell types.

![](/projects/attachments/Pasted%20image%2020260703142035.png)

[Siebert et al](https://doi.org/10.1126/science.aav9314) established an atlas of the *Hydra* developmental process, including the stem cell fate trajectories using scRNAseq on the whole animal.

![](/projects/attachments/Pasted%20image%2020260703142212.png)


### My Rotation Project

We know what the homeostatic animal stem cells do during development. Are the transcription factors and stem cells trajectories the same in an injury model? If so, when and where do these happen?

So I was handed a really nice data set to analyze.
### The Data

These data were acquired from our collaborator Panagiotis `rds` file for a SingleCellExperiment object containing the single cell data for **the interstitial cells** of *Hydra Vulgaris* (which is our population of interest) during multiples stages of regeneration after bisection. You can read the preprint [here](https://www.biorxiv.org/content/10.1101/2024.02.08.579449v1). 

![](/projects/attachments/Pasted%20image%2020260703155454.png)

The scRNAseq data were mapped to the *Hydra Magnipapillata* genome (102 version of 105). From the methods: "Quantification of the generated single cell libraries was performed using the Salmon-Alevin software suite (Salmon version 1.6.0) against the ncbi Hydra 102 transcriptome."

The `coldata` of the object contain cell annotation including:

-   quality metrics: nFeature nCount (not MT percentage interestingly)
-   batch info: either 2869 (3162 barcodes), 3113 (10352 barcodes), 3271
    (13279 barcodes), 3357 (3875 barcodes)
-   originating experiments (head or foot regeneration)
-   experimental time points
-   pseudo-axis assignment (vals.axis ranging from -1 to 1, increasing in
    the foot-tentacle direction)
-   mitotic and apoptotic signatures indices from 0 to 1

The `rowdata` contains gene annotation, using Entrez-gene identifiers. I
have also noticed that in the `sce` objects there's:

-   PCA, tSNE and UMAP coordinates for reduced dimensions + corrected
    for batch values
-   assay metafeatures hold gene_id, product, gene, is.rib.prot.gene
    (T/F), HypoMarkers (T/F), ccyle (T/F), apopt (T/F) etc

I converted the `sce` objects into a seurat object and did data processing + analysis.

### The Results

The initial UMAP projection and subsequent cluster identification gave us 20 populations from the interstitial cells.

![](/projects/attachments/Pasted%20image%2020260703142327.png)

Using the existing annotations, and completing the unknown cluster markers using BLAST, I ended up with enough cluster-specific markers to identify the different cell types.

![](/projects/attachments/Pasted%20image%2020260703142332.png)


![](/projects/attachments/Pasted%20image%2020260703142338.png)

Following this, I didn't have the time or coding skills to do a trajectory analysis but I did check the relative proportion of cell populations over time as well as their cycling and apoptosis scores. This lead to a few interesting hypotheses that are being looked into as future projects from the lab. One thing I can share is the expression level of different transcription factors over time in the injured animal and absent in the homeostatic animal (by referring to the *Hydra* atlas that is available via the Juliano lab).

![](/projects/attachments/Pasted%20image%2020260703174059.png)


This was a very fun foray into the developmental biology field, which I'd never explored before (besides in class), and I'm very grateful for the warm welcome I received over these five weeks. Hopefully this contribution was useful and ends up spinning off a cool project.

