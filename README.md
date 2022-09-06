# MitoH3

## reference pipeline:

https://github.com/broadinstitute/gatk/tree/master/scripts/mitochondria_m2_wdl


## prepare files:

### singularity definition file and image:
wget https://www.dropbox.com/s/ufiykz549wyxhfn/MitoH3.def?dl=0

wget https://www.dropbox.com/s/h8bs5o4pfbp52o9/MitoH3.sif?dl=0



### reference file:
original file:

https://console.cloud.google.com/storage/browser/genomics-public-data/references/hg38/v0/chrM;tab=objects?prefix=&forceOnObjectsSortingFiltering=false

or copy from dropbox

wget https://www.dropbox.com/s/1vfqwo84b70wva9/MT_WDL_ref.zip



### cram file example:

wget https://www.dropbox.com/s/7ox0bwddmbiash0/subject1.cram

wget https://www.dropbox.com/s/s6t0videh3wddnw/subject1.cram.crai


### json file:
check above

## run step1:

image=MitoH3.sif

json=input.json

export SINGULARITY_BINDPATH="/your/local/path"

singularity exec $image bash /script/run.sh $json

##### final output vcf file:
cromwell-executions/MitochondriaPipeline/*/call-SplitMultiAllelicSites/execution/subject1.final.split.vcf

## run step2:

image=MitoH3.sif

export SINGULARITY_BINDPATH="/your/local/path"

singularity exec $image  bash   part2_rule_5_95_convert.sh   subject1.final.split.vcf  prefix

##### output files:
prefix.haplocheck.output  
prefix.pass.het.vcf.gz.tbi  
prefix.pass.homo.vcf.gz.tbi
prefix.pass.het.vcf.gz    
prefix.pass.homo.vcf.gz     
prefix.pass.vcf.gz
