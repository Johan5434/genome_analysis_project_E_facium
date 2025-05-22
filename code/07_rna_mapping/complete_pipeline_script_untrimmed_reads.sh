#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 04:00:00
#SBATCH -J RNA_MAPPING
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o rna_mapping_untrimmed_%j.log

module load bioinfo-tools
module load bwa
module load samtools/1.20

BASE_DIR="/home/joel5434/genomanalys_project/data/raw_data/transcriptomics_data"
REF="/home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta"
OUT_DIR="/home/joel5434/genomanalys_project/analyses/08_rna_mapping/untrimmed"
SERUM_OUT="$OUT_DIR/Serum"
BH_OUT="$OUT_DIR/BH"

mkdir -p "$SERUM_OUT"
mkdir -p "$BH_OUT"

R1_SERUM_69="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797969_pass_1.fastq.gz"
R2_SERUM_69="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797969_pass_2.fastq.gz"

R1_SERUM_70="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797970_pass_1.fastq.gz"
R2_SERUM_70="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797970_pass_2.fastq.gz"

R1_SERUM_71="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797971_pass_1.fastq.gz"
R2_SERUM_71="$BASE_DIR/RNA-Seq_Serum/trim_paired_ERR1797971_pass_2.fastq.gz"

R1_BH_72="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797972_pass_1.fastq.gz"
R2_BH_72="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797972_pass_2.fastq.gz"

R1_BH_73="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797973_pass_1.fastq.gz"
R2_BH_73="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797973_pass_2.fastq.gz"

R1_BH_74="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797974_pass_1.fastq.gz"
R2_BH_74="$BASE_DIR/RNA-Seq_BH/trim_paired_ERR1797974_pass_2.fastq.gz"

# Serum samples 
for SAMPLE in 69 70 71; do
    R1_VAR="R1_SERUM_$SAMPLE"
    R2_VAR="R2_SERUM_$SAMPLE"
    R1="${!R1_VAR}"
    R2="${!R2_VAR}"

    BASENAME=$(basename "$R1" | cut -d_ -f3)
    SAM_FILE="$SERUM_OUT/${BASENAME}.sam"
    BAM_FILE="$SERUM_OUT/${BASENAME}.bam"
    SORTED_BAM_FILE="$SERUM_OUT/${BASENAME}_sorted.bam"

    bwa mem -t 4 "$REF" "$R1" "$R2" > "$SAM_FILE"
    samtools view -Sb "$SAM_FILE" > "$BAM_FILE"
    rm "$SAM_FILE"
    samtools sort -o "$SORTED_BAM_FILE" "$BAM_FILE"
    samtools index "$SORTED_BAM_FILE"
    rm "$BAM_FILE"
done

# BH samples
for SAMPLE in 72 73 74; do
    R1_VAR="R1_BH_$SAMPLE"
    R2_VAR="R2_BH_$SAMPLE"
    R1="${!R1_VAR}"
    R2="${!R2_VAR}"

    BASENAME=$(basename "$R1" | cut -d_ -f3)
    SAM_FILE="$BH_OUT/${BASENAME}.sam"
    BAM_FILE="$BH_OUT/${BASENAME}.bam"
    SORTED_BAM_FILE="$BH_OUT/${BASENAME}_sorted.bam"

    bwa mem -t 4 "$REF" "$R1" "$R2" > "$SAM_FILE"
    samtools view -Sb "$SAM_FILE" > "$BAM_FILE"
    rm "$SAM_FILE"
    samtools sort -o "$SORTED_BAM_FILE" "$BAM_FILE"
    samtools index "$SORTED_BAM_FILE"
    rm "$BAM_FILE"
done

