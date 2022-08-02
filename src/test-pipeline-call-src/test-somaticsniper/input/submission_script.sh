# submission script for test of pipeline-call-SRC

python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
    --nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
    --nextflow_config /hot/user/aneimangolden/git/project-SRC-RandomSeed/src/test-pipeline-call-src/test-somaticsniper/config/somaticsniper_pipeline_test.config \
    --nextflow_yaml /hot/user/aneimangolden/git/project-SRC-RandomSeed/src/test-pipeline-call-src/test-somaticsniper/input/somaticsniper_pipeline_test.yaml \
    --pipeline_run_name SomaticSniper_test \
    --partition_type F16 \
    --email ANeimanGolden@mednet.ucla.edu
