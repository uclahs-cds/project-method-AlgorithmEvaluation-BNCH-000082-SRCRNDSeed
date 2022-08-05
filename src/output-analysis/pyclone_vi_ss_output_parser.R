### PARSER ########################################################################################
# Extract Strelka2-Battenberg-PyClone-VI output from 14 head and neck samples across 10 seeds.

### PREAMBLE ######################################################################################
# Input directory stem to all pipeline output files
input.dir.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/'
input.pipeline <- 'run-strelka2-battenberg-pyclone-vi/output/pipeline-call-SRC-1.0.0-rc.1/%s/PyClone-VI-0.1.2/output/'
input.file <- 'PyClone-VI-0.1.2_%s_%s_Strelka2-Battenberg.tsv'

# Output directory
output.dir.stem <- '/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/'
output.pipeline <- 'pipeline-call-src/run-strelka2-battenberg-pyclone-vi/output/'
output.file <- 'pyclone_ss_subclones_per_patient_seed.tsv'

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
    seed <- strsplit(file.path, '_')[[1]][2]
    sample <- strsplit(file.path, '_')[[1]][3]
    patient <- strsplit(sample, '-')[[1]][1]
    subclones <- length(unique(table$cluster_id))
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
    quote = FALSE,
    row.names = FALSE
    );
