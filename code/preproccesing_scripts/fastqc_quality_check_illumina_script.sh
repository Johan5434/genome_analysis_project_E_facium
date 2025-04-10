#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J quality_control
#SBATCH --mail-type=ALL
#SBATCH --mail-user eliassonjohan1@gmail.com

module load bioinfo-tools FastQC/0.11.9

mkdir -p /home/joel5434/genomanalys_project/analyses/01_preprocessing/fastqc_raw/

fastqc \
 -o /home/joel5434/genomanalys_project/analyses/01_preprocessing/fastqc_raw/ \
  /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz \
  /proj/uppmax2025-3-3/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz \

mv *.html *.zip /home/joel5434/genomanalys_project/analyses/01_preprocessing/fastqc_raw/
