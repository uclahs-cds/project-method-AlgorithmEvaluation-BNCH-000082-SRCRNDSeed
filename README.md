# Impact of seed selection on subclonal reconstruction solutions

Project goal:
1. Quantify SRC result variability across SRC tools
2. Quantify SRC result variability across initializing random seed


## Description

In this project, we have expanded the subclonal reconstruction pipeline https://github.com/uclahs-cds/pipeline-call-SRC to accept the output of multiple mutation callers.

We have integrated 4 additional mutation callers (MuTect2, SomaticSniper, Strelka2, Battenberg) by creating parsers that extract variant data from the different tools' output. The parsers can be found here https://github.com/uclahs-cds/tool-SRC-util.   

## Random Seed Selection

### Generating random seeds:

Generate initial seed:
`head -c 4 /dev/urandom | od -An -tu4` => `3058353505`

Generate 10 random seeds:

```
import random
random.seed(3058353505)
random.sample(range(0, 1000000), k=10)
```

### Chosen random seeds:

Generated/chosen seeds:
`[51404, 366306, 423647, 838004, 50135, 628019, 97782, 253505, 659767, 13142]`

## Tumour Sample Data:

[HNSC] Head and Neck cohort: `/hot/project/disease/HeadNeckTumor/HNSC-000084-LNMEvolution/data/`

[CPCGENE] Prostate cohort: `/hot/project/disease/ProstateTumor/PRAD-000005-293PT/`

## Tools:

sSNV-caller: `mutect2`, `strelka2`, `somaticsniper`

sCNA-caller: `battenberg`

src-tool: `pyclone-vi`, `dpclust`, `phylowgs` 

### Node selection:
- PyClone-VI: F32 (average run time 15s - 10min)
- DPClust: F32 (average run time 5min - 40min)
- PhyloWGS: F72 (average run time 5h - 13h)

## sSNV-caller and sCNA-caller results:

sSNV-caller output: 

`/hot/project/disease/HeadNeckTumor/HNSC-000084-LNMEvolution/data/SNV/<sSNV-caller>/recsnv/vcfs/` 

sCNA-caller output: 

`/hot/project/disease/HeadNeckTumor/HNSC-000084-LNMEvolution/data/<sCNA-caller>/`


## Modes:
[HNSC]
- Single region mode (sr) (run on primary tumour only)
- Multi region mode (mr) (run on primary and metastatic tumours)

[CPGENE]
- Multi region mode (mr) (run on multiple regions of primary tumour)

## Running The Pipeline

The pipeline is run for each sample and seed in both single region and multi region mode.

Templates: `/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/templates/`

### Pipeline input files:
configs: 

`/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-<sSNV-caller>-<sCNA-caller>-<src-tool>/input/config/<seed>_seed.config`

- 1 config per `seed`
- indicates `src-tool` choice and parameters
- indicates pipeline run output directory

yamls: 

`/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/<sSNV-caller>_<sCNA-caller>_yamls/<mode>/<patient_id>.yaml`

- 1 yaml per patient (multiple samples for multi region mode in the same yaml)
- path to `sSNV-caller` output
- path to `sCNA-caller` output

### Submission script:
submission script: `<mode>_<sSNV-caller>_<sCNA-caller>_<src-tool>_submission_script.sh`

### Completed pipeline combinations:

- [x] Strelka2-Battenberg-PyClone-VI (sr/mr)
- [x] Strelka2-Battenberg-DPClust (sr)
- [x] SomaticSniper-Battenberg-PyClone-VI (sr)
- [x] SomaticSniper-Battenberg-DPClust (sr)
- [x] Mutect2-Battenberg-DPClust (sr)
- [x] Mutect2-Battenberg-PhyloWGS ()

*insert pipeline overview graphic here*

### Results:

Output files:

`/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-<sSNV-caller>-<sCNA-caller>-<src-tool>/output/`

Log files:

`/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/run-<sSNV-caller>-<sCNA-caller>-<src-tool>/logs/`


## License

Author: Anna Neiman-Golden(aneimangolden@mednet.ucla.edu), Philippa Steinberg(psteinberg@mednet.ucla.edu)

[This project] is licensed under the GNU General Public License version 2. See the file LICENSE.md for the terms of the GNU GPL license.

<one line to give the project/program's name and a brief idea of what it does.>

Copyright (C) 2021 University of California Los Angeles ("Boutros Lab") All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.