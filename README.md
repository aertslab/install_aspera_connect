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


Make sure that TCP and UDP port 33001 are open and accessible from the internet on the machine
from which you run Aspera Connect, else you will see an error like this:

```
Session Stop  (Error: Client unable to connect to server (check UDP port and firewall))
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
    dbtest@sra-download.ncbi.nlm.nih.gov:data/sracloud/traces/sra46/SRR/005227/SRR5353377 \
    SRR5353377.sra

# Convert SRA file to gzipped FASTQ files with fastq-dump (SRA toolkit).
fastq-dump --gzip --split-files SRR5353377.sra

# Convert SRA file to FASTQ with fasterq-dump (SRA toolkit) and compress FASTQ files with gzip.
fasterq-dump --split-files SRR5353377.sra
gzip SRR5353377_1.fastq
gzip SRR5353377_2.fastq
```
[Downloading data from the SRA website](https://www.ncbi.nlm.nih.gov/books/NBK158898/)

Download SRA file with prefetch (of [SRA toolkit](https://ncbi.github.io/sra-tools/install_config.html) which uses ascp (`-t fasp`)

```bash
# Use prefetch (SRA toolkit) to download SRA file:
#   - SRA files will be written to: $HOME/ncbi/public/sra/
#   - If your HOME dir is constrained in space, make a symlink:
#       ln -s /dir_with_lots_of_free_space/ncbi ${HOME}/ncbi
prefetch -v -t fasp SRR5353377

# Convert SRA file to gzipped FASTQ files with fastq-dump (SRA toolkit).
fastq-dump --gzip --split-files SRR5353377

# Convert SRA file to FASTQ with fasterq-dump (SRA toolkit) and compress FASTQ files with gzip.
fasterq-dump --split-files SRR5353377
gzip SRR5353377_1.fastq
gzip SRR5353377_2.fastq
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
