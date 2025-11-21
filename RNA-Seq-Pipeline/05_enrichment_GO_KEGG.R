library(clusterProfiler)
library(org.Hs.eg.db)
library(ReactomePA)
library(dplyr)
library(ggplot2)

# Load DESeq2 results
deg <- read.csv("DEG_results.csv", row.names = 1)

# Filter significant genes
sig <- deg %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 1)

genes <- rownames(sig)

# Convert gene symbols → ENTREZ IDs
entrez <- mapIds(org.Hs.eg.db,
                 keys = genes,
                 column = "ENTREZID",
                 keytype = "SYMBOL",
                 multiVals = "first")

entrez <- na.omit(entrez)

# ---------------------------
# GO: Biological Process (BP)
# ---------------------------
ego_BP <- enrichGO(
    gene          = entrez,
    OrgDb         = org.Hs.eg.db,
    ont           = "BP",
    pAdjustMethod = "BH",
    readable      = TRUE
)

write.csv(as.data.frame(ego_BP), "GO_BP_results.csv")


# ---------------------------
# GO: Cellular Component (CC)
# ---------------------------
ego_CC <- enrichGO(
    gene          = entrez,
    OrgDb         = org.Hs.eg.db,
    ont           = "CC",
    pAdjustMethod = "BH",
    readable      = TRUE
)

write.csv(as.data.frame(ego_CC), "GO_CC_results.csv")


# ---------------------------
# GO: Molecular Function (MF)
# ---------------------------
ego_MF <- enrichGO(
    gene          = entrez,
    OrgDb         = org.Hs.eg.db,
    ont           = "MF",
    pAdjustMethod = "BH",
    readable      = TRUE
)

write.csv(as.data.frame(ego_MF), "GO_MF_results.csv")
# BP Barplot
png("GO_BP_barplot.png", width=1200, height=900)
barplot(ego_BP, showCategory = 20, title = "GO Biological Process (BP)")
dev.off()

# CC Barplot
png("GO_CC_barplot.png", width=1200, height=900)
barplot(ego_CC, showCategory = 20, title = "GO Cellular Component (CC)")
dev.off()

# MF Barplot
png("GO_MF_barplot.png", width=1200, height=900)
barplot(ego_MF, showCategory = 20, title = "GO Molecular Function (MF)")
dev.off()


# ---------------------------
# DOTPLOTS
# ---------------------------

# BP Dotplot
png("GO_BP_dotplot.png", width=1200, height=900)
dotplot(ego_BP, showCategory = 20, title = "GO Biological Process (BP)")
dev.off()

# CC Dotplot
png("GO_CC_dotplot.png", width=1200, height=900)
dotplot(ego_CC, showCategory = 20, title = "GO Cellular Component (CC)")
dev.off()

# MF Dotplot
png("GO_MF_dotplot.png", width=1200, height=900)
dotplot(ego_MF, showCategory = 20, title = "GO Molecular Function (MF)")
dev.off()

# KEGG Pathways
ekegg <- enrichKEGG(gene = names(entrez),
                    organism = "hsa",
                    pvalueCutoff = 0.05)

write.csv(ekegg, "KEGG_results.csv")

png("KEGG_top20.png", width=900, height=700)
barplot(ekegg, showCategory = 20)
dev.off()

