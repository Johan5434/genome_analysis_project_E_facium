#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J RNA_trimming
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o /home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimonly_%j.log

module load bioinfo-tools trimmomatic/0.39

RAW_DIR=/home/joel5434/genomanalys_project/data/raw_data/transcriptomics_data
OUT_DIR=/home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimmed_reads
mkdir -p "$OUT_DIR"

for R1 in "$RAW_DIR"/RNA-Seq_BH/trim_paired_*_pass_1.fastq.gz "$RAW_DIR"/RNA-Seq_Serum/trim_paired_*_pass_1.fastq.gz; do
  R2=${R1%_pass_1.fastq.gz}_pass_2.fastq.gz
  SAMPLE=$(basename "$R1" _pass_1.fastq.gz)
  trimmomatic PE -threads 8 \
    "$R1" "$R2" \
    "$OUT_DIR"/${SAMPLE}_R1_paired.fastq.gz "$OUT_DIR"/${SAMPLE}_R1_unpaired.fastq.gz \
    "$OUT_DIR"/${SAMPLE}_R2_paired.fastq.gz "$OUT_DIR"/${SAMPLE}_R2_unpaired.fastq.gz \
    ILLUMINACLIP:/sw/apps/bioinfo/Trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50
done

