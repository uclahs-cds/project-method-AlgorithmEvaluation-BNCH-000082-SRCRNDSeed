# testing src_util_parser script
snv_algorithm='Mutect2'
cna_algorithm='HATCHet'
src_algorithm='PhyloWGS' #'DPClust', 'PyClone-Vi', 'PhyloWGS'

# snv_files = /hot/software/package/tool-SRC-util/Python/development/test_inputs/SARC0028/SARC0028.vcf.gz
snv_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.vcf
# cna_files = /hot/software/package/tool-SRC-util/Python/development/test_inputs/SARC0028/SARC0028.tetraploid.seg.ucn
cna_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.seg.ucn.tsv
python3 -m src_util format_src_input \
       --snv-file ${snv_files} \
       --cna-file ${cna_files} \
       --snv-type ${snv_algorithm} \
       --cna-type ${cna_algorithm} \
       --src-tool ${src_algorithm} \
       --output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-p/input/PhyloWGS
       #--output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-p/input/PyClone-Vi
       #--output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-p/input/DPClust
       

