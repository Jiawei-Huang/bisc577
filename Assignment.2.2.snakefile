import os
SD = os.path.dirname(workflow.snakefile)
shell.prefix(". {SD}/config.sh; ")

all_sra=["SRR5762776", "SRR6765736"]
methods= ["freebayes"]
rule all:
    input:
        bam=expand("{sra}.bam", sra=all_sra),
        bamIndex=expand("{sra}.bam.bai", sra=all_sra),
        varFiles=expand("{sra}.{method}.vcf", sra=all_sra, method=methods)

rule MapReads:
    input:
        reads=["{sra}_1.fastq", "{sra}_2.fastq"]
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



