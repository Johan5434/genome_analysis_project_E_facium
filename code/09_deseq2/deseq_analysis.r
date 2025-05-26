if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
for (pkg in c("DESeq2", "pheatmap", "dplyr")) {
  if (!requireNamespace(pkg, quietly = TRUE)) BiocManager::install(pkg, ask = FALSE)
  library(pkg, character.only = TRUE)
}
output_dir <- "outputs"
if (!dir.exists(output_dir)) dir.create(output_dir)

bh_dir    <- "/Users/johaneliasson/desktop/readcounts/BH"
serum_dir <- "/Users/johaneliasson/desktop/readcounts/Serum"

bh_files    <- list.files(bh_dir,    pattern="*_counts.txt", full.names=TRUE)
serum_files <- list.files(serum_dir, pattern="*_counts.txt", full.names=TRUE)
all_files   <- c(bh_files, serum_files)

sample_names <- gsub("_counts.txt","", basename(all_files))
conditions   <- factor(c(rep("BH", length(bh_files)),
                         rep("Serum", length(serum_files))),
                       levels=c("BH","Serum"))
sample_table <- data.frame(sample = sample_names, condition = conditions,
                           row.names = sample_names)

count_list   <- lapply(all_files, \(f) read.delim(f, header=FALSE, row.names=1))
count_matrix <- do.call(cbind, count_list)
colnames(count_matrix) <- sample_names

dds  <- DESeqDataSetFromMatrix(count_matrix, sample_table, design = ~ condition)
dds  <- dds[rowSums(counts(dds))>10, ]
dds  <- DESeq(dds)
vsd  <- vst(dds, blind = FALSE)
expr <- assay(vsd)

gff <- read.delim("efaecium_pacbio.gff", comment="#", header=FALSE, sep="\t")
cds <- gff[gff$V3=="CDS", ]

extract_info <- function(x){
  c(id      = sub(".*ID=([^;]+);.*","\\1",x),
    gene    = ifelse(grepl("gene=",x),
                     sub(".*gene=([^;]+).*","\\1",x), NA),
    product = ifelse(grepl("product=",x),
                     sub(".*product=([^;]+).*","\\1",x), NA))
}
gene_info <- as.data.frame(t(sapply(cds$V9, extract_info)), stringsAsFactors = FALSE)
rownames(gene_info) <- gene_info$id

group_means <- sapply(levels(conditions), \(cond)
                      rowMeans(expr[, sample_table$condition==cond, drop=FALSE]))
diff_expr   <- group_means[,"Serum"] - group_means[,"BH"]
names(diff_expr) <- rownames(expr)

top_up   <- sort(diff_expr,  decreasing=TRUE)[1:10]
top_down <- sort(diff_expr,  decreasing=FALSE)[1:10]

plot_with_product <- function(gene_list, filename, title){
  mat  <- expr[names(gene_list), , drop=FALSE]
  rows <- paste0(names(gene_list),
                 " (", gene_info[rownames(mat),"product"], ")")
  rownames(mat) <- rows
  pdf(file.path(output_dir, filename), 6, 6)
  pheatmap(mat, cluster_rows=TRUE, cluster_cols=TRUE, main=title)
  dev.off()
}

plot_with_gene_only <- function(gene_list, filename, title){
  mat       <- expr[names(gene_list), , drop=FALSE]
  gene_lbl  <- gene_info[rownames(mat),"gene"]
  gene_lbl[is.na(gene_lbl)] <- rownames(mat)
  rownames(mat) <- gene_lbl
  pdf(file.path(output_dir, filename), 6, 6)
  pheatmap(mat, cluster_rows=TRUE, cluster_cols=TRUE, main=title)
  dev.off()
}

plot_with_product(top_up,   "Top10_Upregulated_in_Serum_vs_BH_annotated.pdf",
                  "Top 10 (Serum > BH) — produktnamn")
plot_with_product(top_down, "Top10_Upregulated_in_BH_vs_Serum_annotated.pdf",
                  "Top 10 (BH > Serum) — produktnamn")

plot_with_gene_only(top_up,   "Top10_Upregulated_in_Serum_vs_BH_geneONLY.pdf",
                    "Top 10 gener uppreglerade i Serum")
plot_with_gene_only(top_down, "Top10_Upregulated_in_BH_vs_Serum_geneONLY.pdf",
                    "Top 10 gener uppreglerade i BH")

