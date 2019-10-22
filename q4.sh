#!/bin/bash

# Find all SNV positions  #Give vcf file name as input
f=$1
cut -f 8  $f | cut -d ";" -f13  | grep -v "^#" | sed "s/SVLEN=//g" | tail -n+3 >  toplot.txt
python plot_q4.py toplot.txt $f
