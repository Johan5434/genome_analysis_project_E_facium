import csv

input_file = "filereport_read_run_PRJEB19025_csv.txt"

with open(input_file, newline="") as csvfile:
    reader = csv.reader(csvfile)
    header = next(reader)
    
    with open("metadata_Tnseq_BHI.csv", "w", newline="") as tn_bhi, \
         open("metadata_Tnseq_Serum.csv", "w", newline="") as tn_serum, \
         open("metadata_RNAseq_tRNA.csv", "w", newline="") as rna_trna, \
         open("metadata_RNAseq_other.csv", "w", newline="") as rna_other, \
         open("metadata_unclassified.csv", "w", newline="") as unclassified:
         
         writer_tn_bhi = csv.writer(tn_bhi)
         writer_tn_serum = csv.writer(tn_serum)
         writer_rna_trna = csv.writer(rna_trna)
         writer_rna_other = csv.writer(rna_other)
         writer_unclassified = csv.writer(unclassified)
         writer_tn_bhi.writerow(header)
         writer_tn_serum.writerow(header)
         writer_rna_trna.writerow(header)
         writer_rna_other.writerow(header)
         writer_unclassified.writerow(header)
         
         for row in reader:
             submitted_ftp = row[7]
             fastq_ftp = row[6]
             if "Tn-Seq" in submitted_ftp:
                 if "BHI" in submitted_ftp:
                     writer_tn_bhi.writerow(row)
                 elif "Serum" in submitted_ftp:
                     writer_tn_serum.writerow(row)
                 else:
                     writer_unclassified.writerow(row)
             else:
                 if "tRNA" in fastq_ftp or "tRNA" in submitted_ftp:
                     writer_rna_trna.writerow(row)
                 else:
                     writer_rna_other.writerow(row)
