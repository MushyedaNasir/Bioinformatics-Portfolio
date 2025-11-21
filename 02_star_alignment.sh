#!/bin/bash
THREADS=8
GENOME_DIR="genome_index"

# Input files
R1="sample_R1.fastq.gz"
R2="sample_R2.fastq.gz"
mkdir -p star_output

# Runing STAR
STAR \
  --runThreadN $THREADS \
  --genomeDir $GENOME_DIR \
  --readFilesIn $R1 $R2 \
  --readFilesCommand zcat \
  --outSAMtype BAM SortedByCoordinate \
  --outFileNamePrefix star_output/
