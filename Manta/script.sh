#!/bin/bash
#SBATCH --job-name=SV_calling_sample564-670
#SBATCH --nodelist=bits7

input_file="/home/linyuchieh/mapping/1111_sample_number.csv" 
start_number=564
end_number=670

# read csv line by line, and seperate each line into three parts
sed -n "${start_number},${end_number}p" "$input_file" | while IFS=',' read -r number sample_name file_name
do
  echo "sample $number $sample_name"
  directory_path="/home/linyuchieh/mapping/manta_sample$number"_"$sample_name"
  file_path="slink_TWB_BAM/$file_name"

  # build directory for output
  mkdir -p $directory_path

  # execute configManta.py
  build/manta-1.6.0.centos6_x86_64/bin/configManta.py --bam $file_path --referenceFasta "/home/ruyin/bits_home03/dataset/taiwan_biobank/cm_Taiwan_biobank_test_5/data/genome/hg38_noalt.fa" --runDir $directory_path

  # execute runWorkflow.py
  time $directory_path/runWorkflow.py --quiet

  echo "-----------------------------------------"
done
