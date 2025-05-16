#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J spades_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user eliassonjohan1@gmail.com

module load bioinfo-tools
module load spades/3.15.3

output_dir="/home/joel5434/genomanalys_project/analyses/02_genome_assembly/Illumina_and_Nanopore_assembly_result"
mkdir -p ${output_dir}

spades.py \
  --pe1-1 /home/joel5434/genomanalys_project/code/genome_assembly_scripts/genome_assembly_illumina/Illumina/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz \
  --pe1-2 /home/joel5434/genomanalys_project/code/genome_assembly_scripts/genome_assembly_illumina/Illumina/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz \
  --nanopore /home/joel5434/genomanalys_project/code/genome_assembly_scripts/genome_assembly_illumina/Nanopore/E745_all.fasta.gz \
  --careful \
  --cov-cutoff auto \
  -k 21,33,55,77,99,127 \
  -o ${output_dir}

