# Submission script for SRC pipeline

# seeds=("51404" "366306" "423647" "838004" "50135" "628019" "97782" "253505" "659767" "13142")
# patients=(
#     "ILHNLNEV000001-T001-P01-F"
#     "ILHNLNEV000002-T001-P01-F"
#     "ILHNLNEV000003-T001-P01-F"
#     "ILHNLNEV000004-T001-P01-F"
#     "ILHNLNEV000005-T001-P01-F"
#     "ILHNLNEV000006-T001-P01-F"
#     "ILHNLNEV000007-T001-P01-F"
#     "ILHNLNEV000008-T001-P01-F"
#     "ILHNLNEV000009-T001-P01-F"
#     "ILHNLNEV000010-T001-P01-F"
#     "ILHNLNEV000011-T001-P01-F"
#     "ILHNLNEV000012-T001-P01-F"
#     "ILHNLNEV000013-T001-P01-F"
#     "ILHNLNEV000014-T001-P01-F"
#     )

# test seeds
seeds=("51404" "253505" "366306" "423647" "628019")
# test patients
patients=("ILHNLNEV000001-T001-P01-F" "ILHNLNEV000002-T001-P01-F")

for seed in ${seeds[@]} 
do
    for patient in ${patients[@]} 
    do
        python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
            --nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
            --nextflow_config /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-strelka2-battenberg-pyclone-vi/input/config/seed_${seed}.config \
            --nextflow_yaml /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-strelka2-battenberg-pyclone-vi/input/yaml/${patient}.yaml \
            --pipeline_run_name ${seed}_${patient}_str-bat-pyc \
            --partition_type F16 \
            --email psteinberg@mednet.ucla.edu
    done
done