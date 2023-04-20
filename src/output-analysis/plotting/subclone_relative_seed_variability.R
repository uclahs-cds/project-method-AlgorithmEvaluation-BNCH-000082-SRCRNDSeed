### subclone_relative_seed_var.R ##################################################################
# Variability in number of subclones called across seeds per patient for each pipeline run.
# Compare number of subclones called for a seed to mode number of subclones called across 10 seeds.

### PREAMBLE ######################################################################################
# load libraries
# install.packages("BoutrosLab.plotting.general");
library(BoutrosLab.plotting.general);
library(BoutrosLab.utilities);
library(argparse);

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-f', '--file', type = 'character', help = 'path to num_subclones tsv');
parser$add_argument('-p', '--pipeline', type = 'character', help = 'src pipeline (snv-cnv-src)');
parser$add_argument('-m', '--mode', type = 'character', help = 'src pipeline mode (single-region or multi-region)');
parser$add_argument('-o', '--output', type = 'character', help = 'path to plot output directory');
args <- parser$parse_args();

### PROCESS DATA ##################################################################################
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

# read input data
subclones.data <- read.table(file = args$file, sep = '\t', header = TRUE);
subclones.data;

### PLOT ACCESSORIES ##############################################################################
# colour scheme for clonality
clonality.colour.scheme <- c('monoclonal' = 'pink', 'polyclonal' = '#825EBC', 'polytumour' = '#C681D8');

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

### MODE COMPARISON FUNCTION ######################################################################
# mode function
getmode <- function(s) {
    uniq <- unique(s)
    uniq[which.max(tabulate(match(s, uniq)))]
    };

# function for comparison of number of subclones vs mode of subclones across seeds per patient
process.subclones.for.plotting.mode <- function(subclones.df) {
    # split df by patient and determine if each seed had more or fewer subclones than mode
    subclones.split <- split(subclones.df, subclones.df$patient)
    subclones.split <- lapply(subclones.split, function(x) {
        x$compare <- ifelse(
            test = x$n_clones > getmode(x$n_clones),
            yes = '+',
            no = ifelse(
                test = x$n_clones < getmode(x$n_clones),
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

### SR FUNCTION ###################################################################################
plot.sr <- function(df) {
    subclones.data.toplot <- process.subclones.for.plotting.mode(df);
    # create stripplot of relative seed variability for single-region mode
    plot <- create.scatterplot(
        formula = seed.plot.order ~ order,
        data = subclones.data.toplot,
        filename = generate.filename(
            'proj-seed',
            paste0(args$pipeline, '_', args$mode, '_relative_seed_var'),
            'pdf'
            ),
        main = paste(args$pipeline, ' (', args$mode, ') ', 'Subclone Variability Across 10 Seeds'),
        ylab.label = 'Seed',
        xlab.label = 'Number of Subclones Compared to Mode of Subclones',
        col = subclones.data.toplot$col,
        main.x = 0.52,
        ylimits = c(0.5,10.5),
        yat = seq(1,10,1),
        yaxis.lab = rev(seeds),
        xaxis.tck = c(0,0),
        yaxis.tck = c(1,0),
        xlimits = c(0.5, length(unique(subclones.data.toplot$patient)) * 3 + 0.5),
        xat = 1:(length(unique(subclones.data.toplot$patient)) * 3),
        xaxis.lab = rep(c('-', '=', '+'), length(unique(subclones.data.toplot$patient))),
        abline.v = 1:length(unique(subclones.data.toplot$patient)) * 3 + 0.5,
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
        height = 4,
        width = 10,
        resolution = 300
        );
    };

### MR FUNCTION ###################################################################################
plot.mr <- function(df) {
    subclones.data.toplot <- process.subclones.for.plotting.mode(df);
    # create stripplot of relative seed variability for multi-region mode
    plot <- create.scatterplot(
        formula = seed.plot.order ~ order,
        data = subclones.data.toplot,
        filename = generate.filename(
            'proj-seed',
            paste0(args$pipeline, '_', args$mode, '_relative_seed_var'),
            'pdf'
            ),
        main = paste(args$pipeline, ' (', args$mode, ') ', 'Subclone Variability Across 10 Seeds'),
        ylab.label = 'Seed',
        xlab.label = 'Number of Subclones Compared to Mode of Subclones',
        col = subclones.data.toplot$col,
        main.x = 0.5,
        ylimits = c(0.5,10.5),
        yat = seq(1,10,1),
        yaxis.lab = rev(seeds),
        xaxis.tck = c(0,0),
        yaxis.tck = c(1,0),
        xlimits = c(0.5, length(unique(subclones.data.toplot$patient)) * 3 + 0.5),
        xat = 1:(length(unique(subclones.data.toplot$patient)) * 3),
        xaxis.lab = rep(c('-', '=', '+'), length(unique(subclones.data.toplot$patient))),
        abline.v = 1:length(unique(subclones.data.toplot$patient)) * 3 + 0.5,
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
        height = 4,
        width = 10,
        resolution = 300,
        legend = list(
            right = list(fun = clonality.legends.grob)
            )
        );
    };

### PLOT ##########################################################################################
# do either sr or mr plot
setwd(args$output);
if (args$mode == 'sr') {
    plot.sr(subclones.data)
    print('plotting sr')
    } else {
        plot.mr(subclones.data)
        print('plotting mr')
    };
