GTF="annotation.gtf"    #  path of GTF file
OUT="gene_counts.txt"

BAM_FILES=$(ls star_output/*Aligned.sortedByCoord.out.bam)

echo "Running featureCounts on:"
echo "$BAM_FILES"

featureCounts \
  -a "$GTF" \
  -o "$OUT" \
  -T 8 \
  -g gene_id \
  $BAM_FILES
