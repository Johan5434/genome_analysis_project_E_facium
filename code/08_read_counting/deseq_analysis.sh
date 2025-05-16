#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J deseq2_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH --output=/home/joel5434/genomanalys_project/code/10_deseq2/deseq2.%j.out
#SBATCH --error=/home/joel5434/genomanalys_project/code/10_deseq2/deseq2.%j.err

module load bioinfo-tools
module load R/4.2.0

DATADIR="/home/joel5434/genomanalys_project/code/09_read_counting"
OUTDIR="/home/joel5434/genomanalys_project/code/10_deseq2"
COUNTS="$DATADIR/combined_counts_final.txt"
COLDATA="$DATADIR/colData.txt"

mkdir -p "$OUTDIR"

Rscript -e "
library(DESeq2)
counts <- read.delim('$COUNTS', row.names=1, header=TRUE)
colData <- read.delim('$COLDATA', row.names=1, header=TRUE)
dds <- DESeqDataSetFromMatrix(countData=counts, colData=colData, design=~condition)
dds <- DESeq(dds)
res <- results(dds, alpha=0.05)
write.csv(as.data.frame(res), file='$OUTDIR/deseq2_results.csv')
write.csv(as.data.frame(counts(dds, normalized=TRUE)), file='$OUTDIR/normalized_counts.csv')
write.csv(as.data.frame(dds@colData), file='$OUTDIR/colData_used.csv')
"

echo "DESeq2 analysis complete!"

