#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J RNA_FastQC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o /home/joel5434/genomanalys_project/analyses/07_rna_trimming/rna_fastqc_%j.log

module load bioinfo-tools FastQC

INPUT_DIR="/home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimmed_reads_second_try"
OUTPUT_DIR="/home/joel5434/genomanalys_project/analyses/07_rna_trimming/fastqc_second_try"

mkdir -p "$OUTPUT_DIR"

# Iterate over all fastq.gz files in each sample directory
for sample_dir in "$INPUT_DIR"/*; do
    sample=$(basename "$sample_dir")
    sample_output_dir="$OUTPUT_DIR/$sample"
    mkdir -p "$sample_output_dir"
    
    # Run FastQC on all .fastq.gz files in the current sample directory
    for fq in "$sample_dir"/*.fastq.gz; do
        fastqc -t 2 "$fq" -o "$sample_output_dir"
    done
done
