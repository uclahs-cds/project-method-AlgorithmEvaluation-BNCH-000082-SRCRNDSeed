### plot_num_subclones_box.R ######################################################################
# Boxplot of num, mean, and sd of subclones called per seed x sample.
### PREAMBLE ######################################################################################
# load libraries
# install.packages('BoutrosLab.plotting.general');
# install.packages('argparse');
library(BoutrosLab.plotting.general);
library(BoutrosLab.statistics.general);
library(BoutrosLab.utilities);
library(argparse);
library(data.table);

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-f', '--file', type = 'character', help = 'path to num_subclones tsv');
parser$add_argument('-p', '--pipeline', type = 'character', help = 'src pipeline (snv-cnv-src)');
parser$add_argument('-m', '--mode', type = 'character', help = 'src pipeline mode (sr or mr)');
parser$add_argument('-o', '--output', type = 'character', help = 'path to plot output directory');
args <- parser$parse_args();

### PLOT ACCESSORIES ##############################################################################
# colour scheme for Pipelines
pipeline.colour.scheme <- c('DPClust' = '#f567637f', 'PyClone-VI' = '#cae5ff', 'PhyloWGS' = '#4a4ba6');

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

### PROCESS DATA ##################################################################################
subclones.data <- read.table(file = args$file, sep = '\t', header = TRUE);
subclones.data;

src.tool <- strsplit(args$pipeline, '-')[[1]][3];
src.colour <- pipeline.colour.scheme[src.tool];

### SR FUNCTION ###################################################################################
plot.sr <- function(df) {
    plot <- create.boxplot(
        formula = n_clones ~ patient,
        data = subclones.data,
        filename = generate.filename(
            'proj-seed',
            paste0(args$pipeline, '_', args$mode, '_subclones_box'),
            'pdf'
            ),
        main = paste(args$pipeline, ' (', args$mode, ') ', 'Subclone Variability Across 10 Seeds'),
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
        col = src.colour,
        alpha.rectangle = 0.8,
        main.cex = 1.1,
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
    };

### MR FUNCTION ###################################################################################
plot.mr <- function(df) {
    plot <- create.boxplot(
        formula = n_clones ~ patient,
        data = subclones.data,
        filename = generate.filename(
          'proj-seed',
          paste0(args$pipeline, '_', args$mode, '_subclones_box'),
          'pdf'
        ),
        main = paste(args$pipeline, ' (', args$mode, ') ', 'Subclone Variability Across 10 Seeds'),
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
        col = '#cae5ff7f',
        alpha.rectangle = 0.8,
        main.cex = 1.1,
        xaxis.cex = 0,
        yaxis.cex = 0.9,
        xlab.cex = 1.1,
        ylab.cex = 1.1,
        xat = seq(1,14,1),
        yaxis.tck = c(1,0),
        xaxis.tck = c(1,0),
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
        width = 9
        );
    };

### PLOT  #########################################################################################
# do either sr or mr plot
setwd(args$output);
if (args$mode == 'sr') {
    plot.sr(subclones.data)
    print('plotting sr')
  } else {
      plot.mr(subclones.data)
      print('plotting mr')
      };
