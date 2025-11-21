library(DESeq2)
library(ggplot2)

counts <- read.delim("gene_counts.txt",
                     comment.char = "#",
                     check.names = FALSE)


rownames(counts) <- counts$Geneid
count_matrix <- counts[, 7:ncol(counts)]

# 2)  sample info
# Example: 3 COVID and 3 Control samples
sample_names <- colnames(count_matrix)

sample_info <- data.frame(
  row.names = sample_names,
  condition = c("COVID", "COVID", "COVID",
                "Control", "Control", "Control") 
)

# DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = sample_info,
                              design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)

#Saving table
write.csv(as.data.frame(res), file = "DEG_results.csv")



#  Volcano plot
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

png("VolcanoPlot.png")
ggplot(res_df, aes(x = log2FoldChange, y = -log10(pvalue))) +
  geom_point(alpha = 0.5) +
  theme_minimal()
dev.off()
