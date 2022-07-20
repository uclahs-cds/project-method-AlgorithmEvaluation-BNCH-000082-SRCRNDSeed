# Submission script for test running pipeline-call-SRC #3 https://github.com/uclahs-cds/project-SRC-RandomSeed/issues/3

python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
    --nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
    --nextflow_config /hot/user/psteinberg/git/project-SRC-RandomSeed/pipeline-input/config/ILHNLNEV000001-N002-A01-F.config \
    --nextflow_yaml /hot/software/pipeline/pipeline-call-SRC/Nextflow/development/unreleased/yashpatel-add-phylowgs/ILHNLNEV000001-N002-A01-F.yaml \
    --pipeline_run_name ILHNLNEV000001-N002-A01-F \
    --partition_type F16 \
    --email psteinberg@mednet.ucla.edu