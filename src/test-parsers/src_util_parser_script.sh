# testing src_util_parser script
snv_algorithm='Mutect2' #Strelka2, #Mutect2
cna_algorithm='HATCHet'
src_algorithm='PyClone-VI' #'DPClust', 'PyClone-VI', 'PhyloWGS'

# mutect2-MS w one sample
# snv_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.vcf
# mutect2-MS-mao
# snv_files=/hot/software/pipeline/pipeline-call-sSNV/Nextflow/development/4.0.0-rc.1/maotian-add-germline-resource/output/call-sSNV-3.0.0/451/mutect2-4.2.4.1/output/mutect2_451_filtered_pass.vcf.gz
# strelka2
# snv_files=/hot/users/yiyangliu/ILHNLNEV/SNV/strelka2/recsnv/vcfs/ILHNLNEV000001-N002-A01-F.vcf
# cna_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.seg.ucn.tsv
#snv_files=/hot/software/pipeline/pipeline-call-SRC/Nextflow/development/test_inputs/data/SARC0028_F_I.vcf.gz
# mutect2


# MS - yash
# snv_files=/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/SARC0028_F_I.vcf.gz
cna_files=/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/SARC0028_F_I.tetraploid.seg.ucn
python3 -m src_util format_src_input \
       --snv-file /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/test_F.vcf.gz \
       --snv-file /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/test_I.vcf.gz \
       --cna-file ${cna_files} \
       --snv-type ${snv_algorithm} \
       --cna-type ${cna_algorithm} \
       --src-tool ${src_algorithm} \
       --output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/output/ss/PyClone-VI
       # --output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-p/input/PyClone-Vi
       #--output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-p/input/DPClust
       # --snv-file /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/test_F.vcf.gz \
       # --snv-file /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-parsers/mutect2/input/test_I.vcf.gz \
       # --snv-file ${snv_files} \
       