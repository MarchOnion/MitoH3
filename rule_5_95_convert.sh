#!/bin/bash

infile=$1
tag=$2


#tag=A-CUHS-CU001163-BL-COL-32131BL1fr


#1 select all qualified variants (PASS & mt_many_low_hets <=3)
grep ^#    ${infile}               > ${tag}.pass.vcf
grep -v ^# ${infile} | grep PASS  >> ${tag}.pass.vcf
n=`grep -P "\tmt_many_low_hets\t" ${infile} | wc -l`
if [ $n -le 3  ]
  then
  grep -P "\tmt_many_low_hets\t"  ${infile} >> ${tag}.pass.vcf
fi

bcftools sort -o ${tag}.pass.vcf.gz -O z ${tag}.pass.vcf
rm ${tag}.pass.vcf



#2 select het and convert GT to 1
bcftools filter -i 'FORMAT/AF >= 0.05 ' ${tag}.pass.vcf.gz | bcftools filter -i 'FORMAT/AF <= 0.95 '      > ${tag}.pass.het.tmp.vcf
grep "#"                           ${tag}.pass.het.tmp.vcf                                                > ${tag}.pass.het.vcf
grep -v "#"                        ${tag}.pass.het.tmp.vcf  | cut -f1-8 | awk '{print $0"\tGT:AD:AF"}'    > ${tag}.pass.het.vcf.part2
bcftools query -f '[1:%AD:%AF]\n'  ${tag}.pass.het.tmp.vcf                                                > ${tag}.pass.het.vcf.part3

paste ${tag}.pass.het.vcf.part2  ${tag}.pass.het.vcf.part3   >> ${tag}.pass.het.vcf
bgzip -c ${tag}.pass.het.vcf > ${tag}.pass.het.vcf.gz
tabix -p vcf ${tag}.pass.het.vcf.gz
rm ${tag}.pass.het.tmp.vcf ${tag}.pass.het.vcf ${tag}.pass.het.vcf.part2 ${tag}.pass.het.vcf.part3



#3 select homo
bcftools filter -i 'FORMAT/AF > 0.95 ' ${tag}.pass.vcf.gz                                                  > ${tag}.pass.homo.tmp.vcf
grep "#"                           ${tag}.pass.homo.tmp.vcf                                                > ${tag}.pass.homo.vcf
grep -v "#"                        ${tag}.pass.homo.tmp.vcf  | cut -f1-8 | awk '{print $0"\tGT:AD:AF"}'    > ${tag}.pass.homo.vcf.part2
bcftools query -f '[1:%AD:%AF]\n'  ${tag}.pass.homo.tmp.vcf                                                > ${tag}.pass.homo.vcf.part3
paste ${tag}.pass.homo.vcf.part2  ${tag}.pass.homo.vcf.part3   >> ${tag}.pass.homo.vcf
bgzip -c ${tag}.pass.homo.vcf > ${tag}.pass.homo.vcf.gz
tabix -p vcf ${tag}.pass.homo.vcf.gz
rm ${tag}.pass.homo.tmp.vcf ${tag}.pass.homo.vcf ${tag}.pass.homo.vcf.part2 ${tag}.pass.homo.vcf.part3



#check contamination
mkdir $tag
cp ${tag}.pass.vcf.gz $tag
java -jar haplocheckCLI.jar $tag
mv output ${tag}_haplocheck_output
rm -r $tag
rm output_json output_summary



