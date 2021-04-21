# start an interactive session and wait to be logged in to a compute node
interactive -c 1 -p quanah

# move to your working directory for this project
cd /lustre/scratch/jmanthey/33_albertine/

# make directories for organization during analyses
mkdir 00_fastq
mkdir 01_cleaned
mkdir 01_bam_files
mkdir 02_vcf
mkdir 03_vcf
mkdir 04_filtered_vcf_admixture
mkdir 05_filtered_vcf_treemix
mkdir 06_filtered_vcf_phylogenies
mkdir 07_filtered_vcf_heterozygosity
mkdir 08_filtered_vcf_msmc2
mkdir 10_align_script
mkdir 12_filter_scripts

# transfer raw data files for this project to the local directory 00_fastq
# make the helper files:
# 1) rename_alb.txt
# 2) alb_popmap.txt
# 3) per-species sample numbers (from rename_alb.txt) for use with vcftools (e.g., keep_batis.txt)

# move to the fastq directory
cd /lustre/scratch/jmanthey/33_albertine/00_fastq/

# rename the files in a numbered fashion
while read -r name1 name2; do
	mv $name1 $name2
done < rename_alb.txt

# move to your main working directory and copy the genome index file there 
cd /lustre/scratch/jmanthey/33_albertine/
cp /home/jmanthey/references/FicAlb1.5__GCA_000247815.2.fna.fai .


