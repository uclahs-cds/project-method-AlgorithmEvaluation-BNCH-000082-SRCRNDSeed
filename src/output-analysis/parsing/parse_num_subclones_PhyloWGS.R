### parse_num_subclones_PhyloWGS.R ################################################################
# Get number of sublcones from PhyloWGS output
###################################################################################################
options(error = function() traceback(2))

### PREAMBLE ######################################################################################
# load libraries
# install.packages('argparse');
# install.packages('rjson');
# install.packages('R.utils');
library(argparse);
library(rjson);
library(R.utils);
library(dplyr);
library(plyr);

# general parameters
date <- Sys.Date();

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-t', '--tree', type = 'character', help = 'path to consensus tree txt file');
parser$add_argument('-o', '--outd', type = 'character', help = 'path to output directory');
args <- parser$parse_args();

### PROCESS DATA ##################################################################################
tree.df <- read.table(file = args$tree, sep = '\t', header = TRUE);
tree.df;

# get sample name
get.sample <- function(path) {
    f.dirs <- strsplit(path, '/')[[1]]
    f.name <- f.dirs[length(f.dirs)]
    f.seed <- strsplit(f.name, '_')[[1]][1]
    };
sample <- get.sample(args$tree);
sample;

# get sample seed
get.seed <- function(path) {
    f.dirs <- strsplit(path, '/')[[1]]
    f.name <- f.dirs[length(f.dirs)]
    f.seed <- strsplit(f.name, '_')[[1]][2]
    return(f.seed)
    };
seed <- get.seed(args$tree);
seed;

# get sample number of subclones
num.subclones <- nrow(tree.df);
num.subclones;

#### WRITE OUTPUT FILE ####################################################################
write(
    paste(sample, seed, num.subclones, sep = '\t'),
    file = paste0(args$outd, Sys.Date(), '_num_subclones_strelka2_battenberg_pylowgs_sr.tsv'),
    append = TRUE
    );
