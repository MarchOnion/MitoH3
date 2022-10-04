#!/bin/bash



/bcftools-1.16/bcftools merge \
  --missing-to-ref \
  --filter-logic + \
  --merge none \
  --file-list het_16930.vcf.list \
  --output    P1_MT17K.mutect2.HETat5-95percent.vcf.gz \
  --output-type z \
