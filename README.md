# MitoH3

## Introduction:

MitoH3 is a pipeline that calls MT variants from sequence file (cram file). In addition to the regular MT reference sequence file, the pipeline also applied a shifted MT reference file to get calls at D-loop region more precisely. There are two main steps of the pipeline: #1 Generate raw vcf file from cram file. #2 Call haplogroup from cleaned vcf file; Split raw vcf file into homoplasmic call vcf and heteroplasmic call vcf.


## prepare files:

### build singularity image using definition file:

How to sign in: https://docs.sylabs.io/guides/latest/user-guide/signNverify.html#

wget https://raw.githubusercontent.com/MarchOnion/MitoH3/main/MitoH3.def

singularity build --remote MitoH3.sif MitoH3.def

### download reference file and prepare json file:

wget https://www.dropbox.com/s/4u1mz7h7ws1z89k/MT_WDL_ref.zip

unzip MT_WDL_ref.zip

original file: https://console.cloud.google.com/storage/browser/genomics-public-data/references/hg38/v0/chrM;tab=objects?prefix=&forceOnObjectsSortingFiltering=false



### 1KG project cram file example:
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram.crai


### prepare json file:
wget https://raw.githubusercontent.com/MarchOnion/MitoH3/main/input.json

dir=`pwd`

sed -i "s|your_local_path|${dir}|g" input.json 



## run step1:
```bash
singularity exec --bind "$dir" MitoH3.sif bash /script/run1.sh input.json
```


## run step2:
```bash
step1_output=cromwell-executions/MitochondriaPipeline/*/call-SplitMultiAllelicSites/execution/*.final.split.vcf

singularity exec --bind "$dir" MitoH3.sif  bash /script/run2.sh   $step1_output    prefix  0.05 0.95
```


[reference pipeline](https://github.com/broadinstitute/gatk/tree/master/scripts/mitochondria_m2_wdl)


