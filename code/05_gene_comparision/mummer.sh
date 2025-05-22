#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J comp_genomics
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o /home/joel5434/genomanalys_project/analyses/06_comparative_genomics/comp_genomics_%j.log

module load bioinfo-tools MUMmer

REF=/home/joel5434/genomanalys_project/data/reference_data/GCF_016864255.1_ASM1686425v1_genomic.fna
QUERY=/home/joel5434/genomanalys_project/analyses/02_genome_assembly/PacBio_canu_assembly_result/e_faecium.contigs.fasta

OUT_DIR=/home/joel5434/genomanalys_project/analyses/06_comparative_genomics
mkdir -p $OUT_DIR

THREADS=${SLURM_NTASKS:-1}
PREFIX=${OUT_DIR}/E745_vs_contigs

nucmer --maxmatch \
       --threads $THREADS \
       --prefix $PREFIX \
       $REF $QUERY

delta-filter -1 ${PREFIX}.delta > ${PREFIX}.filtered.delta

mummerplot --png --layout \
           --prefix ${PREFIX}_plot \
           ${PREFIX}.filtered.delta

