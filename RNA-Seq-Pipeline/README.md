# COVID-19 Nasal Swab RNA-Seq Analysis

This project contains the complete RNA-Seq pipeline used for analyzing
COVID-19 positive patients’ **nasopharyngeal (nasal swab) samples**.  
The workflow includes quality control, alignment, quantification,
differential expression analysis (DEG), and functional enrichment.

The scripts included here (`.sh` and `.R` files) represent the exact workflow
used in the analysis performed during my research and manuscript preparation.

---

## Project Overview

- **Sample Type:** COVID-19 patients’ *nasopharyngeal/nasal swab* samples  
- **Platform:** Illumina RNA-Seq  
- **Organism:** Human (GRCh38)  
- **Objective:** Identify differentially expressed genes and immune-related
  pathways activated in COVID-19 infection  
- **Tools Used:** FastQC, STAR, FeatureCounts, Samtools, DESeq2, ggplot2, Python  
- **Output:** Quality reports, aligned BAM files, gene count matrix



