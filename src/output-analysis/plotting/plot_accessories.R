### plot_accessories.R ############################################################################
# colour schemes, seeds and samples for project-SRC-RandomSeed

### SEEDS #########################################################################################
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

### SR COHORT #####################################################################################
# Primary tumours
# 'ILHNLNEV000001-T001-P01-F'
# 'ILHNLNEV000002-T001-P01-F'
# 'ILHNLNEV000003-T001-P01-F'
# 'ILHNLNEV000004-T001-P01-F'
# 'ILHNLNEV000005-T001-P01-F'
# 'ILHNLNEV000006-T001-P01-F'
# 'ILHNLNEV000007-T001-P01-F'
# 'ILHNLNEV000008-T001-P01-F'
# 'ILHNLNEV000009-T001-P01-F'
# 'ILHNLNEV000010-T001-P01-F'
# 'ILHNLNEV000011-T001-P01-F'
# 'ILHNLNEV000012-T001-P01-F'
# 'ILHNLNEV000013-T001-P01-F'
# 'ILHNLNEV000014-T001-P01-F'

patients.sr <- c(
    'P01',
    'P02',
    'P03',
    'P04',
    'P05',
    'P06',
    'P07', 
    'P08',
    'P09',
    'P10',
    'P11',
    'P12',
    'P13',
    'P14'
    );

### MR COHORT #####################################################################################
# Primary tumours and lymph one and two
# 'ILHNLNEV000001'
# 'ILHNLNEV000002'
# 'ILHNLNEV000003'
# 'ILHNLNEV000006'
# 'ILHNLNEV000007'
# 'ILHNLNEV000012'
# 'ILHNLNEV000014'
patients.mr <- c(
    'P01',
    'P02',
    'P03',
    'P06',
    'P07',
    'P12',
    'P14'
    );

### COLOUR SCHEME #################################################################################
# plot_num_subclones_box.R
# colour scheme for pipelines
pipeline.colour.scheme <- c(
    'DPClust' = '#f567637f',
    'PyClone' = '#cae5ff7f',
    'PhyloWGS' = '#4a4ba67f'
    );

# subclone_relative_seed_variability.R
# colour scheme for clonality
clonality.colour.scheme <- c(
    'monoclonal' = 'pink',
    'polyclonal' = '#825EBC',
    'polytumour' = '#C681D8'
    );

### CLONALITY LEGENDS ############################################################################
# subclone_relative_seed_variability.R
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

### SRC LEGENDS #################################################################################
# plot_num_subclones_box.R
# SRC algorithm legend
algorithm.legends <- list(
    legend = list(
        colours = pipeline.colour.scheme[1:3],
        labels = c('DPClust', 'PyClone-VI', 'PhyloWGS'),
        title = expression(bold(underline('SRC Algorithm'))),
        lwd = 0.1
        )
    );

algorithm.legends.grob <- legend.grob(
    legends = algorithm.legends,
    label.cex = 0.75,
    title.just = 'left'
    );
