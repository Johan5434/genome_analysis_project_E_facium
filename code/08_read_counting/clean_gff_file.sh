#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J clean_gff
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH --output=/home/joel5434/genomanalys_project/code/09_read_counting/clean_gff.%j.out
#SBATCH --error=/home/joel5434/genomanalys_project/code/09_read_counting/clean_gff.%j.err

module load bioinfo-tools

GFF="/home/joel5434/genomanalys_project/code/09_read_counting/efaecium_pacbio.gff"
CLEANED_GFF="/home/joel5434/genomanalys_project/code/09_read_counting/efaecium_pacbio_cleaned.gff"

grep -P '^\s*#|^\S+\t\S+\t\S+\t\d+\t\d+\t\S+\t[+-.]\t\S+\t\S+' "$GFF" > "$CLEANED_GFF"

