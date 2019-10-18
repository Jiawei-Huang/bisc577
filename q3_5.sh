#!/bin/bash

# Find all SNV positions  #Give vcf file name as input
f=$1
grep -v "^#" $f |\
awk -F '\t' 'BEGIN{printf("create table T(c text,p int); BEGIN TRANSACTION;\n");} {printf("insert into T(c,p) values(\"%s\",%d);\n",$1,$2);} END {printf("COMMIT; SELECT c,CAST(p/2E4  AS INT)*2E4, count(*) from T group by c,CAST(p/2E4  AS INT)*1E7 ; drop table T;");}' |\
sqlite3 -separator ' ' tmp.sqlite > ${f}.density.txt && rm tmp.sqlite

#plot using plot.py #could be done in snakemake directly
python plot.py SRR5762776.freebayes.vcf.density.txt
