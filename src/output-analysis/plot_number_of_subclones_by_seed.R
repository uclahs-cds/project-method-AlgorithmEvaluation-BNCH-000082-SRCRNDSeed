### PLOTTING ########################################################################################
# Plotting scatterplot for impact of seed selection on variability of src pipeline output.
# Comparing number of subclones from 9 random seeds to 1 reference seed (51404).
# Visualizing relative variability across seeds per patient for each pipeline run.

# 14 patients - head and neck tumour samples
# Strelka2-Battenberg-DPClust single-sample mode: 14 primary tumour * 10 seeds
# Strelka2-Battenberg-PyClone-VI single-sample mode: 14 primary tumour samples * 10 seeds
# Strelka2-Battenberg-PyClone-VI multi-sample mode: 7 primary & 2 lymph tumour samples * 10 seeds

### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);

# Output directory for generated plots
setwd('/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/plots');

# Input directory for src-pipeline output
input.path.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/';

# Select src-pipeline run
pipeline <- c(
    '/run-strelka2-battenberg-pyclone-vi',
    '/run-strelka2-battenberg-dpclust'
    );

# 10 random seeds
seeds <- c(
    '51404',
    '366306',
    '423647',
    '838004',
    '50135',
    '628019',
    '97782',
    '253505',
    '659767',
    '13142'
    );

# colour scheme for clonality
clonality.colour.scheme <- c('monoclonal' = 'pink', 'polyclonal' = '#825EBC', 'polytumour' = '#C681D8');

# Input data
pyclone.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ss_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );
pyclone.ss.subclones$tool <- 'pyclone_ss'

pyclone.ms.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[1], '/output/2022-08-05_pyclone_ms_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );
pyclone.ms.subclones$tool <- 'pyclone_ms'

dpclust.ss.subclones <- read.table(
    file = paste0(input.path.stem, pipeline[2], '/output/2022-08-05_all_dpclust_subclones_per_patient_seed.tsv'),
    sep = '\t',
    header = TRUE
    );
dpclust.ss.subclones$tool <- 'dpclust_ss'

### function ###############################################################################

# Do comparison of random seeds 2-10 to reference seed 1 (51404)
process.subclones.for.plotting <- function(subclones.df) {

    # split df by patient and determine if each seed had more or fewer subclones than seed 1
    subclones.split <- split(subclones.df, subclones.df$patient)
    subclones.split <- lapply(subclones.split, function(x) {
        x$compare <- ifelse(
            test = x$n_clones > x$n_clones[x$seed == seeds[1]],
            yes = '+',
            no = ifelse(
                test = x$n_clones < x$n_clones[x$seed == seeds[1]],
                yes = '-',
                no = '='
                )
            )
            x
            }
        )

    # every patient has 3 columns of dots (-, =, +)
    for (i in 1:length(subclones.split)) {
        subclones.split[[i]]$order <- ifelse(
            test = subclones.split[[i]]$compare == '=',
            yes = ((i - 1) * 3 + 2),
            no = ifelse(
                test = subclones.split[[i]]$compare == '+',
                yes = ((i - 1) * 3 + 3),
                no = ((i - 1) * 3 + 1)
                )
            )
        }

    # add colour for type
    subclones.split <- lapply(subclones.split, function(x) {
        x$col <- ifelse(
            test = x$n_clones == 1,
            yes = clonality.colour.scheme['monoclonal'],
            no = clonality.colour.scheme['polyclonal']
            )
            x
            }
        )

    # combine list back to single data frame
    subclones.df.toplot <- do.call(rbind, subclones.split)

    # order seeds from 1 to 10 (1 at the top)
    subclones.df.toplot$seed.order <- match(subclones.df.toplot$seed, seeds)
    subclones.df.toplot$seed.plot.order <- 11 - subclones.df.toplot$seed.order

    return(subclones.df.toplot)
    };

### legend ###############################################################################

# clonality legend
clonality.legends <- list(
    legend = list(
        colours = clonality.colour.scheme[1:2],
        labels = c('Monoclonal', 'Polyclonal'),
        title = expression(bold(underline('Clonality'))),
        lwd = 0.1
        )
    );

clonality.legends.grob <- legend.grob(
    legends = clonality.legends,
    label.cex = 0.75,
    title.just = 'left'
    );

### dplcust ###############################################################################

dpclust.ss.subclones.toplot <- process.subclones.for.plotting(dpclust.ss.subclones)

dplcust <- create.scatterplot(
    formula = seed.plot.order ~ order,
    data = dpclust.ss.subclones.toplot,
    filename = generate.filename('proj-seed', 'DPClust_num_subclones_by_seed', 'png'),
    main = 'DPClust number of subclones across 10 random seeds',
    ylab.label = 'Seed',
    xlab.label = 'Number of Subclones Compared to the First Seed',
    col = dpclust.ss.subclones.toplot$col,
    main.x = 0.52,
    ylimits = c(0.5,10.5),
    yat = seq(1,10,1),
    yaxis.lab = rev(seeds),
    xaxis.tck = c(0,0),
    yaxis.tck = c(1,0),
    xlimits = c(0.5, length(unique(dpclust.ss.subclones.toplot$patient)) * 3 + 0.5),
    xat = 1:(length(unique(dpclust.ss.subclones.toplot$patient)) * 3),
    xaxis.lab = rep(c('-', '=', '+'), length(unique(dpclust.ss.subclones.toplot$patient))),
    abline.v = 1:length(unique(dpclust.ss.subclones.toplot$patient)) * 3 + 0.5,
    abline.col = 'black',
    abline.lwd = 1,
    abline.lty = 1,
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0.7,
    yaxis.cex = 0.7,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 0,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Scatterplot created by BoutrosLab.plotting.general',
    height = 5,
    width = 15,
    );

### pyclone ss ###############################################################################

pyclone.ss.subclones.toplot <- process.subclones.for.plotting(pyclone.ss.subclones)

pyclone.ss <- create.scatterplot(
    formula = seed.plot.order ~ order,
    data = pyclone.ss.subclones.toplot,
    filename = generate.filename('proj-seed', 'PyClone-VI_ss_num_subclones_by_seed', 'png'),
    main = 'PyClone (ss) number of subclones across 10 random seeds',
    ylab.label = 'Seed',
    xlab.label = 'Number of Subclones Compared to the First Seed',
    col = pyclone.ss.subclones.toplot$col,
    main.x = 0.52,
    ylimits = c(0.5,10.5),
    yat = seq(1,10,1),
    yaxis.lab = rev(seeds),
    xaxis.tck = c(0,0),
    yaxis.tck = c(1,0),
    xlimits = c(0.5, length(unique(pyclone.ss.subclones.toplot$patient)) * 3 + 0.5),
    xat = 1:(length(unique(pyclone.ss.subclones.toplot$patient)) * 3),
    xaxis.lab = rep(c('-', '=', '+'), length(unique(pyclone.ss.subclones.toplot$patient))),
    abline.v = 1:length(unique(pyclone.ss.subclones.toplot$patient)) * 3 + 0.5,
    abline.col = 'black',
    abline.lwd = 1,
    abline.lty = 1,
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0.7,
    yaxis.cex = 0.7,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 0,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Scatterplot created by BoutrosLab.plotting.general',
    height = 5,
    width = 15,
    );

### pyclone ms ###############################################################################

# Add legend to ms plot
pyclone.ms.subclones.toplot <- process.subclones.for.plotting(pyclone.ms.subclones)

pyclone.ms <- create.scatterplot(
    formula = seed.plot.order ~ order,
    data = pyclone.ms.subclones.toplot,
    filename = generate.filename('proj-seed', 'PyClone-VI_ms_num_subclones_by_seed', 'png'),
    main = 'PyClone (ms) number of subclones across 10 random seeds',
    ylab.label = 'Seed',
    xlab.label = 'Number of Subclones Compared to the First Seed',
    col = pyclone.ms.subclones.toplot$col,
    main.x = 0.5,
    ylimits = c(0.5,10.5),
    yat = seq(1,10,1),
    yaxis.lab = rev(seeds),
    xaxis.tck = c(0,0),
    yaxis.tck = c(1,0),
    xlimits = c(0.5, length(unique(pyclone.ms.subclones.toplot$patient)) * 3 + 0.5),
    xat = 1:(length(unique(pyclone.ss.subclones.toplot$patient)) * 3),
    xaxis.lab = rep(c('-', '=', '+'), length(unique(pyclone.ms.subclones.toplot$patient))),
    abline.v = 1:length(unique(pyclone.ms.subclones.toplot$patient)) * 3 + 0.5,
    abline.col = 'black',
    abline.lwd = 1,
    abline.lty = 1,
    main.cex = 1.2,
    main.just = 'center',
    xaxis.cex = 0.7,
    yaxis.cex = 0.7,
    xlab.cex = 1.1,
    ylab.cex = 1.1,
    xaxis.rot = 0,
    xaxis.fontface = 1,
    yaxis.fontface = 1,
    top.padding = 4,
    bottom.padding = 4,
    right.padding = 4,
    left.padding = 4,
    ylab.axis.padding = 2,
    description = 'Scatterplot created by BoutrosLab.plotting.general',
    height = 5,
    width = 11,
    legend = list(
        right = list(fun = clonality.legends.grob)
        )
    );
