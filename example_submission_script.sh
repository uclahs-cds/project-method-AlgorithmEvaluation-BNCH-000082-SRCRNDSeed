#! /bin/bash

python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
	--nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
	--nextflow_config /hot/software/pipeline/pipeline-call-SRC/Nextflow/development/unreleased/yashpatel-add-dpclust/multisample/SARC0028.config \
	--nextflow_yaml /hot/software/pipeline/pipeline-call-SRC/Nextflow/development/test_inputs/yaml/SARC0028_F_I.yaml \
	--pipeline_run_name SARC0028_SRC_multisample \
	--partition_type F32 \
	--email yashpatel@mednet.ucla.edu
