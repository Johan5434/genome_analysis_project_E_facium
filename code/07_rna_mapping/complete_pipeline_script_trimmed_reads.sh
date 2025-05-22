#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 04:00:00
#SBATCH -J RNA_MAPPING
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o rna_mapping_%j.log

module load bioinfo-tools
module load bwa
module load samtools/1.20

if [ "$#" -ne 2 ]; then
    echo "Usage: sbatch rna_mapping_pipeline.sh <R1_FASTQ> <R2_FASTQ>"
    exit 1
fi

R1="$1"
R2="$2"

REF="/home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta"

OUT_DIR="/home/joel5434/genomanalys_project/analyses/08_rna_mapping/BH"
mkdir -p "$OUT_DIR"

BASENAME=$(basename "$R1" | cut -d_ -f1)
SAM_FILE="$OUT_DIR/${BASENAME}.sam"
BAM_FILE="$OUT_DIR/${BASENAME}.bam"
SORTED_BAM_FILE="$OUT_DIR/${BASENAME}_sorted.bam"
BAM_INDEX="$OUT_DIR/${BASENAME}_sorted.bam.bai"

bwa mem -t 4 "$REF" "$R1" "$R2" > "$SAM_FILE"

samtools view -Sb "$SAM_FILE" > "$BAM_FILE"
rm "$SAM_FILE"

samtools sort -o "$SORTED_BAM_FILE" "$BAM_FILE"
samtools index "$SORTED_BAM_FILE"
rm "$BAM_FILE"

