# Submission script for SRC pipeline (multi-region mode Mutect2-Battenberg-PyClone-VI)

seeds=("51404" "366306" "423647" "838004" "50135" "628019" "97782" "253505" "659767" "13142")
patients=(
    "ILHNLNEV000001"
    "ILHNLNEV000002"
    "ILHNLNEV000003"
    "ILHNLNEV000006"
    "ILHNLNEV000007"
    "ILHNLNEV000012"
    "ILHNLNEV000014"
   )

for seed in ${seeds[@]} 
do
    for patient in ${patients[@]} 
    do
        # Restrict to submitting no more than 5 jobs to node at a time
        submit_signal="false"
        while [ $submit_signal == "false" ]
        do
            sleep 30
            jobs_running=$(($(squeue -u psteinberg | wc -l) - 1))
            echo "jobs running: $jobs_running"
            if [ $jobs_running -lt 5 ]
            then
                submit_signal="true"
            fi
        done
        python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
            --nextflow_script /hot/user/yashpatel/pipeline-call-SRC/pipeline-call-SRC/main.nf \
            --nextflow_config /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-mutect2-battenberg-pyclone-vi/input/config/seed_"${seed}".config \
            --nextflow_yaml /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/mutect2_battenberg_yamls/multi-region/"${patient}".yaml \
            --pipeline_run_name "${patient}"_"${seed}"_Mutect2-Battenberg-PyClone-VI-mr \
            --partition_type F32 \
            --email psteinberg@mednet.ucla.edu
    done
done
