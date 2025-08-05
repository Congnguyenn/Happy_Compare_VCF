#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=hap_vcf_compare
#SBATCH --output=cpp-job.%j.out
#SBATCH --error=cpp-job.%j.err
#SBATCH --cpus-per-task=2
#SBATCH --gres localtmp:10k


############################################################################################################
## VARIABLEs DECLARATION
############################################################################################################

env="/home/congnguyen/miniconda3/envs/hap_py"
g4500_bed="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/src/supp_file/g4500/G4500.targets.hg38.bed"

reference="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/resource/bwa_index/hg38_selected.fa"
outdir="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/src/hap_py"
export HGREF=$reference
threads=20
#source activate $env

##HG002
#truth_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/3.Giab_ref/HG002/vcf/HG002_GRCh38_1_22_v4.2.1_benchmark.vcf.gz"
#query_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/2.Parabricks/HG002/MGISEQ2000_PCR-free_NA24385_V100002807_L03/variants/deepvariant/MGISEQ2000_PCR-free_NA24385_V100002807_L03_pbrun_fq2bam_GPU.bam.deepvariant.vcf"
#sampleID="HG002"

# ##HG003
# truth_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/3.Giab_ref/HG003/vcf/HG003_GRCh38_1_22_v4.2.1_benchmark.vcf.gz"
# query_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/2.Parabricks/HG003/MGISEQ2000_PCR-free_NA24149_V100002807_L01/variants/deepvariant/MGISEQ2000_PCR-free_NA24149_V100002807_L01_pbrun_fq2bam_GPU.bam.deepvariant.vcf"
# sampleID="HG003"

#HG004
truth_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/3.Giab_ref/HG004/vcf/HG004_GRCh38_1_22_v4.2.1_benchmark.vcf.gz"
query_vcf="/mnt/NAS_PROJECT/vol_Phucteam/CONGNGUYEN/SERVICE2025/G4500_DRAGEN_PARABRICKS/2.Parabricks/HG004/MGISEQ2000_PCR-free_NA24143_1_V100003043_L03/variants/deepvariant/MGISEQ2000_PCR-free_NA24143_1_V100003043_L03_pbrun_fq2bam_GPU.bam.deepvariant.vcf"
sampleID="HG004"

############################################################################################################
## REFERENCE LINKS
############################################################################################################

#- high_confident_regions: "https://github.com/ga4gh/benchmarking-tools/blob/d88448a68a79ed322837bc8eb4d5a096a710993d/resources/high-confidence-sets/giab.md"
#- genome_stratifications: "https://github.com/genome-in-a-bottle/genome-stratifications"

############################################################################################################
## DOWNLOAD THE HIGH-CONFIDENT REGIONS
############################################################################################################

# ##Download high-confident regions:
# wget https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/SupplementaryFiles/HG002_GRCh38_1_22_v4.2.1_callablemultinter_gt0.bed
# wget https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG004_NA24143_mother/NISTv4.2.1/GRCh38/SupplementaryFiles/HG004_GRCh38_1_22_v4.2.1_callablemultinter_gt0.bed
# wget https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG003_NA24149_father/NISTv4.2.1/GRCh38/SupplementaryFiles/HG003_GRCh38_1_22_v4.2.1_callablemultinter_gt0.bed

############################################################################################################
## DOWNLOAD THE HIGH-CONFIDENT REGIONS
############################################################################################################

out_prefix=$outdir/$sampleID
mkdir -p $out_prefix

hap.py $truth_vcf $query_vcf \
                    --false-positives $outdir/$sampleID"_GRCh38_1_22_v4.2.1_callablemultinter_gt0.bed" \
                    --report-prefix $out_prefix/$sampleID"_Comparison" \
                    --target-regions $g4500_bed \
                    --write-vcf \
                    --output-vtc \
                    --write-counts \
                    --reference $reference \
                    --roc QUAL \
                    --logfile ${out_prefix}.log \
                    --threads $threads \
                    --filter-nonref

##Copy truth VCF to output directory
cp $truth_vcf $out_prefix
cp $query_vcf $out_prefix

##Ungzip all the file in the output directory
cd $out_prefix
for file in *.gz; do
    gunzip $file
done