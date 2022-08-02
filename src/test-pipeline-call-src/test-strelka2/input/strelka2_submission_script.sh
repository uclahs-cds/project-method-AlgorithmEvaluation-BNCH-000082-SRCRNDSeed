# Submission script for test running pipeline-call-SRC for strelka

python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
    --nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
    --nextflow_config /hot/user/psteinberg/git/project-SRC-RandomSeed/src/test-pipeline-call-src/test-strelka2/config/ILHNLNEV000001-N002-A01-F-strelka2.config \
    --nextflow_yaml /hot/user/psteinberg/git/project-SRC-RandomSeed/src/test-pipeline-call-src/test-strelka2/input/ILHNLNEV000001-N002-A01-F-strelka2.yaml \
    --pipeline_run_name ILHNLNEV000001-N002-A01-F_strelka2_test \
    --partition_type F16 \
    --email psteinberg@mednet.ucla.edu
