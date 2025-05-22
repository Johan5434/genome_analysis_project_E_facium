#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 3
#SBATCH -t 04:00:00
#SBATCH -J RNA_FastQC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o /home/joel5434/genomanalys_project/analyses/07_rna_trimming/rna_fastqc_%j.log

module load bioinfo-tools FastQC

RAW_FILES_BH=/home/joel5434/genomanalys_project/data/raw_data/transcriptomics_data/RNA-Seq_BH/*.gz
RAW_FILES_SERUM=/home/joel5434/genomanalys_project/data/raw_data/transcriptomics_data/RNA-Seq_Serum/*.gz

OUT_DIR=/home/joel5434/genomanalys_project/analyses/07_rna_trimming
mkdir -p $OUT_DIR/fastqc_check_BH_before
mkdir -p $OUT_DIR/fastqc_check_serum_before

fastqc -t $SLURM_NTASKS $RAW_FILES_BH \
       -o $OUT_DIR/fastqc_check_BH_before

fastqc -t $SLURM_NTASKS $RAW_FILES_SERUM \
       -o $OUT_DIR/fastqc_check_serum_before

