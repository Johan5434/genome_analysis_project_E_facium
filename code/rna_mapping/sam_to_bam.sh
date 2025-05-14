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
module load samtools/1.20

if [ "$#" -ne 1 ]; then
    echo "Usage: sbatch bwa_to_bam.sh <SAM_FILE>"
    exit 1
fi

SAM_FILE="$1"
BAM_FILE="${SAM_FILE%.sam}.bam"

samtools view -Sb "$SAM_FILE" > "$BAM_FILE"

