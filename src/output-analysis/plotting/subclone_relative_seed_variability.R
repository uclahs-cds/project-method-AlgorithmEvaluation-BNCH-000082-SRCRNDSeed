## subclone_relative_seed_variability.R ###########################################################
# Variability in number of subclones called across seeds per patient for each pipeline run.
# Compare number of subclones called for a seed to mode number of subclones called across 10 seeds.
# Rscript ./subclone_relative_seed_variability.R \
#  -f ./data/2023-04-02_num_subclones_mutect2_battenberg_pyclone-vi_sr.tsv \
#  -p Mutect2-Battenberg-PyClone-VI \
#  -m sr \
#  -o ./plots/seed/

### PREAMBLE ######################################################################################
# load libraries
library(BoutrosLab.plotting.general);
#library(BoutrosLab.utilities);
library(argparse);

# import seeds and colour schemes
source('plot_accessories.R');

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-f', '--file', type = 'character', help = 'path to num_subclones tsv');
parser$add_argument('-p', '--pipeline', type = 'character', help = 'src pipeline (snv-cnv-src)');
parser$add_argument('-m', '--mode', type = 'character', help = 'src pipeline mode (sr or mr)');
parser$add_argument('-o', '--output', type = 'character', help = 'path to plot output directory');
args <- parser$parse_args();

subclones.data <- read.table(file = args$file, sep = '\t', header = TRUE);

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
                yes = '\U2212',
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

#### PARSE MATRIX #################################################################################
subclones.data.toplot <- process.subclones.for.plotting.mode(subclones.data)

# reprocess symbols into a matrix as should be plotted
symbol.matrix <- matrix(subclones.data.toplot$compare, nrow = length(unique(subclones.data.toplot$patient)), ncol = length(seeds), byrow = TRUE)
# output every index of the matrix to indicate where each symbol should go
nclones.ind <- which(symbol.matrix != '', arr.ind = TRUE);
nclones.x <- nclones.ind[, 2];
nclones.y <- nclones.ind[, 1];

# get all symbols in the order of the indices
nclones.text <- apply(nclones.ind, 1, function(x) symbol.matrix[x[1], x[2]])
# convert the symbols to unicode to actually plot
nclones.3.cex <- c('\U2212', '=', '+');
names(nclones.3.cex) <- c('−', '=', '+');
nclones.text <- nclones.3.cex[nclones.text]

# get all colours in the order of the indices
col.matrix <- matrix(subclones.data.toplot$col, nrow = length(unique(subclones.data.toplot$patient)), ncol = length(seeds), byrow = TRUE)
nclones.col <- apply(nclones.ind, 1, function(x) col.matrix[x[1], x[2]])

nclones.pos <- rep(3, length(nclones.text));
nclones.offset <- rep(-0.3, length(nclones.text));
nclones.cex <- rep(1.6, length(nclones.text));

# readjust seed labels
adjust.seed.labs <- function(labels) {
    for (i in seq_along(labels)) {
        if (i %% 2 == 0) {
            labels[i] <- paste0('\n', labels[i])
            }
        }
    return(labels)
    };
seed.labs <- adjust.seed.labs(seeds);

### SR FUNCTION ###################################################################################
plot.sr <- function(df) {
    blank.heatmap <- matrix(
        rep(c('grey95', 'white'), length.out = 14),
        ncol = length(seeds),
        nrow = length(unique(df$patient))
        )
    create.heatmap(
        x = blank.heatmap,
        same.as.matrix = TRUE,
        input.colours = TRUE,
        clustering.method = 'none',
        plot.dendrograms = 'none',
        filename = generate.filename(
            'proj-seed',
            paste0(args$pipeline, '_', args$mode, '_seed_variability'),
            'pdf'
            ),
        print.colour.key = FALSE,
        main = args$pipeline,
        main.cex = 1.6,
        xlab.cex = 1.6,
        xlab.label = 'Seed',
        ylab.cex = 1.6,
        ylab.label = 'Patient',
        xaxis.cex = 1.1,
        yaxis.lab = rev(patients.sr),
        yaxis.cex = 1.1,
        yaxis.rot = 0,
        yat = 1:length(patients.sr),
        xat = seq(1, 10, 1),
        xaxis.lab = seed.labs,
        xaxis.rot = 0,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0),
        grid.col = TRUE,
        force.grid.col = TRUE,
        col.colour = 'grey50',
        col.lwd = TRUE,
        grid.row = FALSE,
        force.grid.row = TRUE,
        row.colour = 'grey50',
        row.pos = nclones.y,
        col.pos = nclones.x,
        cell.text = nclones.text,
        text.fontface = 1,
        text.col = nclones.col,
        text.cex = nclones.cex,
        text.position = nclones.pos,
        text.offset = nclones.offset,
        height = 6,
        width = 6
        )
    };

### MR FUNCTION ###################################################################################
plot.mr <- function(df) {
    blank.heatmap <- matrix(
        rep(c('grey95', 'white'), length.out = 7),
        ncol = length(seeds),
        nrow = length(unique(df$patient))
    )
    create.heatmap(
        x = blank.heatmap,
        same.as.matrix = TRUE,
        input.colours = TRUE,
        clustering.method = 'none',
        plot.dendrograms = 'none',
        filename = generate.filename(
            'proj-seed',
            paste0(args$pipeline, '_', args$mode, '_seed_variability'),
            'pdf'
        ),
        print.colour.key = FALSE,
        main = args$pipeline,
        main.cex = 1.6,
        xlab.cex = 1.6,
        xlab.label = 'Seed',
        ylab.cex = 1.6,
        ylab.label = 'Patient',
        xaxis.cex = 1.1,
        yaxis.lab = rev(patients.mr),
        yaxis.cex = 1.1,
        yaxis.rot = 0,
        yat = 1:length(patients.mr),
        xat = seq(1, 10, 1),
        xaxis.lab = seed.labs,
        xaxis.rot = 0,
        xaxis.tck = c(1, 0),
        yaxis.tck = c(1, 0),
        grid.col = TRUE,
        force.grid.col = TRUE,
        col.colour = 'grey50',
        col.lwd = TRUE,
        grid.row = FALSE,
        force.grid.row = TRUE,
        row.colour = 'grey50',
        row.pos = nclones.y,
        col.pos = nclones.x,
        cell.text = nclones.text,
        text.fontface = 1,
        text.col = nclones.col,
        text.cex = nclones.cex,
        text.position = nclones.pos,
        text.offset = nclones.offset,
        height = 4,
        width = 6
        )
    };

### PLOT ##########################################################################################
# do either sr or mr plot
setwd(args$output);
if (args$mode == 'sr') {
    plot.sr(subclones.data.toplot)
    print('plotting sr')
} else {
    plot.mr(subclones.data.toplot)
    print('plotting mr')
    };
