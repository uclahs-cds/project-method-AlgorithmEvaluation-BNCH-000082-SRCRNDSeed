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
mutect2_battenberg_pyclone_vi_mr <- read.table('./2023-04-02_num_subclones_mutect2_battenberg_pyclone-vi_mr.tsv', header = TRUE);
strelka2_battenberg_pyclone_vi_mr <- read.table('./2023-04-02_num_subclones_strelka2_battenberg_pyclone-vi_mr.tsv', header = TRUE);
somaticsniper_battenberg_pyclone_vi_mr <- read.table('./2023-04-02_num_subclones_somaticsniper_battenberg_pyclone-vi_mr.tsv', header = TRUE);
mutect2_battenberg_pyclone_vi_sr <- read.table('./2023-04-02_num_subclones_mutect2_battenberg_pyclone-vi_sr.tsv', header = TRUE);
strelka2_battenberg_pyclone_vi_sr <- read.table('./2023-04-02_num_subclones_strelka2_battenberg_pyclone-vi_sr.tsv', header = TRUE);
somaticsniper_battenberg_pyclone_vi_sr <- read.table('./2023-04-02_num_subclones_somaticsniper_battenberg_pyclone-vi_sr.tsv', header = TRUE);

# DPClust
mutect2_battenberg_dpclust_sr <- read.table ('./2023-04-02_num_subclones_mutect2_battenberg_dpclust_sr.tsv', header = TRUE);
strelka2_battenberg_dpclust_sr <- read.table('./2023-04-20_num_subclones_strelka2_battenberg_dpclust_sr.tsv', header = TRUE);
somaticsniper_battenberg_dpclust_sr <- read.table('./2023-04-20_num_subclones_somaticsniper_battenberg_dpclust_sr.tsv', header = TRUE);

# PhyloWGS
mutect2_battenberg_phylowgs_sr <- read.table('./2023-05-01_num_subclones_mutect2_battenberg_phylowgs_sr.tsv', header = TRUE);
strelka2_battenberg_phylowgs_sr <- read.table('./2023-05-01_num_subclones_strelka2_battenberg_phylowgs_sr.tsv', header = TRUE);
somaticsniper_battenberg_phylowgs_sr <- read.table('./2023-05-09_num_subclones_somaticsniper_battenberg_phylowgs_sr.tsv', header = TRUE);

#### Table1_NumberOfSubclones #####################################################################
# add pipeline name to data frame
mutect2_battenberg_pyclone_vi_mr$pipeline <- 'Mutect2-Battenberg-PyClone-VI-mr';
strelka2_battenberg_pyclone_vi_mr$pipeline <- 'Strelka2-Battenberg-PyClone-VI-mr';
somaticsniper_battenberg_pyclone_vi_mr$pipeline <- 'SomaticSniper-Battenberg-PyClone-VI-mr';
mutect2_battenberg_pyclone_vi_sr$pipeline <- 'Mutect2-Battenberg-PyClone-VI-sr';
somaticsniper_battenberg_pyclone_vi_sr$pipeline <- 'SomaticSniper-Battenberg-PyClone-VI-sr';
strelka2_battenberg_pyclone_vi_sr$pipeline <- 'Strelka2-Battenberg-PyClone-VI-sr';
mutect2_battenberg_dpclust_sr$pipeline <- 'Mutect2-Battenberg-DPClust-sr';
strelka2_battenberg_dpclust_sr$pipeline <- 'Strelka2-Battenberg-DPClust-sr';
somaticsniper_battenberg_dpclust_sr$pipeline <- 'SomaticSniper-Battenberg-DPClust-sr';
mutect2_battenberg_phylowgs_sr$pipeline <- 'Mutect2-Battenberg-PhyloWGS-sr';
strelka2_battenberg_phylowgs_sr$pipeline <- 'Strelka2-Battenberg-PhyloWGS-sr';
somaticsniper_battenberg_phylowgs_sr$pipeline <- 'SomaticSniper-Battenberg-PhyloWGS-sr';

number.of.subclones <- rbind(
    mutect2_battenberg_pyclone_vi_mr,
    strelka2_battenberg_pyclone_vi_mr,
    somaticsniper_battenberg_pyclone_vi_mr,
    mutect2_battenberg_pyclone_vi_sr,
    strelka2_battenberg_pyclone_vi_sr,
    somaticsniper_battenberg_pyclone_vi_sr,
    mutect2_battenberg_dpclust_sr,
    strelka2_battenberg_dpclust_sr,
    somaticsniper_battenberg_dpclust_sr,
    mutect2_battenberg_phylowgs_sr,
    strelka2_battenberg_phylowgs_sr,
    somaticsniper_battenberg_phylowgs_sr
    );

#### PyClone-VI ###################################################################################
pyclone.vi.all <- rbind(
    mutect2_battenberg_pyclone_vi_sr,
    strelka2_battenberg_pyclone_vi_sr,
    somaticsniper_battenberg_pyclone_vi_sr,
    mutect2_battenberg_pyclone_vi_mr,
    strelka2_battenberg_pyclone_vi_mr,
    somaticsniper_battenberg_pyclone_vi_mr
    );

mr.patients <- c(
    'ILHNLNEV000001',
    'ILHNLNEV000002',
    'ILHNLNEV000003',
    'ILHNLNEV000006',
    'ILHNLNEV000007',
    'ILHNLNEV000012',
    'ILHNLNEV000014'
    );

# keep only patients available for sr and mr and remove suffix
pyclone.vi <- subset(pyclone.vi.all, patient %in% mr.patients);
pyclone.vi$pipeline <- str_sub(pyclone.vi$pipeline, 0, -4);

pyclone.vi.sr <- rbind(
    mutect2_battenberg_pyclone_vi_sr,
    strelka2_battenberg_pyclone_vi_sr,
    somaticsniper_battenberg_pyclone_vi_sr
    );

pyclone.vi.mr <- rbind(
    mutect2_battenberg_pyclone_vi_mr,
    strelka2_battenberg_pyclone_vi_mr,
    somaticsniper_battenberg_pyclone_vi_mr
    );

## Statistical evaluation
# PyClone-VI average number of subclones across patients and across SNV callers 
pyc.ave <- mean(pyclone.vi$n_clones);       # 2.233333
pyc.sr.ave <- mean(pyclone.vi.sr$n_clones); # 2.307143
pyc.mr.ave <- mean(pyclone.vi.mr$n_clones); # 1.942857

# PyClone-VI stats by patient and per SNV caller
pyclone.vi.patient <- setDT(pyclone.vi)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        
        ),
    by = list(patient, pipeline)
    ];

pyclone.vi.sr.patient <- setDT(pyclone.vi.sr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

pyclone.vi.mr.patient <- setDT(pyclone.vi.mr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# PyClone-VI average IQR, and average sd across patients and per SNV caller
pyclone.vi.stats <- setDT(pyclone.vi.patient)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = sd(sd)
        ),
    by = list(pipeline)
    ];

pyclone.vi.sr.stats <- setDT(pyclone.vi.sr.patient)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = sd(sd)
        ),
    by = list(pipeline)
    ];

pyclone.vi.mr.stats <- setDT(pyclone.vi.mr.patient)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = sd(sd)
        ),
    by = list(pipeline)
    ];

# PyClone-VI average IQR of patient with median < 4 (high number of) subclones
pyc.sub4.iqr <- mean(pyclone.vi.patient[pyclone.vi.patient$median < 4, ]$IQR);            # 0.5
pyc.abo4.iqr <- mean(pyclone.vi.patient[pyclone.vi.patient$median >= 4, ]$IQR);           # 0.6666667
pyc.sr.sub4.iqr <- mean(pyclone.vi.sr.patient[pyclone.vi.sr.patient$median < 4, ]$IQR);   # 0.1642857
pyc.sr.abo4.iqr <- mean(pyclone.vi.sr.patient[pyclone.vi.sr.patient$median >= 4, ]$IQR);  # 0.8571429
pyc.mr.sub4.iqr <- mean(pyclone.vi.mr.patient[pyclone.vi.mr.patient$median < 4, ]$IQR);   # 0.09210526
pyc.mr.abo4.iqr <- mean(pyclone.vi.mr.patient[pyclone.vi.mr.patient$median >= 4, ]$IQR);  # 0.875

#### DPClust ######################################################################################
dpclust <- rbind(
    mutect2_battenberg_dpclust_sr,
    strelka2_battenberg_dpclust_sr,
    somaticsniper_battenberg_dpclust_sr
    );

## Statistical evaluation
# DPClust average number of subclones across patients and across SNV callers 
dpc.ave <- mean(dpclust$n_clones); # 3.728571

# DPClust stats by patient and per SNV caller
dpclust.patient <- setDT(dpclust)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# DPClust average IQR, and average sd across patients and per SNV caller
dpclust.stats <- setDT(dpclust.patient)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = sd(sd)
        ),
    by = list(pipeline)
    ];

# DPCLust average IQR of patient with median < 4 (high number of) subclones
dpc.sub4.iqr <- mean(dpclust.patient[dpclust.patient$median < 4, ]$IQR);   # 0.175
dpc.abo4.iqr <- mean(dpclust.patient[dpclust.patient$median >= 4, ]$IQR);  # 0.4545455

#### PhyloWGS #####################################################################################
phylowgs <- rbind(
    mutect2_battenberg_phylowgs_sr,
    strelka2_battenberg_phylowgs_sr,
    somaticsniper_battenberg_phylowgs_sr
    );

## Statistical evaluation
# PhyloWGS average number of subclones across patients and across SNV callers 
wgs.ave <- mean(phylowgs$n_clones); # 1.957447

# PhyloWGS stats by patient and per SNV caller
# No median for PhyloWGS because of inconsistent number of patients due to seed failure
phylowgs.patient <- setDT(phylowgs)[,
    list(
        median = NaN,
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones)
        ),
    by = list(patient, pipeline)
    ];

# PhyloWGS average IQR, and average sd across patients and per SNV caller
phylowgs.stats <- setDT(phylowgs.patient)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = sd(sd)
        ),
    by = list(pipeline)
    ];

# PhyloWGS average IQR of patient with median < 4 (high number of) subclones
# No median for PhyloWGS because of inconsistent number of patients due to seed failure
wgs.sub4.iqr <- mean(phylowgs.patient[phylowgs.patient$median < 4, ]$IQR);   # NaN
wgs.abo4.iqr <- mean(phylowgs.patient[phylowgs.patient$median >= 4, ]$IQR);  # NaN

#### Table2_StatsByPatient ########################################################################
# Subclone count stats by patient and per SRC algorithm and SNV caller pairing
stats.by.patient <- rbind(
    pyclone.vi.patient,
    pyclone.vi.sr.patient,
    pyclone.vi.mr.patient,
    dpclust.patient,
    phylowgs.patient
    );

#### Table3_StatsByPipeline #######################################################################
# Subclone count stats by patient and per SRC algorithm across SNV callers
pyclone.vi.pipeline <- setDT(pyclone.vi)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones),
        src = 'PyClone-VI'
        ),
    by = list(patient)
    ];

pyclone.vi.sr.pipeline <- setDT(pyclone.vi.sr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones),
        src = 'PyClone-VI-sr'
        ),
    by = list(patient)
    ];

pyclone.vi.mr.pipeline <- setDT(pyclone.vi.mr)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones),
        src = 'PyClone-VI-mr'
        ),
    by = list(patient)
    ];

dpclust.pipeline <- setDT(dpclust)[,
    list(
        median = median(n_clones),
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones),
        src = 'DPClust'
        ),
    by = list(patient)
    ];

phylowgs.pipeline <- setDT(phylowgs)[,
    list(
        median = NaN,
        IQR = IQR(n_clones),
        mean = mean(n_clones),
        sd = sd(n_clones),
        src = 'PhyloWGS'
        ),
    by = list(patient)
    ];

# overview of stats by 
stats.by.pipeline <- rbind(
    pyclone.vi.pipeline,
    pyclone.vi.sr.pipeline,
    pyclone.vi.mr.pipeline,
    dpclust.pipeline,
    phylowgs.pipeline
    );

#### RandomSeed_SupplementaryData.xlsx ############################################################
write.xlsx(
    number.of.subclones, 
    file = "RandomSeed_SupplementaryTables.xlsx", 
    sheetName = "Table1_NumberOfSubclones", 
    col.names=TRUE, row.names=FALSE, append = TRUE
    );

write.xlsx(
    stats.by.patient, 
    file = "RandomSeed_SupplementaryTables.xlsx", 
    sheetName = "Table2_StatsByPatient", 
    col.names=TRUE, row.names=FALSE, append = TRUE
    );

write.xlsx(
    stats.by.pipeline, 
    file = "RandomSeed_SupplementaryTables.xlsx", 
    sheetName = "Table3_StatsByPipeline", 
    col.names=TRUE, row.names=FALSE, append = TRUE
    );

#### RandomSeed_stats.txt #########################################################################
# Average IQR, and average sd by SRC algorithm 
stats.by.src <- setDT(stats.by.pipeline)[,
    list(
        mean_IQR = mean(IQR),
        mean_sd = mean(sd)
        ),
    by = list(src)
    ];
colnames(stats.by.src)[1] = 'pipeline';

stats.analysis <- rbind(
    stats.by.src,
    pyclone.vi.stats,
    pyclone.vi.sr.stats,
    pyclone.vi.mr.stats,
    dpclust.stats,
    phylowgs.stats
    );

#### Seed Failure Rates ###########################################################################
# Average per patient failure across the three PhyloWGS pipelines
wgs.fail.patient <- count(phylowgs, patient);
wgs.fail.rates <- 1 - wgs.fail.patient$n / 30;

# Average per seed failure across the three PhyloWGS pipelines
wgs.fail.seed <- count(phylowgs, seed);
wgs.fail.seed.rates <- 1 - wgs.fail.seed$n / 42;

# overall failure rate of 89.5%
# probability of a seed failing ~10.5%. 
# binomial test to find out at which point we would think the seed "fails more than expected by chance"
# binom.test(105, 1000, alternative = 'greater', 0.05);

N = 105:1000
names(N) = 105:1000
prb = unlist(lapply(N, function(x){sum(dbinom(105:x, x, 0.895))}))
prb[prb <= 0.05]
prb # 111

# P-values of failure rates
# x failures, n trials, with p hypothesized probability of failure
binom.test(238,1000,p=0.105,
           alternative ="greater",
           conf.level = 0.95) # 2.2e-16
binom.test(214,1000,p=0.105,
           alternative ="greater",
           conf.level = 0.95) # 2.2e-16
binom.test(167,1000,p=0.105,
           alternative ="greater",
           conf.level = 0.95) # 1.653e-09
binom.test(143,1000,p=0.105,
           alternative ="greater",
           conf.level = 0.95) # 0.000106

#### Figure 3 evaluation ##########################################################################
# mode function
get.mode <- function(s) {
    uniq <- unique(s)
    uniq[which.max(tabulate(match(s, uniq)))]
    };

# function to see if patient gets the mode 
patient.get.mode <- function(pipeline) {
    pipeline.mode <- setDT(pipeline)[,list(mode = get.mode(n_clones), gets_mode = n_clones == get.mode(n_clones)), by = list(patient)];
    counts <- count(pipeline.mode, gets_mode)
    print(pipeline.mode)
    return(counts)
    };

# function to see if seed gets the mode 
seed.get.mode <- function(pipeline) {
    pipeline.mode <- setDT(pipeline)[,list(mode = get.mode(n_clones), gets_mode = n_clones == get.mode(n_clones)), by = list(seed)];
    counts <- count(pipeline.mode, gets_mode)
    print(pipeline.mode)
    return(counts)
    };

# Stats of how many patients get the mode subclone count
patient.get.mode(pyclone.vi);                              # 261/420 => 62.1%
patient.get.mode(pyclone.vi.sr);                           # 276/420 => 65.7%
patient.get.mode(pyclone.vi.mr);                           # 157/210 => 74.8%
patient.get.mode(mutect2_battenberg_pyclone_vi_sr);        # 107/140 => 76.4%
patient.get.mode(mutect2_battenberg_pyclone_vi_mr);        # 62/70   => 88.6%
patient.get.mode(strelka2_battenberg_pyclone_vi_sr);       # 111/140 => 79.3%
patient.get.mode(strelka2_battenberg_pyclone_vi_mr);       # 58/70   => 82.6%
patient.get.mode(somaticsniper_battenberg_pyclone_vi_sr);  # 128/140 => 91.4%
patient.get.mode(somaticsniper_battenberg_pyclone_vi_mr);  # 66/70   => 94.3%

patient.get.mode(dpclust);                                 # 230/420 => 54.8%
patient.get.mode(mutect2_battenberg_dpclust_sr);           # 125/140 => 89.3%
patient.get.mode(strelka2_battenberg_dpclust_sr);          # 106/140 => 75.7%
patient.get.mode(somaticsniper_battenberg_dpclust_sr);     # 111/140 => 79.3%

patient.get.mode(phylowgs);                                # 198/376 => 52.7%
patient.get.mode(mutect2_battenberg_phylowgs_sr);          # 90/118  => 76.3%
patient.get.mode(strelka2_battenberg_phylowgs_sr);         # 96/121  => 79.3%
patient.get.mode(somaticsniper_battenberg_phylowgs_sr);    # 113/137 => 82.5%

# Stats of how many seeds get the mode subclone count
seed.get.mode(pyclone.vi);                                  # 175/420 => 41.7%
seed.get.mode(pyclone.vi.sr);                               # 168/420 => 40%
seed.get.mode(pyclone.vi.mr);                               # 102/210 => 48.6%
seed.get.mode(mutect2_battenberg_pyclone_vi_sr);            # 58/140  => 41.4%
seed.get.mode(mutect2_battenberg_pyclone_vi_mr);            # 30/70   => 42.9%
seed.get.mode(strelka2_battenberg_pyclone_vi_sr);           # 53/140  => 37.9%
seed.get.mode(strelka2_battenberg_pyclone_vi_mr);           # 30/70   => 42.9%
seed.get.mode(somaticsniper_battenberg_pyclone_vi_sr);      # 95/140  => 67.9%
seed.get.mode(somaticsniper_battenberg_pyclone_vi_mr);      # 42/70   => 60.0%

seed.get.mode(dpclust);                                     # 108/420 => 25.7%
seed.get.mode(mutect2_battenberg_dpclust_sr);               # 53/140  => 37.9%
seed.get.mode(strelka2_battenberg_dpclust_sr);              # 42/140  => 30%
seed.get.mode(somaticsniper_battenberg_dpclust_sr);         # 68/140  => 48.6%

seed.get.mode(phylowgs);                                    # 174/376 => 46.3%
seed.get.mode(mutect2_battenberg_phylowgs_sr);              # 45/118  => 38.1%
seed.get.mode(strelka2_battenberg_phylowgs_sr);             # 50/121  => 41.3%
seed.get.mode(somaticsniper_battenberg_phylowgs_sr);        # 100/137 => 23.0%
