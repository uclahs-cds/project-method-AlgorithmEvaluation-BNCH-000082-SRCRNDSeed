### PARSER ########################################################################################
# Extract Strelka2-Battenberg-PyClone-VI output from 14 head and neck samples across 10 seeds.

### PREAMBLE ######################################################################################
# 10 random seeds and 14 primary tumour sample data.
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

samples <- c(
    'ILHNLNEV000001-T001-P01-F',
    'ILHNLNEV000002-T001-P01-F',
    'ILHNLNEV000003-T001-P01-F',
    'ILHNLNEV000004-T001-P01-F',
    'ILHNLNEV000005-T001-P01-F',
    'ILHNLNEV000006-T001-P01-F',
    'ILHNLNEV000007-T001-P01-F',
    'ILHNLNEV000008-T001-P01-F',
    'ILHNLNEV000009-T001-P01-F',
    'ILHNLNEV000010-T001-P01-F',
    'ILHNLNEV000011-T001-P01-F',
    'ILHNLNEV000012-T001-P01-F',
    'ILHNLNEV000013-T001-P01-F',
    'ILHNLNEV000014-T001-P01-F'
    );

### Function_1 ####################################################################################
# Get all output paths (Referencing Anna's code)
all.paths <- list();
for (i in 1:length(samples)){
    all.paths[i] <- list(rep(NA, length(seeds)))
    };

for (sample in 1:length(samples)) {
    for (seed in 1:length(seeds)) {
        path <- sprintf(
            fmt = '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-strelka2-battenberg-pyclone-vi/output/pipeline-call-SRC-1.0.0-rc.1/%s/PyClone-VI-0.1.2/output/PyClone-VI-0.1.2_%s_%s_Strelka2-Battenberg.tsv',
            seeds[seed],
            samples[sample]
        )
        all.paths[[sample]][seed] <- path
        };
    };

### Function_2 ####################################################################################
# Get summary data per patient file without creating lists of tables
get.patient.seed.summary <- function(file.path) {
    # read in file
    table <- read.table(
        file = file.path,
        sep = '\t',
        header = TRUE
        );
    # get metadata
    seed <- strsplit(file_path, '_')[[1]][2]
    sample <- strsplit(file_path, '_')[[1]][3]
    patient <- strsplit(sample, '-')[[1]][1]
    # get number of subclones
    subclones <- length(unique(table$cluster_id))
    # make summary list
    sample.summary <- list(patient, seed, subclones)
    return(sample.summary)
    };

### Function_3 ####################################################################################
# Add patient vs. seed summary data to summary table
all.samples.summary <- data.frame();
for (paths in all.paths) {
    for (path in paths) {
        all.samples.summary <- rbind(all.samples.summary, get.patient.seed.summary(path))
        };
    };

# Add column names and save output table
colnames(all.samples.summary) <- c('patient', 'seed', 'n_clones');
write.table(
    x = all.samples.summary,
    file = 'test_summary_table.tsv',
    quote = FALSE,
    sep = '\t'
    );
