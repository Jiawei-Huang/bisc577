#!/bin/bash
f=$1
cat $f | awk -v OFS="\t" '$0 !~ "^#" {hom = 0; het = 0; if(substr($10,1,1)== substr($10,3,1) )  hom++;  else het++; print $1, $2, hom, het}' | cut -f3,4 | awk '{x+=$1; y+=$2} END {print "homo:", x,"hetero:", y, "total:", x+y}'
