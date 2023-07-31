# stripplot for relative seed variability in number of subclones called
projectdir=/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/
workdir=/hot/user/yiyangliu/repo/project-AlgorithmEvaluation-BNCH-000082-SRCRNDSeed/src/output-analysis/plotting/

cd ${workdir}
for snv in Strelka2 Mutect2 SomaticSniper; do echo ${snv}
    for src in DPClust PhyloWGS PyClone-VI; do echo ${src}
        for mode in sr mr; do echo ${mode}
            snvl=${snv,,}; echo ${snvl}
            srcl=${src,,}; echo ${srcl}
            file=$(ls ${projectdir}/pipeline-call-src/run-${snvl}-battenberg-${srcl}/output/*${snvl}_battenberg_${srcl}_${mode}.tsv -Art | tail -n 1)
            echo ${file}
            if [ -f "$file" ]; then
                Rscript ${workdir}/subclone_relative_seed_variability.R -f ${file} -p ${snv}-Battenberg-${src} -m ${mode} -o ${projectdir}/pipeline-call-src/plots/stripplot2
            fi
        done
    done
done
