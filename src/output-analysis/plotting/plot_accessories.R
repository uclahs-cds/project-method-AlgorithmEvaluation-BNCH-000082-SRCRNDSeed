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
samples.sr <- c(
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

### MR COHORT #####################################################################################
patients.mr <- c(
    'ILHNLNEV000001',
    'ILHNLNEV000002',
    'ILHNLNEV000003',
    'ILHNLNEV000006',
    'ILHNLNEV000007',
    'ILHNLNEV000012',
    'ILHNLNEV000014'
    );

### COLOUR SCHEME #################################################################################
# plot_num_subclones_box.R
# colour scheme for pipelines
pipeline.colour.scheme <- c(
    'DPClust' = '#f567637f',
    'PyClone-VI' = '#cae5ff',
    'PhyloWGS' = '#4a4ba6'
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
