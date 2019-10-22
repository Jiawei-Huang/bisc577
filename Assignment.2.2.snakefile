import os
SD = os.path.dirname(workflow.snakefile)
shell.prefix(". {SD}/config.sh; ")

all_sra=["SRR5762776", "SRR6765736"]
methods= ["freebayes"]
kmers=[31,22]
rule all:
    input:
        bam=expand("{sra}.bam", sra=all_sra),
        bamIndex=expand("{sra}.bam.bai", sra=all_sra),
        varFiles=expand("{sra}.{method}.vcf", sra=all_sra, method=methods),
        contigs=expand("{sra}_{kmer}.contigs.fa", sra=all_sra, kmer=kmers),
        indexs=expand("{sra}_{kmer}.contigs.fa.fai", sra=all_sra, kmer=kmers),
        structuralVar=expand("{sra}.wham.vcf", sra=all_sra)
        
rule MapReads:
    input:
        
    output:
        aln="{sra}.bam",
        index="{sra}.bam.bai"
    shell:"""
bwa mem /home/cmb-16/mjc/bisc577a/DrosophilaData/Genome/dm6.fa -R "@RG\\tID:dm6_italy\\tLB:reads\\tPL:illumina\\tSM:dm6_test\\tPU:reads1" -t 8 {input.reads[0]}  {input.reads[1]} |  \
  samtools view -uS - | \
  samtools sort -T $TMPDIR/tmp -@ 2 - > {output.aln}
  samtools index {output.aln}
"""

rule CallVariantsFreebayes:
    input:
        aln="{sra}.bam",
        index="{sra}.bam.bai",
        fasta="dm6.fa" 
    output:
        var="{sra}.freebayes.vcf"
    shell:"""
/home/cmb-16/mjc/shared/bin/freebayes -f {input.fasta} {input.aln} > {output.var}
"""

rule CallStructuralVariant:
    input:
        aln="{sra}.bam"
    output:
        wham="{sra}.wham.vcf"
    shell:"""
    /home/cmb-16/mjc/shared/software_packages/wham/bin/whamg -f {input.aln} -a /home/cmb-16/mjc/bisc577a/DrosophilaData/Genome/dm6.fa > {output.wham}
"""

rule CallMinia:
    input:
        reads=["{sra}_1.fastq", "{sra}_2.fastq"]
    output:
        contig="{sra}_{kmer}.contigs.fa",
        index="{sra}_{kmer}.contigs.fa.fai"
    shell:"""
echo "{input.reads[0]}\n{input.reads[1]}" > {wildcards.sra}.txt; 
/home/cmb-16/mjc/shared/bin/minia -in {wildcards.sra}.txt -kmer-size {wildcards.kmer} -out {wildcards.sra}_{wildcards.kmer};
samtools faidx {output.contig}
"""

        




