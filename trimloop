#!/use/bin/bash

#trimloop.sh

for infile in *.fastq.gz
do
outfile="${infile}"_trim.fastq.gz
java -jar ~/Trimmomatic-0.36/trimmomatic-0.36.jar SE "${infile}" "${outfile}" SLIDINGWINDOW:4:20 MINLEN:20
done
