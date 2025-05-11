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


INPUT_DIR="$1"
OUTPUT_DIR="$2"
CATEGORY="$3"

if [ $# -ne 3 ]; then
  echo "Usage: sbatch $0 <input_dir> <output_root_dir> <category>"
  exit 1
fi

CATEGORY_DIR="$OUTPUT_DIR/$CATEGORY"
mkdir -p "$CATEGORY_DIR"

for fq in "$INPUT_DIR"/*.fastq.gz; do
basename=$(basename "$fq" | cut -d'_' -f1)
sample_dir="$CATEGORY_DIR/$basename"
mkdir -p "$sample_dir"

fastqc -t 2 "$fq" -o "$sample_dir" 
done 
