### parse_num_subclones_PhyloWGS.R ################################################################
# Get number of sublcones from PhyloWGS output
###################################################################################################
options(error = function() traceback(2))

### PREAMBLE ######################################################################################
# load libraries
library(argparse);
library(rjson);
library(R.utils);
library(dplyr);
library(plyr);

# general parameters
date <- Sys.Date();

### OBTAIN COMMAND LINE ARGUMENTS #################################################################
parser <- ArgumentParser();
parser$add_argument('-i', '--input', type = 'character', help = 'path to consensus tree file directory');
parser$add_argument('-o', '--output', type = 'character', help = 'path to output directory');
parser$add_argument('-p', '--pipeline', type = 'character', help = 'pipeline combination snv-cna-phylowgs-mode');
args <- parser$parse_args();

### PROCESS DATA ##################################################################################
# read in all consensus tree files for input pipeline
setwd(args$input);
tree.files <- list.files(pattern = '*.txt');
subclones.df <- data.frame(patient = character(), seed = character(), n_clones = integer());

# extract sample name, seed and number of subclones per consensus tree file
for (file in tree.files) {
    tree.data <- read.table(file = file, sep = '\t', header = TRUE)
    sample <- strsplit(file, '_')[[1]][1]
    seed <- strsplit(file, '_')[[1]][2]
    # get the num children = rows = subclones in the text file
    num.subclones <- nrow(tree.data)
    print(num.subclones)
    # write output
    subclones.df <- rbind(
        subclones.df,
        data.frame(
            patient = sample,
            seed = seed,
            n_clones = num.subclones
            )
        )
    };
subclones.df;

#### WRITE OUTPUT FILE ####################################################################
setwd(args$output);
write.table(
    subclones.df,
    file = paste0(Sys.Date(), '_num_subclones_', args$pipeline, '.tsv'),
    sep = '\t',
    quote = FALSE,
    row.names = FALSE
    );
