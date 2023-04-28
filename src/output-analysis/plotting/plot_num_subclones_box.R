### plot_num_subclones_box.R ######################################################################
# Boxplot of median, max, first and third quartile of subclones called per seed x sample.
### PREAMBLE ######################################################################################
# load libraries
# install.packages('BoutrosLab.plotting.general');
# install.packages('argparse');
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
        main = paste(args$pipeline, ' (', args$mode, ')'),
        ylab.label = 'Number of subclones',
        xlab.label = 'Patient',
        main.just = 'center',
        main.x = 0.52,
        add.stripplot = TRUE,
        points.pch = 19,
        points.col = 'black',
        points.cex = 0.4,
        points.alpha = 1,
        col = src.colour,
        alpha.rectangle = 0.8,
        main.cex = 1.1,
        xaxis.cex = 0,
        yaxis.cex = 0.8,
        xlab.cex = 1,
        ylab.cex = 1,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0),
        xaxis.rot = 40,
        xaxis.fontface = 1,
        yaxis.fontface = 1,
        top.padding = 1,
        bottom.padding = 1,
        right.padding = 1,
        left.padding = 1,
        ylab.axis.padding = 1,
        description = 'Boxplot created by BoutrosLab.plotting.general',
        height = 4,
        width = 7
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
        main = paste(args$pipeline, ' (', args$mode, ')'),
        ylab.label = 'Number of subclones',
        xlab.label = 'Patient',
        main.just = 'center',
        main.x = 0.52,
        add.stripplot = TRUE,
        points.pch = 19,
        points.col = 'black',
        points.cex = 0.6,
        points.alpha = 1,
        col = src.colour,
        alpha.rectangle = 0.8,
        main.cex = 1.1,
        xaxis.cex = 0,
        yaxis.cex = 0.8,
        xlab.cex = 1,
        ylab.cex = 1,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0),
        xaxis.rot = 40,
        xaxis.fontface = 1,
        yaxis.fontface = 1,
        top.padding = 1,
        bottom.padding = 1,
        right.padding = 1,
        left.padding = 1,
        ylab.axis.padding = 1,
        description = 'Boxplot created by BoutrosLab.plotting.general',
        height = 4,
        width = 7
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
