#!/bin/bash

/bcftools-1.16/bcftools merge \
  --missing-to-ref \
  --filter-logic + \
  --merge none \
  --file-list vcf.list.txt \
  --output    merged.vcf.gz \
  --output-type z \
