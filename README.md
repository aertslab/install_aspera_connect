# Install latest version of Aspera Connect (linux 64-bit).

## Installation

```bash
# Clone this repository.
git clone https://github.com/aertslab/install_aspera_connect

cd install_aspera_connect

# Install latest version of Aspera Connect (linux 64-bit).
./install_aspera_connect.sh
```

Aspera Connect is now available:
```
~/.aspera/connect/bin/ascp
```


## Aspera Connect documentation

[Aspera Connect documentation](https://downloads.asperasoft.com/en/documentation/8)


## Download sequencing data

### Sequence Read Archive (SRA) / Gene Expression Omnibus (GEO) 

```bash
# Download SRA file directly with ascp:
~/.aspera/connect/bin/ascp \
    -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
    -pQTk1 \
    -l 1000m \
    dbtest@sra-download.ncbi.nlm.nih.gov:data/sracloud/traces/sra2/SRR/000297/SRR304976 \
    SRR304976.sra

# Convert SRA file to FASTQ with fastq-dump (SRA toolkit).
fastq-dump SRR304976.sra

# Convert SRA file to FASTQ with fasterq-dump (SRA toolkit).
fasterq-dump SRR304976.sra
```
[https://www.ncbi.nlm.nih.gov/books/NBK158899/](https://www.ncbi.nlm.nih.gov/books/NBK158899/)


Download SRA file with prefetch (of [SRA toolkit](https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/) which uses ascp (`-t fasp`)

```bash
# Use prefetch to download SRA file. 
prefetch -v -t fasp SRR304976

# Convert SRA file to FASTQ with fastq-dump.
fastq-dump SRR304976

# Convert SRA file to FASTQ with fasterq-dump.
fasterq-dump SRR304976
```


### 1000 genomes project

```bash
~/.aspera/connect/bin/ascp \
    -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
    -Tr \
    -Q \
    -l 100M \
    -P33001 \
    -L- \
    fasp-g1k@fasp.1000genomes.ebi.ac.uk:vol1/ftp/release/20100804/ALL.2of4intersection.20100804.genotypes.vcf.gz ./
```

[http://www.internationalgenome.org/faq/how-download-files-using-aspera/)](http://www.internationalgenome.org/faq/how-download-files-using-aspera/)


### European Nucleotide Archive (ENA)

```bash
ascp -QT -l 300m -P33001 -i /etc/aperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/ERA012/ERA012008/sff/library08_GJ6U61T06.sff .
~/.aspera/connect/bin/ascp \
    -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
    -QT \
    -l 300m \
    -P33001 \
    fasp-g1k@fasp.1000genomes.ebi.ac.uk:vol1/ftp/release/20100804/ALL.2of4intersection.20100804.genotypes.vcf.gz ./
```

[https://www.ebi.ac.uk/ena/browse/read-download#downloading_files_aspera](https://www.ebi.ac.uk/ena/browse/read-download#downloading_files_aspera)
