THREADS=8
GENOME_DIR="genome_index"   # diresctory name

mkdir -p star_output

for R1 in *_R1_001.fastq.gz
do
    # Remove the R1 part to extract sample name
    SAMPLE=${R1%_R1_001.fastq.gz}

    # Construct the R2 filename
    R2="${SAMPLE}_R2_001.fastq.gz"

    echo "Processing sample: $SAMPLE"
    echo "Forward: $R1"
    echo "Reverse: $R2"
    echo "-------------------------------------"

    # Runing
    STAR \
      --runThreadN $THREADS \
      --genomeDir "$GENOME_DIR" \
      --readFilesIn "$R1" "$R2" \
      --readFilesCommand zcat \
      --outSAMtype BAM SortedByCoordinate \
      --outFileNamePrefix "star_output/${SAMPLE}_"
done
