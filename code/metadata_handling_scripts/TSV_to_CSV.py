import pandas as pd 
import csv 


with open("filereport_read_run_PRJEB19025_tsv.txt", newline = "") as tsvfile: 
    reader = csv.reader(tsvfile, delimiter = '\t')
    with open('filereport_read_run_PRJEB19025_csv.txt', 'w') as csvfile:
        writer = csv.writer(csvfile)
        for row in reader:  # lista av strängar 
            writer.writerow(row)




