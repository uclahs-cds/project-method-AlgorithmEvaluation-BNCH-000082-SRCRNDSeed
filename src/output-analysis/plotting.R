### PLOTTING ######################################################################################
# Plotting impact of seed selection on variability of src pipeline output:
# 14 patients - head and neck tumour samples
# Strelka2-Battenberg-PyClone-VI single-sample mode: 14 primary tumour samples * 10 seeds
# Strelka2-Battenberg-PyClone-VI multi-sample mode: 7 primary & 2 lymph tumour samples * 10 seeds
# Strelka2-Battenberg-DPClust single-sample 14 primary tumour * 10 seeds


### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);
library(BoutrosLab.statistics.general);
library(BoutrosLab.utilities);
library(dplyr);

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
pyclone.ss.summary <- pyclone.ss.subclones %>% group_by(patient) %>% summarise(
    mean.clones = mean(n_clones),
    sd.clones = sd(n_clones),
    tool = 'pyclone_ss'
    );

pyclone.ms.summary <- pyclone.ms.subclones %>% group_by(patient) %>% summarise(
  mean.clones = mean(n_clones),
  sd.clones = sd(n_clones),
  tool = 'pyclone_ms'
  );

dpclust.ss.summary <- dpclust.ss.subclones %>% group_by(patient) %>% summarise(
  mean.clones = mean(n_clones),
  sd.clones = sd(n_clones),
  tool = 'dpclust_ms'
  );

# Summary (mean and sd) of subclones of all src tools
pipeline.summary <- rbind(pyclone.ms.summary, pyclone.ss.summary, dpclust.ss.summary);

### pipeline.variance.barplot #####################################################################
# Comparison of mean number of subclones per src pipeline
pipeline.variance.barplot <- create.barplot(
    formula = mean.clones ~ patient,
    data = pipeline.summary,
    groups = tool,
    filename = generate.filename('proj-seed', 'pipeline.variance.barplot', 'png'),
    main = 'Number of subclones across SRC pipelines',
    xlab.lab = 'Patients',
    ylab.lab = 'Mean number of subclones',
    main.x = 0.52,
    ylimits = c(0,10),
    yat = seq(0,10,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0.7,
    yaxis.cex = 0.9,
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
    xlab.axis.padding = 2,
    # Add sd error bars
    # y.error.up = ifelse(
    #    test = pipeline.summary$sd.clones != 0,
    #    yes = pipeline.summary$sd.clones,
    #    no = NA
    #    ),
    # y.error.bar.col = 'black',
    # error.bar.lwd = 1,
    # error.whisker.angle = 90,
    col = c('#f56763', '#4a4ba6', '#cae5ff'),
    legend = list(
        inside = list(
            fun = draw.key,
                args = list(
                    key = list(
                      points = list(
                          col = 'black',
                          pch = 22,
                          cex = 2,
                          fill = c('#f56763', '#4a4ba6', '#cae5ff')
                          ),
                      text = list(
                          lab = c('DPClust','PyClone-VI multi-sample mode', 'PyClone-VI single-sample mode')
                          ),
                      padding.text = 3,
                      cex = 1
                      )
                  ),
                  x = 0.03,
                  y = 0.95
            )
        ),
    description = 'Barplot created by BoutrosLab.plotting.general',
    height = 6,
    width = 9
    );

### snv.variance.barplot ##########################################################################
# add here

### ccf.variance.barplot ##########################################################################
# add here

### dplcust.boxplot ###############################################################################
dplcust.boxplot <- create.boxplot(
    formula = n_clones ~ patient,
    data = dpclust.ss.subclones,
    filename = generate.filename('proj-seed', 'DPClust_boxplot', '.png'),
    main = 'DPClust variability of subclones across 10 random seeds',
    ylab.label = 'Number of subclones',
    xlab.label = 'Head and neck primary tumour samples from 14 patients',
    col = '#f56763',
    main.x = 0.52,
    ylimits = c(0,10),
    yat = seq(0,10,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 6,
    width = 9
    );

### pyclone.ss.boxplot ############################################################################
pyclone.ss.boxplot <- create.boxplot(
    formula = n_clones ~ patient,
    data = pyclone.ss.subclones,
    filename = generate.filename('proj-seed', 'PyClone-VI_ss_boxplot', 'png'),
    main = 'PyClone-VI (ss) variability of subclones across 10 random seeds',
    ylab.label = 'Number of subclones',
    xlab.label = 'Head and neck primary tumour samples from 14 patients',
    col = '#cae5ff',
    main.x = 0.52,
    ylimits = c(0,10),
    yat = seq(0,10,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 6,
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
    col = '#4a4ba6',
    main.x = 0.52,
    ylimits = c(0,10),
    yat = seq(0,10,1),
    xaxis.tck = c(1,0),
    yaxis.tck = c(1,0),
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0,
    yaxis.cex = 0.9,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 40,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    description = 'Boxplot created by BoutrosLab.plotting.general',
    height = 6,
    width = 9
    );
