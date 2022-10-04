# MitoH3

## Introduction:

MitoH3 is a pipeline that calls MT variants from sequence file (cram file). In addition to the regular MT reference sequence file, the pipeline also applied a shifted MT reference file to get calls at D-loop region more precisely. There are two main steps of the pipeline: #1 Generate raw vcf file from cram file. #2 Call haplogroup from cleaned vcf file; Split raw vcf file into homoplasmic call vcf and heteroplasmic call vcf.


## prepare files:

### build singularity image using definition file:
singularity build --remote MitoH3.sif MitoH3.def

### download reference file and prepare json file:
original file:

https://console.cloud.google.com/storage/browser/genomics-public-data/references/hg38/v0/chrM;tab=objects?prefix=&forceOnObjectsSortingFiltering=false

or download from dropbox

wget https://www.dropbox.com/s/1vfqwo84b70wva9/MT_WDL_ref.zip



### 1KG project cram file example:
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR398/ERR3988882/HG01433.final.cram.crai




## run step1:

export SINGULARITY_BINDPATH="/your/local/path"

singularity exec MitoH3.sif bash /script/run.sh input.json

##### final output vcf file:
cromwell-executions/MitochondriaPipeline/*/call-SplitMultiAllelicSites/execution/subject1.final.split.vcf



## run step2:

export SINGULARITY_BINDPATH="/your/local/path"

singularity exec MitoH3.sif  bash   part2_rule_5_95_convert.sh   subject1.final.split.vcf  prefix

##### output files:
prefix.haplocheck.output  
prefix.pass.het.vcf.gz.tbi  
prefix.pass.homo.vcf.gz.tbi
prefix.pass.het.vcf.gz    
prefix.pass.homo.vcf.gz     
prefix.pass.vcf.gz



## reference pipeline:

https://github.com/broadinstitute/gatk/tree/master/scripts/mitochondria_m2_wdl


