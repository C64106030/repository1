# Manta
    1. Installation
    2. Data
    3. Running Manta
    4. Results

## 1. Installation
* Installation guide：
https://github.com/Illumina/manta/blob/master/docs/userGuide/installation.md

## 2. Data
### BAM Files (986 files have been processed by Manta)
* Path: /home/bits_home05/TWB_BAM/
* File list (ID, sample name, file path): sample_number_986.csv

### Reference fasta file
* Path: /home/ruyin/bits_home03/dataset/taiwan_biobank/cm_Taiwan_biobank_test_5/data/genome/hg38_noalt.fa

## 3. Running Manta
### Main Steps
    (1) Configuration
    (2) Workflow Execution
#### (1) configuration (Single Diploid Sample Analysis)
    {MANTA_INSTALL_PATH}/bin/configManta.py --bam input.bam --referenceFasta reference.fa --runDir output_dir
* specify the input data and any options pertaining to the variant calling methods themselves
* create the workflow run script ${MANTA_ANALYSIS_PATH}/runWorkflow.py for (2) workflow execution

#### (2) workflow execution
    {MANTA_ANALYSIS_PATH}/runWorkflow.py
* specify any parameters pertaining to how manta is executed (can be interrupted and resumed)


### example (sample NGS1_20170104C)

    mkdir /home/linyuchieh/mapping/manta_result_NGS1_20170104C

    build/manta-1.6.0.centos6_x86_64/bin/configManta.py --bam /home/bits_home05/TWB_BAM/sorted_NGS1_20170104C_S99_L999.bam --referenceFasta /home/ruyin/bits_home03/dataset/taiwan_biobank/cm_Taiwan_biobank_test_5/data/genome/hg38_noalt.fa --runDir /home/linyuchieh/mapping/manta_sample11_NGS1_20170104C

    /home/linyuchieh/mapping/manta_sample11_NGS1_20170104C/runWorkflow.py --quiet

* --quiet (optional)：Don't write any log output to stderr (but still write to workspace/pyflow.data/logs/pyflow_log.txt)

### script.sh
* A bash script used to run Manta on multiple BAM files.
* Executes the files with IDs from start_number to end_number in the BAM file list.

## 4. Result
* Path: output_dir/results/variants
### diploidSV.vcf.gz (This file is mainly used for analysis)
* SVs and indels **scored** and **genotyped** under a diploid model for the set of samples in a joint diploid sample analysis or for the normal sample in a tumor/normal subtraction analysis.
### candidateSV.vcf.gz
* **Unscored** SV and indel candidates. Only a minimal amount of supporting evidence is required for an SV to be entered as a candidate in this file (includes indels of size 8 and larger). The smallest indels in this set are intended to be passed on to a small variant caller without scoring by manta itself (by default manta scoring starts at size 50).
### candidateSmallIndels.vcf.gz
* Subset of the candidateSV.vcf.gz file containing only **simple insertion and deletion** variants less than the minimum scored variant size (50 by default). Passing this file to a small variant caller will provide continuous coverage over all indel sizes when the small variant caller and manta outputs are evaluated together. Alternate small indel candidate sets can be parsed out of the candidateSV.vcf.gz file if this candidate set is not appropriate.





# Manta 說明
    1. 安裝
    2. 資料
    3. 執行Manta
    4. 結果

## 1. 安裝

* 安裝說明網址：
https://github.com/Illumina/manta/blob/master/docs/userGuide/installation.md


## 2. 資料

### BAM檔案 (已執行過Manta的檔案共986個)
* 路徑：/home/bits_home05/TWB_BAM/

* 檔案列表(編號, 樣本名稱, 檔案路徑)：sample_number_986.csv

### Reference fasta檔案
* 路徑：/home/ruyin/bits_home03/dataset/taiwan_biobank/cm_Taiwan_biobank_test_5/data/genome/hg38_noalt.fa


## 3. 執行Manta
### 主要步驟
    (1) configuration
    (2) workflow execution

#### (1) configuration (Single Diploid Sample Analysis)
    {MANTA_INSTALL_PATH}/bin/configManta.py --bam input.bam --referenceFasta reference.fa --runDir output_dir
* 指定輸入資料與變異偵測方法相關的選項
* 建立工作流程執行腳本 ${MANTA_ANALYSIS_PATH}/runWorkflow.py，供下一步執行使用

#### (2) workflow execution
    {MANTA_ANALYSIS_PATH}/runWorkflow.py
* 指定執行 Manta 時的參數 (可以中斷再繼續執行)


### 範例（樣本 NGS1_20170104C）

    mkdir /home/linyuchieh/mapping/manta_result_NGS1_20170104C

    build/manta-1.6.0.centos6_x86_64/bin/configManta.py --bam /home/bits_home05/TWB_BAM/sorted_NGS1_20170104C_S99_L999.bam --referenceFasta /home/ruyin/bits_home03/dataset/taiwan_biobank/cm_Taiwan_biobank_test_5/data/genome/hg38_noalt.fa --runDir /home/linyuchieh/mapping/manta_sample11_NGS1_20170104C

    /home/linyuchieh/mapping/manta_sample11_NGS1_20170104C/runWorkflow.py --quiet

* --quiet (optional)：執行時不將任何log輸出到stderr (但仍會寫入 workspace/pyflow.data/logs/pyflow_log.txt)

### script.sh
* 用於對多個BAM檔執行Manta的bash script
* 執行BAM file list中編號start_number~end_number的檔案


## 4. 結果
路徑：output_dir/results/variants
### diploidSV.vcf.gz (主要使用這個檔案做分析)
* 以 diploid 模式對樣本組中的結構變異(SV)和插入/缺失變異(indel)進行評分與基因型判定（genotyping）。
* 僅包含長度大於 50 bp 的變異，由 Manta 進行評分。
### candidateSV.vcf.gz
* 紀錄所有尚未評分的 SV 及 indel，變異長度為 8 bp 以上。
* 其中長度小於 50 bp 的變異交由 small variant caller 進行評分。
### candidateSmallIndels.vcf.gz
* 僅包含長度小於 50 bp 的簡單插入與缺失變異（insertion/deletion）。
* 適合作為 small variant caller 的輸入，用於補足 indel 全長範圍的分析。
