#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J RNA_trimming
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=eliassonjohan1@gmail.com
#SBATCH -o /home/joel5434/genomanalys_project/analyses/07_rna_trimming/trimming_%j.log

module load bioinfo-tools trimmomatic/0.39

# Base directories
RAW_BASE=/home/joel5434/genomanalys_project/data/raw_data/transcriptomics_data
OUT_DIR=/home/joel5434/genomanalys_project/analyses/trimmed_reads_second_try

# Create output directories: one per sample
samples=(ERR1797972 ERR1797973 ERR1797974 ERR1797969 ERR1797970 ERR1797971)

for sample in "${samples[@]}"; do
  # Determine subfolder based on sample ID
  if [[ "$sample" =~ ERR179797[2-4] ]]; then
    SUBDIR=RNA-Seq_BH
  else
    SUBDIR=RNA-Seq_Serum
  fi

  # Create per-sample output folder
  mkdir -p "$OUT_DIR/$sample"

  # Run Trimmomatic paired-end
  trimmomatic PE \
    $RAW_BASE/$SUBDIR/trim_paired_${sample}_pass_1.fastq.gz \
    $RAW_BASE/$SUBDIR/trim_paired_${sample}_pass_2.fastq.gz \
    $OUT_DIR/$sample/${sample}_R1_paired.fastq.gz \
    $OUT_DIR/$sample/${sample}_R1_unpaired.fastq.gz \
    $OUT_DIR/$sample/${sample}_R2_paired.fastq.gz \
    $OUT_DIR/$sample/${sample}_R2_unpaired.fastq.gz \
    ILLUMINACLIP:/sw/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE-2.fa:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:50
done

