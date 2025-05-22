#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J htseq_count
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH --output=/home/joel5434/genomanalys_project/code/09_read_counting/htseq.%j.out
#SBATCH --error=/home/joel5434/genomanalys_project/code/09_read_counting/htseq.%j.err

module load bioinfo-tools
module load htseq/2.0.2

BAMDIR="/home/joel5434/genomanalys_project/analyses/08_rna_mapping/untrimmed"
GFF="/home/joel5434/genomanalys_project/code/09_read_counting/efaecium_pacbio_cleaned.gff"
OUTDIR="/home/joel5434/genomanalys_project/code/09_read_counting"

mkdir -p "$OUTDIR/BH"
mkdir -p "$OUTDIR/Serum"

for BAM in $BAMDIR/BH/*_sorted.bam; do
    SAMPLE=$(basename "$BAM" _sorted.bam)
    echo "Counting reads for $SAMPLE (BH)..."
    htseq-count \
        --format bam \
        --order pos \
        --stranded no \
        --type CDS \
        --idattr ID \
        "$BAM" "$GFF" > "$OUTDIR/BH/${SAMPLE}_counts.txt"
done

for BAM in $BAMDIR/Serum/*_sorted.bam; do
    SAMPLE=$(basename "$BAM" _sorted.bam)
    echo "Counting reads for $SAMPLE (Serum)..."
    htseq-count \
        --format bam \
        --order pos \
        --stranded no \
        --type CDS \
        --idattr ID \
        "$BAM" "$GFF" > "$OUTDIR/Serum/${SAMPLE}_counts.txt"
done

