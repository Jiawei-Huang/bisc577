#!/bin/bash

srr=$1

echo starting q3_123..
./q3_123.sh ${srr}.freebayes.vcf

echo starting q3_4..
./q3_4.sh >> Answer_3.txt

echo starting q3_5..
./q3_5.sh ${srr}.freebayes.vcf

./q4.sh ${srr}.wham.vcf

echo starting q8..
for v in {22,31}; do
	./q8.sh ${srr}_${v}.contigs.fa.fai
done

./q7.sh ${srr}

echo check Answer_3.txt, Answer_7.txt, Answer_8.txt and the png files>  Answer_${srr}_3.txt

