#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J PROKKA_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o prokka_%j.log

module load bioinfo-tools

eval "$(conda shell.bash hook)"
conda activate prokka-env

chmod u+r /home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta

prokka \
  --outdir /home/joel5434/genomanalys_project/analyses/05_annotation \
  --prefix efaecium_pacbio \
  --genus Enterococcus \
  --species faecium \
  --kingdom Bacteria \
  --usegenus \
  --force \
  /home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta

