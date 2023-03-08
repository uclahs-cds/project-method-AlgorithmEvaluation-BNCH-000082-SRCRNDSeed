# Submission script for SRC pipeline (single-region mode Mutect2-Battenberg-PhyloWGS)

# seeds=("51404" "366306" "423647" "838004" "50135" "628019" "97782" "253505" "659767" "13142")
seeds=("423647")
patients=(
    "ILHNLNEV000013-T001-P01-F"
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
            jobs_running=$((`squeue -u psteinberg | wc -l` - 1))
            echo "jobs running: $jobs_running"
            if [ $jobs_running -lt 6 ]
            then
                submit_signal="true"
            fi
        done
        python3 /hot/software/package/tool-submit-nf/Python/release/2.2.0/submit_nextflow_pipeline.py \
            --nextflow_script /hot/software/pipeline/pipeline-call-SRC/Nextflow/release/1.0.0-rc.1/main.nf \
            --nextflow_config /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-mutect2-battenberg-phylowgs/input/config/seed_${seed}.config \
            --nextflow_yaml /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/mutect2_battenberg_yamls/single-region/${patient}.yaml \
            --pipeline_run_name ${patient}_${seed}_Mutect2-Battenberg-PhyloWGS \
            --partition_type F72 \
            --email psteinberg@mednet.ucla.edu
    done
done
