#!/bin/bash


fai=$1  #give fai filename as input
sort -k2 --numeric-sort --reverse $fai > sorted.fai
awk '{t+=$2; print t;}' sorted.fai > cummsum.txt
total=$(tail -1 cummsum.txt)
idx=0
#echo $((total / 2))
while read p; do
  idx=$((idx + 1))
  if [ $p -gt $((total / 2)) ]; 
  then
#	echo $idx
	break
  fi
  
done < cummsum.txt

echo  required N50 statistic is $(sed "${idx}q;d" sorted.fai | cut -f2) > Answer_8.txt
rm sorted.fai cummsum.txt
