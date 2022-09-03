# MitoH3

reference pipeline:

https://github.com/broadinstitute/gatk/tree/master/scripts/mitochondria_m2_wdl



singularity image:

singularity pull --arch amd64 library://marchonion/remote-builds/rb-631395b1fe5ae46902d4cc55:latest

wget https://www.dropbox.com/s/1rj8wejc5mpfjuc/MitoH3.sif



reference file:

https://console.cloud.google.com/storage/browser/genomics-public-data/references/hg38/v0/chrM;tab=objects?prefix=&forceOnObjectsSortingFiltering=false

wget https://www.dropbox.com/s/1vfqwo84b70wva9/MT_WDL_ref.zip




cram file example:

wget https://www.dropbox.com/s/7ox0bwddmbiash0/subject1.cram

wget https://www.dropbox.com/s/s6t0videh3wddnw/subject1.cram.crai




cmd:

image=MitoH3.sif

json=input.json

export SINGULARITY_BINDPATH="/your/local/path"

singularity exec $image bash /script/run $json
