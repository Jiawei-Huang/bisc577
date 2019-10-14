import os
SD = os.path.dirname(workflow.snakefile)
shell.prefix(". {SD}/config.sh; ")

all_sra=["SRR5762776"]
methods= ["freebayes"]
rule all:
    input:
        bam="SRR5762776.bam",
        bamIndex="SRR5762776.bam.bai",
        varFiles=expand("SRR5762776.{method}.vcf", method=methods)

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
        index="{sra}.bam.bai"
    output:
        var="{sra}.freebayes.vcf"
    shell:"""
touch {output.var}
"""



