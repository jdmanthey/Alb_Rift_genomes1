interactive -p nocona

cd references

source activate bcftools

bwa-mem2 index FicAlb1.5__GCA_000247815.2.fna

samtools faidx FicAlb1.5__GCA_000247815.2.fna

java -jar picard.jar CreateSequenceDictionary \
R=/home/jmanthey/references/FicAlb1.5__GCA_000247815.2.fna \
O=/home/jmanthey/references/FicAlb1.5__GCA_000247815.2.dict
