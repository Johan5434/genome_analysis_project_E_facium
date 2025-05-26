<<<<<<< HEAD
# genome_analysis_project_E_facium
This is the second version of my original repository. Had to do a complete reset. 
=======
# genomanalys_project

This project follows the pipeline used to study how Enterococcus faecium adapts to human serum. The analysis starts from raw sequencing data and ends with differential gene expression. All steps were run either on UPPMAX or locally, depending on the software and runtime.

The data included reads from PacBio, Nanopore and Illumina. Quality check was done with FastQC on Illumina reads. For genome assembly, PacBio reads were assembled using Canu, and Illumina+Nanopore were combined in a hybrid SPAdes assembly. QUAST was then used to evaluate both assemblies. Based on fewer contigs and better GC content, the PacBio assembly was chosen for downstream analysis.

Annotation was done with Prokka using species-specific flags. The result was a GFF file with over 3000 predicted coding genes. This assembly was also compared to a referense genome using MUMmer, which showed strong alignment but some reversed matches, probably due to assembly start positions.

For the RNA part, reads from both BH and Serum conditions were checked and trimmed with Trimmomatic, but the trimmed versions were not used since too much data was lost. Mapping was done with BWA to the PacBio assembly, and SAMtools was used for sorting and indexing. Read counting was performed with HTSeq after cleaning the annotation file so that it matched GTF format.

Finally, differential expression analysis was done in R using DESeq2. Several purine biosynthesis genes (like purH, purL and purC) were upregulated in Serum, wich matches findings from Zhang et al. (2017). PCA and heatmaps clearly showed seperation between the two conditions.
>>>>>>> b355980 (restarting the git completely)
