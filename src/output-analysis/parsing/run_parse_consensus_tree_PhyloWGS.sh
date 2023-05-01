# Submission script for creating consensus tree (PhyloWGS) for each pipeline x sample x seed output

# 10 random seeds
seeds=("366306" "423647" "838004" "50135" "628019" "97782" "253505" "659767" "13142" "51404")

# single-region mode samples
patients=(
    "ILHNLNEV000001-T001-P01-F"
    "ILHNLNEV000002-T001-P01-F"
    "ILHNLNEV000003-T001-P01-F"
    "ILHNLNEV000004-T001-P01-F"
    "ILHNLNEV000005-T001-P01-F"
    "ILHNLNEV000006-T001-P01-F"
    "ILHNLNEV000007-T001-P01-F"
    "ILHNLNEV000008-T001-P01-F"
    "ILHNLNEV000009-T001-P01-F"
    "ILHNLNEV000010-T001-P01-F"
    "ILHNLNEV000011-T001-P01-F"
    "ILHNLNEV000012-T001-P01-F"
    "ILHNLNEV000013-T001-P01-F"
    "ILHNLNEV000014-T001-P01-F"
    )

for seed in ${seeds[@]} 
do
    for patient in ${patients[@]} 
    do
        Rscript /hot/users/psteinberg/work-code/parse_consensus_tree_PhyloWGS.R \
        -s /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-mutect2-battenberg-phylowgs/output/call-SRC-1.0.0-rc.1/${patient}/PhyloWGS-2205be1/output/PhyloWGS-2205be1_${seed}_${patient}_Mutect2-Battenberg-summ.json.gz \
        -o /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-mutect2-battenberg-phylowgs/output/consensus_tree
    done
done

# strelka2-battenberg-phylowgs
# -s /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-strelka2-battenberg-phylowgs/output/call-SRC-1.0.0-rc.1/${patient}/PhyloWGS-2205be1/output/PhyloWGS-2205be1_${seed}_${patient}_Strelka2-Battenberg-summ.json.gz \
# -o /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-strelka2-battenberg-phylowgs/output/consensus_tree

# somaticsniper2-battenberg-phylowgs
# run two different -s directories
# -s /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-somaticsniper-battenberg-phylowgs/output/call-SRC-1.0.0-rc.1/${patient}/PhyloWGS-2205be1/output/PhyloWGS-2205be1_${seed}_${patient}_SomaticSniper-Battenberg-summ.json.gz \
# -s /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-somaticsniper-battenberg-phylowgs/output/call-SRC-1.1.0/${patient}/PhyloWGS-2205be1/output/PhyloWGS-2205be1_${seed}_${patient}_SomaticSniper-Battenberg-summ.json.gz \
# -o /hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-somaticsniper-battenberg-phylowgs/output/consensus_tree
