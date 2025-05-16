#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J BAM_SORT
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o bam_sort_%j.log

module load bioinfo-tools
module load samtools/1.20


BAM_FILE="$1"
if [ -z "$1" ]; then
    echo "Error: No BAM file provided."
    echo "Usage: sbatch bam_to_sorted_bam.sh <BAM_FILE>"
    exit 1
fi

SORTED_BAM_FILE="${BAM_FILE%.bam}_sorted.bam"

samtools sort -o "$SORTED_BAM_FILE" "$BAM_FILE"
samtools index "$SORTED_BAM_FILE"

