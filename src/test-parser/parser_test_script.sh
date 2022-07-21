# script for testing SRC pipeline parser

snv_algorithm='Mutect2'
cna_algorithm='HATCHet'
src_algorithm='PhyloWGS' # PyClone-VI, DPClust
snv_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.vcf
cna_files=/hot/software/package/tool-SRC-util/Python/development/test_inputs/converted.seg.ucn.tsv
python3 -m src_util format_src_input \
    --snv-file ${snv_files} \
    --cna-file ${cna_files} \
    --snv-type ${snv_algorithm} \
    --cna-type ${cna_algorithm} \
    --src-tool ${src_algorithm} \
    --output-dir /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/test-a/pipeline-input/PhyloWGS #PyClone-Vi, DPClust
