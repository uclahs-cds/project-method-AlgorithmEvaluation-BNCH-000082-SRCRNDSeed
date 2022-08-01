# Impact of seed selection for subclonal reconstruction solutions

The project goal is to quantify: 
1. How SRC results vary depending on the combination of SRC-tools
2. How SRC results vary depending on the initializing random seed

## Description

In this project, we have expanded the subclonal reconstruction pipeline https://github.com/uclahs-cds/pipeline-call-SRC to accept the output of multiple mutation callers.

We have integrated 4 additional mutation callers (Mutect2 single-sample mode, SomaticSniper, Strelka2, Battenberg) by creating parsers that extract variant data from the different tools' output. The parsers can be found here https://github.com/uclahs-cds/tool-SRC-util. 

## Random seed selection

### Generating random seeds:

### Chosen random seeds:

## Running the pipeline

### Pipeline template files:

Template file path: `/hot/project/method/AlgorithmEvaluation/BNCH-000082-SRCRNDSeed/pipeline-call-src/templates/`

Config file: `./template.config`
Yaml file: `./template.yaml`
Submission script: `./template_submission_script.sh`

### Tested pipeline combinations:

- [] MuTect2-Battenberg-PyClone-VI
- [] SomaticSniper-Battenberg-PyClone-VI
- [] Strelka2-Battenberg-PyClone-VI

### Results:


## License

Author: Anna Neiman-Golden(aneimangolden@mednet.ucla.edu), Philippa Steinberg(psteinberg@mednet.ucla.edu)

[This project] is licensed under the GNU General Public License version 2. See the file LICENSE.md for the terms of the GNU GPL license.

<one line to give the project/program's name and a brief idea of what it does.>

Copyright (C) 2021 University of California Los Angeles ("Boutros Lab") All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
