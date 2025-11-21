#!/usr/bin/env Rscript

library(DESeq2)

# Load data
countData <- read.csv("gene_counts.txt", sep="\t", comment.char="#", row.names=1)
countData <- countData[ ,6:ncol(countData)]

# Sample metadata
samples <- data.frame(
  row.names = colnames(countData),
  condition = c("Case", "Control")  # Edit according to your experiment
)

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = samples,
                              design = ~ condition)

# Run DESeq2
dds <- DESeq(dds)
res <- results(dds)

# Save DEG results
write.csv(res, "DEG_results.csv")

# MA Plot
png("MAplot.png")
plotMA(res, ylim=c(-5,5))
dev.off()

# Volcano plot
library(ggplot2)

res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

png("VolcanoPlot.png")
ggplot(res_df, aes(log2FoldChange, -log10(pvalue))) +
  geom_point(alpha=0.5) +
  theme_minimal()
dev.off()
