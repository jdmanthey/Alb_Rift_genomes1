start interactive session
interactive -p quanah

# move to directory
cd /lustre/scratch/jmanthey/33_albertine/04_filtered_vcf_admixture

# remove Z chromosome files
rm *CM002017.1*

# batis -> make one vcf
grep "#" batis_CM001999.1__c.recode.vcf > batis.vcf
for i in $( ls batis*recode.vcf ); do grep -v "#" $i >> batis.vcf; done

# chamaetylas -> make one vcf
grep "#" chamaetylas_CM001999.1__c.recode.vcf > chamaetylas.vcf
for i in $( ls chamaetylas*recode.vcf ); do grep -v "#" $i >> chamaetylas.vcf; done

# cossypha -> make one vcf
grep "#" cossypha_CM001999.1__c.recode.vcf > cossypha.vcf
for i in $( ls cossypha*recode.vcf ); do grep -v "#" $i >> cossypha.vcf; done

# phylloscopus -> make one vcf
grep "#" phylloscopus_CM001999.1__c.recode.vcf > phylloscopus.vcf
for i in $( ls phylloscopus*recode.vcf ); do grep -v "#" $i >> phylloscopus.vcf; done

# make chromosome map for the vcfs
grep -v "#" batis.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom_map.txt

# run vcftools for each combined vcf
vcftools --vcf batis.vcf  --plink --chrom-map chrom_map.txt --out batis 
vcftools --vcf chamaetylas.vcf  --plink --chrom-map chrom_map.txt --out chamaetylas 
vcftools --vcf cossypha.vcf  --plink --chrom-map chrom_map.txt --out cossypha 
vcftools --vcf phylloscopus.vcf  --plink --chrom-map chrom_map.txt --out phylloscopus 

# convert each with plink
plink --file batis --recode12 --out batis2 --noweb
plink --file chamaetylas --recode12 --out chamaetylas2 --noweb
plink --file cossypha --recode12 --out cossypha2 --noweb
plink --file phylloscopus --recode12 --out phylloscopus2 --noweb

# run admixture for each 
for K in 1 2 3 4 5; do admixture --cv batis2.ped $K  | tee log_batis_${K}.out; done
for K in 1 2 3 4 5; do admixture --cv chamaetylas2.ped $K  | tee log_chamaetylas_${K}.out; done
for K in 1 2 3 4 5; do admixture --cv cossypha2.ped $K  | tee log_cossypha_${K}.out; done
for K in 1 2 3 4 5; do admixture --cv phylloscopus2.ped $K  | tee log_phylloscopus_${K}.out; done

# check cv for each species
grep -h CV log_batis_*.out
grep -h CV log_chamaetylas_*.out
grep -h CV log_cossypha_*.out
grep -h CV log_phylloscopus_*.out





