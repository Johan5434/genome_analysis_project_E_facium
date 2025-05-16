#!/bin/bash -l 

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy 
#SBATCH -p core 
#SBATCH -n 4 
#SBATCH -t 06:00:00
#SBATCH -J job_name
#SBATCH --mail-type=ALL 
#SBATCH --mail-user eliassonjohan1@gmail.com 
#SBATCH --output=canu_%j.out
#SBATCH --error=canu_%j.err

PREFIX="e_faecium"
OUTPUT_DIR="/home/joel5434/genomanalys_project/analyses/02_genome_assembly"
GENOME_SIZE="3.0m"
READS="/home/joel5434/genomanalys_project/data/raw_data/genomics_data/PacBio/*.fastq.gz" 

module load bioinfo-tools 
module load canu 

canu -p $PREFIX -d $OUTPUT_DIR genomeSize=$GENOME_SIZE -pacbio-raw $READS useGrid=false
