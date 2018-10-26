#!/usr/bin/bash

#NOTE: script requires samtools/0.1.19

#change working directory
cd ~/dc_workshop/results

#specify location of reference genome
genome=~/dc_workshop/data/ref_genome/ecoli_rel606.fasta

#index the reference genome
bwa index $genome

#create directory to store the results
mkdir -p sai sam bam bcf vcf

#loop through each .fastq file to do variant calling
for fq in ~/dc_workshop/data/trimmed_fastq_small/*.fastq
    do
    echo "working with file $fq"
    #extract the base name of the file
    base=$(basename $fq .fastq_trim.fastq)
    echo "base name is $base"

    #create variables to store the name each of each output file using the base name of the file extracted above
    fq=~/dc_workshop/data/trimmed_fastq_small/$base.fastq_trim.fastq
    sai=~/dc_workshop/results/sai/${base}_aligned.sai
    sam=~/dc_workshop/results/sam/${base}_aligned.sam
    bam=~/dc_workshop/results/bam/${base}_aligned.bam
    sorted_bam=~/dc_workshop/results/bam/${base}_aligned_sorted.bam
    raw_bcf=~/dc_workshop/results/bcf/${base}_raw.bcf
    variants=~/dc_workshop/results/bcf/${base}_variants.bcf
    final_variants=~/dc_workshop/results/vcf/${base}_final_variants.vcf

    #align reads to the reference genome and output .sai file
    bwa aln $genome $fq > $sai
    #convert .sai file to a .sam file
    bwa samse $genome $sai $fq > $sam
    #convert .sam file to a .bam file
    samtools view -S -b $sam > $bam
    #sort the .bam file
    samtools sort -f $bam $sorted_bam
    #index the .bam file
    samtools index $sorted_bam
    #count the read coverage
    samtools mpileup -g -f $genome $sorted_bam > $raw_bcf
    #call the variants with bcftools (use -c not -m)
    bcftools call -bvcg $raw_bcf > $variants
    #filter the final output
    bcftools view $variants | /usr/share/samtools/vcfutils.pl varFilter - > $final_variants
    done
