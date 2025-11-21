THREADS=8
GENOME_DIR="genome_index"   # diresctory name

mkdir -p star_output

for R1 in *_R1.fastq.gz
do
    SAMPLE=${R1%_R1.fastq.gz}
    R2="${SAMPLE}_R2.fastq.gz"

    echo "Processing sample: $SAMPLE"

    STAR \
      --runThreadN $THREADS \
      --genomeDir "$GENOME_DIR" \
      --readFilesIn "$R1" "$R2" \
      --readFilesCommand zcat \
      --outSAMtype BAM SortedByCoordinate \
      --outFileNamePrefix "star_output/${SAMPLE}_"
done
