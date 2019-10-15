#!/bin/bash
#SBATCH --job-name=snakemake_Q1
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --nodes=1
#SBATCH --nodes=1
#SBATCH --mem=120GB
#SBATCH -p cmb
#SBATCH -t 500:00:00

cd /home/cmb-00/fs3/jiaweih/Assignment2_2/

snakemake --snakefile Assignment.2.2.snakefile