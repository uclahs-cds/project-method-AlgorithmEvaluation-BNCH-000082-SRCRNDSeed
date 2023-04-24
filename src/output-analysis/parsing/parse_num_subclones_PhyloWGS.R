### subclones_PhyloWGS.R ##########################################################################
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
parser$add_argument('-j', '--json', type = 'character', 'help = path to json zip');
parser$add_argument('-s', '--summ', type = 'character', help = 'path to summ json file');
parser$add_argument('-m', '--muts', type = 'character', help = 'path to muts json file');
parser$add_argument('-o', '--outd', type = 'character', help = 'path to output directory');
args <- parser$parse_args();

### TREE DATA #####################################################################################
summ <- fromJSON(paste(readLines(args$summ), collapse = ''));
sample <- summ$dataset_name;
names <- names(summ$trees);
sample; #sample name

# Get sample seed
get.seed <- function(path) {
    f.dirs <- strsplit(path, '/')[[1]]
    f.name <- f.dirs[length(f.dirs)]
    f.seed <- strsplit(f.name, '_')[[1]][2]
    return(f.seed)
    };
seed <- get.seed(args$json);
seed;

# extract all of the trees
trees <- summ$trees;

### BEST TREE #####################################################################################
# get the best tree (smallest negative log likelihood)
get.llh <- function(s) {
    as.numeric(s['llh'])
    };
llhs <- sapply(trees,get.llh);
max <- match(max(llhs), llhs);
best <- names[[max]];
best; #best index
tree <- summ$trees[[best]];
#best tree
tree;

### FIX NODES #####################################################################################
heapify <- function(t) {
    s <- t$structure
    p <- t$populations
    parents <- list()
    min.val <- 1
    max.val <- max(unlist(s))
    # fix node numbering in increasing order, left to right, top to bottom
    for (l in as.character(seq(0,max.val - 1))) {
        print(paste0('Node: ', l))
        if (is.null(s[[l]])) {
            next
            }
        children <- s[[l]]
        print('Node children:')
        print(children)
        children.new <- c()
        for (child in sort(children)) {
            print(paste0('Positioning node ', child))
            if (child %in% children.new) {
                print(paste0('Node child ', child, ' is already repositioned. Skipping...'))
                next
                }
            child.new <- child
            if (child > min.val) {
                # reduce this child to min.val
                child.new <- min.val
                child.idx <- match(as.character(child), names(p))
                min.val.idx <- match(as.character(min.val), names(p))
                print(paste0('Populations rename child: ', names(p)[child.idx], ' to ', min.val))
                print(paste0('Populations rename min.val: ', names(p)[min.val.idx], ' to ', child))
                names(p)[child.idx] <- min.val
                names(p)[min.val.idx] <- child
                # change parent node names
                child.idx <- match(as.character(child), names(s))
                min.val.idx <- match(as.character(min.val), names(s))
                if (!is.na(child.idx)) {
                    print(paste0('Structure rename child: ', names(s)[child.idx], ' to ', min.val))
                    names(s)[child.idx] <- min.val
                    }
                if (!is.na(min.val.idx)) {
                    print(paste0('Structure rename min.val: ', names(s)[min.val.idx], ' to ', child))
                    names(s)[min.val.idx] <- child
                    }
                #				print('Structure before change children')
                #				print(s)
                # change children node names
                for (l1 in as.character(seq(as.numeric(l),max.val - 1 ))) {
                    if (is.null(s[[l1]])) {
                        next
                        }
                        children <- s[[l1]]
                        #					print('Before setting new children:')
                        #					print(children)
                        #					print(paste0('Min.val: ', min.val))
                        min.val.idx <- match(as.character(min.val), children)
                        child.idx <- match(as.character(child), children)
                        if (!is.na(min.val.idx)) {
                            children[min.val.idx] <- child
                            }
                        if (!is.na(child.idx)) {
                            children[child.idx] <- min.val
                            }
                        print(paste0('Changing children of node: ', l1))
                        print(children)
                        #					print('Setting new children: ')
                        #					print(children)
                        s[[l1]] <- children
                        }
                    #				print('Structure after change children')
                    #				print(s)
              } else {
                    print('Node in good position')
                    }
              children.new <- c(children.new, child.new)
              min.val <- child.new + 1
              print(paste0('Parent of ', child.new, ':'))
              print(l)
              parents[[as.character(child.new)]] <- l
            }
            print(paste0('Children of ', l, ':'))
            print(children.new)
            s[[l]] <- children.new
        }
        t$structure <- s
        t$populations <- p
        t$parents <- parents
        t
    };

### RENAME CLUSTER #####################################################################################
renumber <- function(t) {
    s <- t$structure
    p <- t$populations
    parents <- t$parents
    min.node <- 1
    while (!is.null(s[[as.character(min.node)]])) {
        min.node <- min.node + 1
        }
    print(paste0('Starting node without children: ', min.node))
    max.val <- max(unlist(s))
    for (l in as.character(seq(0,max.val - 1 ))) {
        if (is.null(s[[l]])) {
            next
            }
        if (as.numeric(l) > min.node && parents[[l]] == parents[[as.character(min.node)]] ) {
            print(paste0('Switching branches from ', l, ' to ', min.node))
            s[[as.character(min.node)]] <- s[[l]]
            s[[match(l, names(s))]] <- NULL
            print(paste0('Switching populations from ', l, ' to ', min.node))
            min.node.idx <- match(as.character(min.node), names(p))
            l.idx <- match(as.character(l), names(p))
            print(names(p))
            print(min.node.idx)
            print(l.idx)
            names(p)[[min.node.idx]] <- l
            names(p)[[l.idx]] <- min.node
            print(names(p))
            while (!is.null(s[[as.character(min.node)]])) {
                min.node <- min.node + 1
                }
            print(paste0('Next node without children: ', min.node))
            }
        }
        t$structure <- s
        t$populations <- p
        t$parents <- parents
        t
    };

tree <- renumber(heapify(tree));
node.map <- names(tree$populations)[-1];


#### SAVE STRUCTURE BEST TREE ###########################################################
clist <- list();
chil <- function(c) {
    tree$populations[[as.character(c)]]
    };
stru <- function(t) {
    layers <- names(t$structure)
    print(layers)
    for (l in layers) {
        children <- (t$structure[[l]])
        cc <- sapply(children, chil)
        cc <- t(cc)
        cc <- data.frame(cc)
        cc$parent <- l
        cc$child <- children
        clist[[l]] <- cc
        }
    clist
    };
clist <- stru(tree);
structure <- do.call(rbind, clist);
structure <- data.frame(structure[,c('parent', 'child', 'num_ssms', 'num_cnvs', 'cellular_prevalence')]);
my.df <- data.frame(lapply(structure, as.character), stringsAsFactors = FALSE);

### NUM SUBCLONES DF ##############################################################################
num.subclones <- nrow(my.df);
num.subclones;

write(
    paste(sample, seed, num.subclones, sep = '\t'),
    file = paste0(args$outd, Sys.Date(), '_', sample, '_num_subclones_strelka2_battenberg_pyloWGS_sr.tsv'),
    append = TRUE
    );
