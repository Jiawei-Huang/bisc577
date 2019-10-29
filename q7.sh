#!/bin/bash

f=$1

echo in $f : >> Answer_7.txt
awk '{if ($2 >  2000) a++};END{print "contigs greater than 2kbp : " a}' ${f}_31.contigs.fa.fai >> Answer_7.txt

