#### supplementary_table_stats.R ##################################################################
# Creates all supplementary tables and write them into one excel sheet
# Calculates all statistics referenced in the results section

#### Preamble #####################################################################################
library(data.table);
library(tidyverse);
library(dplyr);
library(xlsx);

#### Read in raw data #################################################################################
# setwd('/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/supplementary_tables/');
setwd('/Users/philippasteinberg/Desktop/Research/BoutrosLab/supplementary_tables/');

# PyClone-VI
mutect2.battenberg.pyclone.vi.mr <- read.table('./2023-04-02_num_subclones_mutect2_battenberg_pyclone-vi_mr.tsv', header = TRUE);
strelka2.battenberg.pyclone.vi.mr <- read.table('./2023-04-02_num_subclones_strelka2_battenberg_pyclone-vi_mr.tsv', header = TRUE);
somaticsniper.battenberg.pyclone.vi.mr <- read.table('./2023-04-02_num_subclones_somaticsniper_battenberg_pyclone-vi_mr.tsv', header = TRUE);
mutect2.battenberg.pyclone.vi.sr <- read.table('./2023-04-02_num_subclones_mutect2_battenberg_pyclone-vi_sr.tsv', header = TRUE);
strelka2.battenberg.pyclone.vi.sr <- read.table('./2023-04-02_num_subclones_strelka2_battenberg_pyclone-vi_sr.tsv', header = TRUE);
somaticsniper.battenberg.pyclone.vi.sr <- read.table('./2023-04-02_num_subclones_somaticsniper_battenberg_pyclone-vi_sr.tsv', header = TRUE);

# DPClust
mutect2.battenberg.dpclust.sr <- read.table('./2023-04-02_num_subclones_mutect2_battenberg_dpclust_sr.tsv', header = TRUE);
strelka2.battenberg.dpclust.sr <- read.table('./2023-04-20_num_subclones_strelka2_battenberg_dpclust_sr.tsv', header = TRUE);
somaticsniper.battenberg.dpclust.sr <- read.table('./2023-04-20_num_subclones_somaticsniper_battenberg_dpclust_sr.tsv', header = TRUE);

# PhyloWGS
mutect2.battenberg.phylowgs.sr <- read.table('./2023-05-01_num_subclones_mutect2_battenberg_phylowgs_sr.tsv', header = TRUE);
strelka2.battenberg.phylowgs.sr <- read.table('./2023-05-01_num_subclones_strelka2_battenberg_phylowgs_sr.tsv', header = TRUE);
somaticsniper.battenberg.phylowgs.sr <- read.table('./2023-05-09_num_subclones_somaticsniper_battenberg_phylowgs_sr.tsv', header = TRUE);

#### Table1_NumberOfSubclones #####################################################################
# Add pipeline name to data frame
mutect2.battenberg.pyclone.vi.mr$pipeline <- 'Mutect2-Battenberg-PyClone-VI-mr';
strelka2.battenberg.pyclone.vi.mr$pipeline <- 'Strelka2-Battenberg-PyClone-VI-mr';
somaticsniper.battenberg.pyclone.vi.mr$pipeline <- 'SomaticSniper-Battenberg-PyClone-VI-mr';
mutect2.battenberg.pyclone.vi.sr$pipeline <- 'Mutect2-Battenberg-PyClone-VI-sr';
somaticsniper.battenberg.pyclone.vi.sr$pipeline <- 'SomaticSniper-Battenberg-PyClone-VI-sr';
strelka2.battenberg.pyclone.vi.sr$pipeline <- 'Strelka2-Battenberg-PyClone-VI-sr';
mutect2.battenberg.dpclust.sr$pipeline <- 'Mutect2-Battenberg-DPClust-sr';
strelka2.battenberg.dpclust.sr$pipeline <- 'Strelka2-Battenberg-DPClust-sr';
somaticsniper.battenberg.dpclust.sr$pipeline <- 'SomaticSniper-Battenberg-DPClust-sr';
mutect2.battenberg.phylowgs.sr$pipeline <- 'Mutect2-Battenberg-PhyloWGS-sr';
strelka2.battenberg.phylowgs.sr$pipeline <- 'Strelka2-Battenberg-PhyloWGS-sr';
somaticsniper.battenberg.phylowgs.sr$pipeline <- 'SomaticSniper-Battenberg-PhyloWGS-sr';

number.of.subclones <- rbind(
    mutect2.battenberg.pyclone.vi.mr,
    strelka2.battenberg.pyclone.vi.mr,
    somaticsniper.battenberg.pyclone.vi.mr,
    mutect2.battenberg.pyclone.vi.sr,
    strelka2.battenberg.pyclone.vi.sr,
    somaticsniper.battenberg.pyclone.vi.sr,
    mutect2.battenberg.dpclust.sr,
    strelka2.battenberg.dpclust.sr,
    somaticsniper.battenberg.dpclust.sr,
    mutect2.battenberg.phylowgs.sr,
    strelka2.battenberg.phylowgs.sr,
    somaticsniper.battenberg.phylowgs.sr
    );

# Average number of subclones by pipeline
pipe.ave <- aggregate(number.of.subclones$n_clones, by = list(number.of.subclones$pipeline), FUN = mean);

#### sSNV-Callers #################################################################################
mutect2 <- rbind(
    mutect2.battenberg.pyclone.vi.mr,
    mutect2.battenberg.pyclone.vi.sr,
    mutect2.battenberg.dpclust.sr,
    strelka2.battenberg.phylowgs.sr
    );

strelka2 <- rbind(
    strelka2.battenberg.pyclone.vi.mr,
    strelka2.battenberg.pyclone.vi.sr,
    strelka2.battenberg.dpclust.sr,
    strelka2.battenberg.phylowgs.sr
    );

somaticsniper <- rbind(
    somaticsniper.battenberg.pyclone.vi.mr,
    somaticsniper.battenberg.pyclone.vi.sr,
    somaticsniper.battenberg.dpclust.sr,
    somaticsniper.battenberg.phylowgs.sr
    );

# Average number of subclones across patients and across src algorithms
mut.ave <- mean(mutect2$n_clones);        # 2.503185
str.ave <- mean(strelka2$n_clones);       # 2.664544
som.ave <- mean(somaticsniper$n_clones);  # 2.451745

#### PyClone-VI ###################################################################################
pyclone.vi.sr <- rbind(
    mutect2.battenberg.pyclone.vi.sr,
    strelka2.battenberg.pyclone.vi.sr,
    somaticsniper.battenberg.pyclone.vi.sr
    );

pyclone.vi.mr <- rbind(
    mutect2.battenberg.pyclone.vi.mr,
    strelka2.battenberg.pyclone.vi.mr,
    somaticsniper.battenberg.pyclone.vi.mr
    );

# PyClone-VI average number of subclones across patients and across SNV callers
pyc.sr.ave <- mean(pyclone.vi.sr$n_clones); # 2.307143
pyc.mr.ave <- mean(pyclone.vi.mr$n_clones); # 1.942857

# PyClone-VI results stats across seeds, per patient and per SNV caller
pyclone.vi.sr.pipeline <- setDT(pyclone.vi.sr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# PyClone-VI-sr number of subclones across patients and per SNV caller
pyclone.vi.sr.stats <- setDT(pyclone.vi.sr.pipeline)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = mean(sd)
        ),
    by = list(pipeline)
    ];

# PyClone-VI-sr average IQR 0.2797619, average sd 0.3375707
pyc.sr.ave.iqr <- list(
    'PyClone-VI-sr',
    mean(pyclone.vi.sr.stats$mean_IQR),
    mean(pyclone.vi.sr.stats$mean_sd)
    );
pyclone.vi.sr.stats <- rbind(pyclone.vi.sr.stats, pyc.sr.ave.iqr);

# PyClone-VI-mr number of subclones across patients and per SNV caller
pyclone.vi.mr.pipeline <- setDT(pyclone.vi.mr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

pyclone.vi.mr.stats <- setDT(pyclone.vi.mr.pipeline)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = mean(sd)
        ),
    by = list(pipeline)
    ];

# PyClone-VI-mr average IQR 0.1666667, average sd 0.2172008
pyc.mr.ave.iqr <- list(
    'PyClone-VI-mr',
    mean(pyclone.vi.mr.stats$mean_IQR),
    mean(pyclone.vi.mr.stats$mean_sd)
    );
pyclone.vi.mr.stats <- rbind(pyclone.vi.mr.stats, pyc.mr.ave.iqr);

# PyClone-VI average IQR of patient with high subclone count (85th quantile)
quantile(pyclone.vi.sr.pipeline$median, 0.85); # high median is a subclone count above 3.85
quantile(pyclone.vi.mr.pipeline$median, 0.85); # high median is a subclone count above 3
pyc.sr.sub.iqr <- mean(pyclone.vi.sr.pipeline[pyclone.vi.sr.pipeline$median < 3.85, ]$IQR);   # 0.1642857
pyc.sr.abo.iqr <- mean(pyclone.vi.sr.pipeline[pyclone.vi.sr.pipeline$median >= 3.85, ]$IQR);  # 0.8571429
pyc.mr.sub.iqr <- mean(pyclone.vi.mr.pipeline[pyclone.vi.mr.pipeline$median < 3, ]$IQR);      # 0
pyc.mr.abo.iqr <- mean(pyclone.vi.mr.pipeline[pyclone.vi.mr.pipeline$median >= 3, ]$IQR);     # 0.5

#### DPClust ######################################################################################
dpclust <- rbind(
    mutect2.battenberg.dpclust.sr,
    strelka2.battenberg.dpclust.sr,
    somaticsniper.battenberg.dpclust.sr
    );

# DPClust average number of subclones across patients and across SNV callers
dpc.ave <- mean(dpclust$n_clones); # 3.728571

# DPClust results stats across seeds, per patient and per SNV caller
dpclust.pipeline <- setDT(dpclust)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# DPClust average IQR, and average sd across patients and per SNV caller
dpclust.stats <- setDT(dpclust.pipeline)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = mean(sd)
        ),
    by = list(pipeline)
    ];

# DPClust average IQR 0.3214286, average sd 0.3154659
dpc.ave.iqr <- list(
    'DPClust-sr',
    mean(dpclust.stats$mean_IQR),
    mean(dpclust.stats$mean_sd)
    );
dpclust.stats <- rbind(dpclust.stats, dpc.ave.iqr);

# DPCLust average IQR of patient with high subclone count (85th quantile)
quantile(dpclust.pipeline$median, 0.85); # high median is a subclone count above 5
dpc.sub.iqr <- mean(dpclust.pipeline[dpclust.pipeline$median < 5, ]$IQR);   # 0.2115385
dpc.abo.iqr <- mean(dpclust.pipeline[dpclust.pipeline$median >= 5, ]$IQR);  # 0.5

#### PhyloWGS #####################################################################################
phylowgs <- rbind(
    mutect2.battenberg.phylowgs.sr,
    strelka2.battenberg.phylowgs.sr,
    somaticsniper.battenberg.phylowgs.sr
    );

## Statistical evaluation
# PhyloWGS average number of subclones across patients and across SNV callers
wgs.ave <- mean(phylowgs$n_clones); # 1.957447

# PhyloWGS results stats across seeds per patient and per SNV caller
phylowgs.pipeline <- setDT(phylowgs)[,
    list(
        median = as.numeric(median(n_clones), na.rm = TRUE),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# PhyloWGS average IQR, and average sd across patients and per SNV caller
phylowgs.stats <- setDT(phylowgs.pipeline)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = mean(sd)
        ),
    by = list(pipeline)
    ];

# PhyloWGS average IQR 0.3095238, average sd 0.3348823
wgs.ave.iqr <- list(
    'PhyloWGS-sr',
    mean(phylowgs.stats$mean_IQR),
    mean(phylowgs.stats$mean_sd)
    );
phylowgs.stats <- rbind(phylowgs.stats, wgs.ave.iqr);

# PhyloWGS average IQR of patient with high subclone count (85th quantile)
quantile(phylowgs.pipeline$median, 0.85); # high median is a subclone count above 3
wgs.sub.iqr <- mean(phylowgs.pipeline[phylowgs.pipeline$median < 3, ]$IQR);   # 0.2727273
wgs.abo.iqr <- mean(phylowgs.pipeline[phylowgs.pipeline$median >= 3, ]$IQR);  # 0.4444444

#### Table2_StatsByPatient ########################################################################
# Subclone count stats by patient and per SRC algorithm and SNV caller pairing
stats.by.pipeline <- rbind(
    pyclone.vi.sr.pipeline,
    pyclone.vi.mr.pipeline,
    dpclust.pipeline,
    phylowgs.pipeline
    );

#### RandomSeed_stats.txt #########################################################################
# Average IQR per SRC algorithm
stats.analysis <- rbind(
    pyclone.vi.sr.stats,
    pyclone.vi.mr.stats,
    dpclust.stats,
    phylowgs.stats
    );

#### Seed Failure Rates ###########################################################################
# Average per patient failure across the three PhyloWGS pipelines
num.seeds <- length(unique(phylowgs$seed));
num.patients <- length(unique(phylowgs$patient));
num.pipelines <- length(unique(phylowgs$pipeline));

# PhyloWGS patient failure rates across pipelines (RandomSeed-stats.txt)
wgs.fail.patient <- count(phylowgs, patient);
wgs.fail.rates <- 1 - wgs.fail.patient$n / (num.seeds * num.pipelines);

# PhyloWGS seed failure rates across pipelines (RandomSeed-stats.txt)
wgs.fail.seed <- count(phylowgs, seed);
wgs.fail.seed.rates <- 1 - wgs.fail.seed$n / (num.patients * num.pipelines);

# overall failure rate of 89.5%
# probability of a seed failing ~10.5%
# binomial test to find out at which point we would think the seed "fails more than expected by chance"
# binom.test(105, 1000, alternative = 'greater', 0.05);
N <- 105:1000
names(N) <- 105:1000
prb <- unlist(lapply(
    N,
    function(x) {
        sum(dbinom(105:x, x, 0.895))
        }
    ));
prb[prb <= 0.05]
prb # 111

# P-values of seed/patient failure rates with a p(failure) = 0.105
# x failures, n trials, with p hypothesized probability of failure
binom.test(238, 1000, p = 0.105,
           alternative = 'greater',
           conf.level = 0.95) # 2.2e-16
binom.test(214, 1000, p = 0.105,
           alternative = 'greater',
           conf.level = 0.95) # 2.2e-16
binom.test(167, 1000, p = 0.105,
           alternative = 'greater',
           conf.level = 0.95) # 1.653e-09
binom.test(143, 1000, p = 0.105,
           alternative = 'greater',
           conf.level = 0.95) # 0.000106

# Count the number of pipelines that were successful per seed patient pair
test <- count(phylowgs, seed, patient);
test.rates <- aggregate(test$n, by = list(test$patient, test$seed), FUN = min);

# Patient seed pairs which only succeed for 1 pipeline
# 13142, P04
# 13142, P09
# 13142, P14
# 50135, P04
# 50135, P09
# 51404, P09
# 97782, P09
# 253505, P09
# 628019, P09
# 628019, P14
# 659767, P04

# Patient seed pairs which only succeed for 2 pipelines
# 13142, P12
# 50135, P03
# 50135, P07
# 51404, P04
# 51404, P13
# 97782, P04
# 253505, P04
# 253505, P14
# 628019, P06
# 628019, P07
# 628019, P08
# 628019, P10
# 659767, P14
# 838004, P03

#### Figure 3 Evaluation ##########################################################################
# Mode function
get.mode <- function(s) {
    uniq <- unique(s)
    uniq[which.max(tabulate(match(s, uniq)))]
    };

# function to see if patient gets the mode
patient.get.mode <- function(pipeline) {
    pipeline.mode <- setDT(pipeline)[,list(mode = get.mode(n_clones), gets_mode = sum(n_clones == get.mode(n_clones))), by = list(patient)];
    gets.mode <- sum(pipeline.mode$gets_mode)
    print(gets.mode)
    return(round((gets.mode / nrow(pipeline)) * 100, 1))
    };

# function to see if seed gets the mode across all patients per pipeline
seed.get.mode <- function(pipeline) {
    pipeline.mode <- setDT(pipeline)[,list(seed = seed, mode = get.mode(n_clones), gets_mode = n_clones == get.mode(n_clones)), by = list(pipeline, patient)];
    seed.mode <- aggregate(gets_mode ~ seed, pipeline.mode, function(x) sum(x == TRUE))
    seed.mode$`ratio(%)` <- round(seed.mode$gets_mode / length(unique(pipeline$patient)) * 100, 1)
    seed.mode$`pipeline` <- unique(pipeline$pipeline)
    return(seed.mode)
    };

# Stats of how many patient + seed combinations got the mode subclone count of the patient (RandomSeed_stats.txt)
patient.get.mode(pyclone.vi.sr);                           # 276/420 => 65.7%
patient.get.mode(pyclone.vi.mr);                           # 157/210 => 74.8%
patient.get.mode(mutect2.battenberg.pyclone.vi.sr);        # 107/140 => 76.4%
patient.get.mode(mutect2.battenberg.pyclone.vi.mr);        # 62/70   => 88.6%
patient.get.mode(strelka2.battenberg.pyclone.vi.sr);       # 111/140 => 79.3%
patient.get.mode(strelka2.battenberg.pyclone.vi.mr);       # 58/70   => 82.9%
patient.get.mode(somaticsniper.battenberg.pyclone.vi.sr);  # 128/140 => 91.4%
patient.get.mode(somaticsniper.battenberg.pyclone.vi.mr);  # 66/70   => 94.3%

patient.get.mode(dpclust);                                 # 230/420 => 54.8%
patient.get.mode(mutect2.battenberg.dpclust.sr);           # 125/140 => 89.3%
patient.get.mode(strelka2.battenberg.dpclust.sr);          # 106/140 => 75.7%
patient.get.mode(somaticsniper.battenberg.dpclust.sr);     # 111/140 => 79.3%

patient.get.mode(phylowgs);                                # 198/376 => 52.7%
patient.get.mode(mutect2.battenberg.phylowgs.sr);          # 90/118  => 76.3%
patient.get.mode(strelka2.battenberg.phylowgs.sr);         # 96/121  => 79.3%
patient.get.mode(somaticsniper.battenberg.phylowgs.sr);    # 113/137 => 82.5%

# Stats of how many seeds get the mode subclone count across patients per pipeline
stats.by.seed <- rbind(
    seed.get.mode(mutect2.battenberg.pyclone.vi.sr),
    seed.get.mode(strelka2.battenberg.pyclone.vi.sr),
    seed.get.mode(somaticsniper.battenberg.pyclone.vi.sr),
    seed.get.mode(mutect2.battenberg.pyclone.vi.mr),
    seed.get.mode(strelka2.battenberg.pyclone.vi.mr),
    seed.get.mode(somaticsniper.battenberg.pyclone.vi.mr),
    seed.get.mode(mutect2.battenberg.dpclust.sr),
    seed.get.mode(strelka2.battenberg.dpclust.sr),
    seed.get.mode(somaticsniper.battenberg.dpclust.sr),
    seed.get.mode(mutect2.battenberg.phylowgs.sr),
    seed.get.mode(strelka2.battenberg.phylowgs.sr),
    seed.get.mode(somaticsniper.battenberg.phylowgs.sr)
    );

# Average rate that seed gets mode number of subclones by SRC algorithm and across sSNV
pyc.sr.seed <- stats.by.seed[grepl('PyClone-VI-sr', stats.by.seed$pipeline), ];
pyc.sr.seed.mean <- aggregate(`ratio(%)` ~ seed, pyc.sr.seed, function(x) mean(x));
pyc.mr.seed <- stats.by.seed[grepl('PyClone-VI-mr', stats.by.seed$pipeline), ];
pyc.mr.seed.mean <- aggregate(`ratio(%)` ~ seed, pyc.mr.seed, FUN = mean);
dpc.seed <- stats.by.seed[grepl('DPClust-sr', stats.by.seed$pipeline), ];
dpc.seed.mean <- aggregate(`ratio(%)` ~ seed, dpc.seed, FUN = mean);
wgs.seed <- stats.by.seed[grepl('PhyloWGS-sr', stats.by.seed$pipeline), ];
wgs.seed.mean <- aggregate(`ratio(%)` ~ seed, wgs.seed, FUN = mean);
seed.mean <- aggregate(`ratio(%)` ~ seed, pyc.sr.seed, FUN = mean);

# Pipelines with seeds that are consistent across all samples (RandomSeed_stats.txt)
# mutect2.battenberg.pyclone.vi.sr          838004
# mutect2.battenberg.pyclone.vi.mr          13142, 97782, 366306, 659767
# strelka2.battenberg.pyclone.vi.mr         13142, 423647
# somaticsniper.battenberg.pyclone.vi.sr    51404, 366306, 423647
# somaticsniper.battenberg.pyclone.vi.mr    51404, 253505, 366306, 423647, 628019, 838004
# mutect2.battenberg.dpclust.sr             50135
# somaticsniper.battenberg.dpclust.sr       50135

# Ranking of seed which consistently calls the mode for a pipeline (RandomSeed_stats.txt)
# 366306  (3x)
# 423647  (3x)
# 838004  (2x)
# 13142   (2x)
# 51404   (2x)
# 50135   (2x)
# 253505  (1x)
# 628019  (1x)
# 97782   (1x)
# 659767  (1x)

# Ranking of pipelines with the most seeds which consistently call the mode across all patients (RandomSeed_stats.txt)
# somaticsniper.battenberg.pyclone.vi.mr  (6x)
# mutect2.battenberg.pyclone.vi.mr        (4x)
# somaticsniper.battenberg.pyclone.vi.sr  (3x)
# strelka2.battenberg.pyclone.vi.mr       (2x)
# mutect2.battenberg.pyclone.vi.sr        (1x)
# mutect2.battenberg.dpclust.sr           (1x)
# somaticsniper.battenberg.dpclust.sr     (1x)

#### RandomSeed_SupplementaryData.xlsx ############################################################
write.xlsx(
    number.of.subclones,
    file = 'RandomSeed_SupplementaryTables.xlsx',
    sheetName = 'Table1_NumberOfSubclones',
    col.names = TRUE, row.names = FALSE, append = TRUE
    );

write.xlsx(
    stats.by.pipeline,
    file = 'RandomSeed_SupplementaryTables.xlsx',
    sheetName = 'Table2_StatsByPipeline',
    col.names = TRUE, row.names = FALSE, append = TRUE
    );

write.xlsx(
    stats.by.seed,
    file = 'RandomSeed_SupplementaryTables.xlsx',
    sheetName = 'Table3_StatsBySeed',
    col.names = TRUE, row.names = FALSE, append = TRUE
    );
