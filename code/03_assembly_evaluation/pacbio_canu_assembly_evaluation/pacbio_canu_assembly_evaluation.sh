#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J QUAST_assembly_evaluation
#SBATCH --mail-type=ALL
#SBATCH --mail-user eliassonjohan1@gmail.com
#SBATCH -o quast_%j.log

module load bioinfo-tools
module load python/3.9.5

quastpath="/home/joel5434/genomanalys_project/softwares/quast-5.2.0/quast.py"

mkdir -p /home/joel5434/genomanalys_project/analyses/04_assembly_evaluation/04_assembly_evaluation_pacbio_canu 

output_directory="/home/joel5434/genomanalys_project/analyses/04_assembly_evaluation/04_assembly_evaluation_pacbio_canu" 

target="/home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta"

python "$quastpath" "$target" -o "$output_directory"

