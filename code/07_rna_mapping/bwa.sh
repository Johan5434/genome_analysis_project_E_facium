#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4                  # antal cores
#SBATCH -t 02:00:00
#SBATCH -J BWA_MAPPING
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o bwa_mapping_%j.log

module load bioinfo-tools
module load bwa

# Paths
REF="/home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta"
R1="/home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimmed_reads_second_try/trimmed_reads_second_try/ERR1797969/ERR1797969_R1_paired.fastq.gz"
R2="/home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimmed_reads_second_try/trimmed_reads_second_try/ERR1797969/ERR1797969_R2_paired.fastq.gz"
OUT_DIR="/home/joel5434/genomanalys_project/analyses/08_rna_mapping/Serum"
OUT_FILE="$OUT_DIR/ERR1797969.sam"

# Create output directory if it doesn't exist
mkdir -p "$OUT_DIR"

# Run BWA
bwa mem -t 4 "$REF" "$R1" "$R2" > "$OUT_FILE"

