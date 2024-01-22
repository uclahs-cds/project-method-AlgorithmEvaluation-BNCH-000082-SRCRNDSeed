### plot_num_subclones_box.R ######################################################################
# Boxplot of median, max, first and third quartile of subclones called per seed x sample.

### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);
library(BoutrosLab.statistics.general);
library(BoutrosLab.utilities);
library(argparse);
library(data.table);

# import colour scheme
source('plot_accessories.R');

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-f', '--file', type = 'character', help = 'path to num_subclones tsv');
parser$add_argument('-p', '--pipeline', type = 'character', help = 'src pipeline (snv-cnv-src)');
parser$add_argument('-m', '--mode', type = 'character', help = 'src pipeline mode (sr or mr)');
parser$add_argument('-o', '--output', type = 'character', help = 'path to plot output directory');
args <- parser$parse_args();

### PROCESS DATA ##################################################################################
subclones.data <- read.table(file = args$file, sep = '\t', header = TRUE);

src.tool <- strsplit(args$pipeline, '-')[[1]][3];
src.colour <- pipeline.colour.scheme[src.tool];

filename <- paste0('2024_01_01-', args$pipeline, '_', args$mode, '_subclones_box.pdf');
print(filename);

### SR FUNCTION ###################################################################################
plot.sr <- function(df) {
    plot <- create.boxplot(
        formula = patient ~ n_clones,
        data = df,
        filename = filename,
        main = args$pipeline,
        xlab.label = 'Number of Subclones',
        ylab.label = 'Patient',
        main.just = 'center',
        main.x = 0.52,
        xlimits = c(0.5, 9.5),
        xat = seq(1, 9, 1),
        yaxis.lab = patients.sr,
        add.stripplot = TRUE,
        points.pch = 19,
        points.col = 'black',
        points.cex = 0.4,
        points.alpha = 1,
        col = src.colour,
        alpha.rectangle = 0.8,
        main.cex = 1.6,
        xaxis.cex = 1.6,
        yaxis.cex = 1.6,
        xlab.cex = 1.6,
        ylab.cex = 1.6,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0, 1),
        xaxis.rot = 0,
        xaxis.fontface = 1,
        yaxis.fontface = 1,
        top.padding = 1,
        bottom.padding = 1,
        right.padding = 1,
        left.padding = 1,
        ylab.axis.padding = 1,
        description = 'Boxplot created by BoutrosLab.plotting.general',
        height = 8,
        width = 4
        );
    };

### MR FUNCTION ###################################################################################
plot.mr <- function(df) {
    plot <- create.boxplot(
        formula = patient ~ n_clones,
        data = df,
        filename = filename,
        main = args$pipeline,
        xlab.label = 'Number of Subclones',
        ylab.label = 'Patient',
        main.just = 'center',
        main.x = 0.52,
        xlimits = c(0.5, 9.5),
        xat = seq(1, 9, 1),
        yaxis.lab = patients.mr,
        yat = seq(1, 9, 1),
        add.stripplot = TRUE,
        points.pch = 19,
        points.col = 'black',
        points.cex = 0.4,
        points.alpha = 1,
        col = src.colour,
        alpha.rectangle = 0.8,
        main.cex = 1.6,
        xaxis.cex = 1.6,
        yaxis.cex = 1.6,
        xlab.cex = 1.6,
        ylab.cex = 1.6,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0),
        xaxis.rot = 0,
        xaxis.fontface = 1,
        yaxis.fontface = 1,
        top.padding = 35,
        bottom.padding = 1,
        right.padding = 1,
        left.padding = 1,
        ylab.axis.padding = 1,
        size.units = "inches",
        description = 'Boxplot created by BoutrosLab.plotting.general'
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
