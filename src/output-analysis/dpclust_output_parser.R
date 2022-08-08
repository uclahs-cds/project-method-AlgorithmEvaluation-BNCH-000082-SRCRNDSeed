### PARSER ########################################################################################
# Extract Strelka2-Battenberg-DPClust output from ss 14 head and neck samples across 10 seeds.

### PREAMBLE ######################################################################################
# Input directory stem to all pipeline output files
input.dir.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src'
input.pipeline <- '/run-strelka2-battenberg-dpclust/output/pipeline-call-SRC-1.0.0-rc.1/%s/DPClust-75f5d7e/output'
input.file <- '/%s_DPoutput_2000iters_1000burnin_seed%s/%s_2000iters_1000burnin_bestClusterInfo.txt'

# Output directory
output.dir.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/'
output.pipeline <- 'pipeline-call-src/run-strelka2-battenberg-dpclust/output/'
output.file <- 'dpclust_subclones_per_patient_seed.tsv'
output.file.cluster <- 'dpclust_snv_ccf_per_cluster.tsv'

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
### CODE #########################################################################################
# Get all output paths (Anna)
all.paths <- list();
for (i in 1:length(samples)){
    all.paths[i] <- list(rep(NA, length(seeds)))
    };

for (sample in 1:length(samples)) {
    for (seed in 1:length(seeds)) {
        path <- sprintf(
            fmt = paste0(input.dir.stem, input.pipeline, input.file),
            samples[sample],
            samples[sample],
            seeds[seed],
            samples[sample]
        )
        all.paths[[sample]][seed] <- path
        };
    };

### get.patient.seed.summary ######################################################################
# Get summary data per patient file without creating lists of tables
get.patient.seed.summary <- function(file.path) {
    # read in file
    table <- read.table(
        file = file.path,
        sep = '\t',
        header = TRUE
        );
    file.name <- strsplit(file.path, '/')[[1]][14]
    seed <- strsplit(file.name, 'seed')[[1]][2]
    sample <- strsplit(file.name, '_')[[1]][1]
    patient <- strsplit(sample, '-')[[1]][1]
    subclones <- nrow(table)
    sample.summary <- list(patient, seed, subclones)
    return(sample.summary)
    };

### write.table ###################################################################################
# Add patient vs. seed summary data to summary table
all.samples.summary <- data.frame();
for (paths in all.paths) {
    for (path in paths) {
        all.samples.summary <- rbind(all.samples.summary, get.patient.seed.summary(path))
        };
    };
colnames(all.samples.summary) <- c('patient', 'seed', 'n_clones');
write.table(
    x = all.samples.summary,
    file = paste0(output.dir.stem, output.pipeline, Sys.Date(), '_', output.file),
    sep = '\t',
    row.names = FALSE,
    quote = FALSE
    );

### get.ccf.sv.summary ############################################################################
# Get summary data of cluster (ccf and number of snvs) per patient file
get.ccf.sv.summary <- function(file.path) {
    # read in file
    table <- read.table(
        file = file.path,
        sep = '\t',
        header = TRUE
        );
    file.name <- strsplit(file.path, '/')[[1]][14]
    seed <- strsplit(file.name, 'seed')[[1]][2]
    sample <- strsplit(file.name, '_')[[1]][1]
    patient <- strsplit(sample, '-')[[1]][1]
    
    # add metadata to table
    table$seed <- rep(seed, nrow(table))
    table$patient <- rep(patient, nrow(table))
    return(table)
    };

### write.table ###################################################################################
# Add ccf and sv summary data to summary table
all.ccf.sv.summary <- data.frame();
    for (paths in all.paths) {
        for (path in paths) {
          all.ccf.sv.summary <- rbind(all.ccf.sv.summary, get.ccf.sv.summary(path))
        };
    };

write.table(
    x = all.samples.summary,
    file = paste0(output.dir.stem, output.pipeline, Sys.Date(), '_', output.file.cluster),
    sep = '\t',
    row.names = FALSE,
    quote = FALSE
    );

