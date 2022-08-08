### PLOTTING ######################################################################################
# Plotting scatterplots impact of seed selection on variability of snv and ccf per cluster:
# 14 patients - head and neck tumour samples
# Strelka2-Battenberg-PyClone-VI single-sample mode: 14 primary tumour samples * 10 seeds
# Strelka2-Battenberg-PyClone-VI multi-sample mode: 7 primary & 2 lymph tumour samples * 10 seeds
# Strelka2-Battenberg-DPClust single-sample 14 primary tumour * 10 seeds


### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);
library(BoutrosLab.statistics.general);
library(BoutrosLab.utilities);
library(data.table);

# Output directory for generated plots
setwd('/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/plots');

# Input directory for src-pipeline output
input.path.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/';

# Select src-pipeline run
pipeline <- c(
    '/run-strelka2-battenberg-pyclone-vi',
    '/run-strelka2-battenberg-dpclust'
    );

# Input data
pyclone.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ss_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

pyclone.ss.snv.ccf <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-08_pyclone_ss_ccf_snv_per_subclones.tsv'),
    sep = '\t',
    header = TRUE
    );

pyclone.ms.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ms_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

dpclust.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[2], '/output/2022-08-05_all_dpclust_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

# Summary of unique clusters (subclones) of all pipeline runs
subclone.summary <- rbind(pyclone.ms.subclones, pyclone.ss.subclones, dpclust.ss.subclones);

### get.subclone.summary ##########################################################################
# get subclone mean and sd per src algorithm tool
pyclone.ss.summary <- setDT(pyclone.ss.subclones)[ , .(mean.clones = mean(n_clones), sd.clones = sd(n_clones), tool = 'pyclone_ss'), by = patient];
pyclone.ms.incomplete <- setDT(pyclone.ms.subclones)[ , .(mean.clones = mean(n_clones), sd.clones = sd(n_clones), tool = 'pyclone_ms'), by = patient];
dpclust.ss.summary <- setDT(dpclust.ss.subclones)[ , .(mean.clones = mean(n_clones), sd.clones = sd(n_clones), tool = 'dpclust_ss'), by = patient];

# Empty ms data
empty.ms <- data.frame(
    patient = c('ILHNLNEV000004', 'ILHNLNEV000005', 'ILHNLNEV000008', 'ILHNLNEV000009', 'ILHNLNEV000010', 'ILHNLNEV000011', 'ILHNLNEV000013'),
    mean.clones = rep(0,7),
    sd.clones = rep(0,7),
    tool = rep('pyclone_ss', 7)
    );

# Add empty data to have 14 ms samples
pyclone.ms.summary <- rbind(pyclone.ms.incomplete, empty.ms);

# Summary (mean and sd) of subclones of all src tools
pipeline.summary <- rbind(pyclone.ms.summary, pyclone.ss.summary, dpclust.ss.summary);

# sort data
pipeline.summary <- pipeline.summary[order(pipeline.summary$patient, pipeline.summary$tool),];
pipeline.summary$order <- 1:nrow(pipeline.summary);

### snv.variance.barplot ##########################################################################
# add here

### ccf.variance.barplot ##########################################################################
# add here
