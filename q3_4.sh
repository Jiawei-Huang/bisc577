#!/bin/bash

count="$(bedtools intersect -a SRR6765736.freebayes.vcf -b SRR5762776.freebayes.vcf | grep -c TYPE=snp)"
echo  Number of SNVs shared between two species: $count
