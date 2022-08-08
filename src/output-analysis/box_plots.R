### PLOTTING ######################################################################################
# Plotting boxplots for impact of seed selection on variability of src pipeline output:
# 14 patients - head and neck tumour samples
# Strelka2-Battenberg-DPClust single-sample 14 primary tumour * 10 seeds
# Strelka2-Battenberg-PyClone-VI single-sample mode: 14 primary tumour samples * 10 seeds
# Strelka2-Battenberg-PyClone-VI multi-sample mode: 7 primary & 2 lymph tumour samples * 10 seeds

### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);
library(BoutrosLab.statistics.general);
library(BoutrosLab.utilities);

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
dpclust.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[2], '/output/2022-08-05_all_dpclust_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

pyclone.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ss_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

pyclone.ms.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ms_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );

# Summary of unique clusters (subclones) of all pipeline runs
subclone.summary <- rbind(pyclone.ms.subclones, pyclone.ss.subclones, dpclust.ss.subclones);

### dplcust.boxplot ###############################################################################
dplcust.boxplot <- create.boxplot(
    formula = n_clones ~ patient,
    data = dpclust.ss.subclones,
    filename = generate.filename('proj-seed', 'DPClust_boxplot', 'png'),
    main = 'DPClust variability of subclones across 10 random seeds',
    ylab.label = 'Number of subclones',
    xlab.label = 'Head and neck primary tumour samples from 14 patients',
    main.just = 'center',
    main.x = 0.52,
    # add points
    add.stripplot = TRUE,
    points.pch = 19,
    points.col = 'black',
    points.cex = 0.3,
    points.alpha = 1,
    col = '#f56763',
    alpha.rectangle = 0.8,
    main.cex = 1.2,
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 4,
    width = 9,
    );

### pyclone.ss.boxplot ############################################################################
pyclone.ss.boxplot <- create.boxplot(
    formula = n_clones ~ patient,
    data = pyclone.ss.subclones,
    filename = generate.filename('proj-seed', 'PyClone-VI_ss_boxplot', 'png'),
    main = 'PyClone-VI (ss) variability of subclones across 10 random seeds',
    ylab.label = 'Number of subclones',
    xlab.label = 'Head and neck primary tumour samples from 14 patients',
    main.just = 'center',
    main.x = 0.52,
    # add points
    add.stripplot = TRUE,
    points.pch = 19,
    points.col = 'black',
    points.cex = 0.3,
    points.alpha = 1,
    col = '#cae5ff',
    main.cex = 1.2,
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    ylimits = c(0.8,4),
    yat = seq(0,4,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 3,
    width = 9
    );

### pyclone.ms.boxplot ############################################################################
pyclone.ms.boxplot <- create.boxplot(
    formula = n_clones ~ patient,
    data = pyclone.ms.subclones,
    filename = generate.filename('proj-seed', 'PyClone-VI_ms_boxplot', 'png'),
    main = 'PyClone-VI (ms) variability of subclones across 10 random seeds',
    ylab.label = 'Number of subclones',
    xlab.label = 'Head and neck (1 primary and 2 lymph) tumour samples from 7 patients',
    main.just = 'center',
    main.x = 0.52,
    # add points
    add.stripplot = TRUE,
    points.pch = 19,
    points.col = 'black',
    points.cex = 0.3,
    points.alpha = 1,
    col = '#4a4ba6',
    main.cex = 1.2,
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    ylimits = c(0, 5),
    yat = seq(0,5,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 3,
    width = 9
    );
