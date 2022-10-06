## Introduction:

MitoH3 is a pipeline that calls MT variants from sequence file (cram file). In addition to the regular MT reference sequence file, the pipeline also applied a shifted MT reference file to get calls at D-loop region more precisely.

There are two main steps of the pipeline: 

* 1. Generate raw vcf file from cram file. 

* 2. Call haplogroup from cleaned vcf file; Split raw vcf file into homoplasmic variants vcf and heteroplasmic variants vcf at a given alternative allele frequency cutoff.


## 1. Preparation:

* **build singularity image using definition file:**

[How to set up singularity remote build](https://docs.sylabs.io/guides/latest/user-guide/signNverify.html#)
```bash

wget https://raw.githubusercontent.com/MarchOnion/MitoH3/main/MitoH3.def

singularity build --remote MitoH3.sif MitoH3.def
```

* **download reference file and prepare json file:**

[original file link](https://console.cloud.google.com/storage/browser/genomics-public-data/references/hg38/v0/chrM;tab=objects?prefix=&forceOnObjectsSortingFiltering=false)
```bash
wget https://www.dropbox.com/s/4u1mz7h7ws1z89k/MT_WDL_ref.zip

unzip MT_WDL_ref.zip

```

* **1KG project cram file example:**
```bash
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram.crai
```

* **prepare json file:**
```bash
wget https://raw.githubusercontent.com/MarchOnion/MitoH3/main/input.json

dir=`pwd`

sed -i "s|your_local_path|${dir}|g" input.json 
```


## 2. Variants calling 
* **step1:**
```bash
singularity exec --bind "$dir" MitoH3.sif bash /script/run1.sh input.json
```


* **step2:**
```bash
step1_output=cromwell-executions/MitochondriaPipeline/*/call-SplitMultiAllelicSites/execution/*.final.split.vcf

singularity exec --bind "$dir" MitoH3.sif  bash /script/run2.sh   $step1_output    prefix  0.05 0.95
```

### Supplementary 

* example script for merge vcf files is also provided.
```
https://raw.githubusercontent.com/MarchOnion/MitoH3/main/merge_vcf_files.sh
```

* [reference pipeline](https://github.com/broadinstitute/gatk/tree/master/scripts/mitochondria_m2_wdl)


