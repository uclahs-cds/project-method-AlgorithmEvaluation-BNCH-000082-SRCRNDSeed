# Impact of seed selection for subclonal reconstruction solutions

The project goal is to quantify: 
1. How SRC results vary depending on the combination of SRC-tools
2. How SRC results vary depending on the initializing random seed

## Description

In this project, we have expanded the subclonal reconstruction pipeline https://github.com/uclahs-cds/pipeline-call-SRC to accept output of multiple mutation callers.

We have integrated 3 new mutation callers (SomaticSniper, Strelka2, Battenberg) by creating parsers that extract variant data from different tools. The parsers can be found here https://github.com/uclahs-cds/tool-SRC-util. 

How we generated random seeds: 

Pipeline combinations tested:
- [] MuTect2-Battenberg-PyClone-VI
- [] SomaticSniper-Battenberg-PyClone-VI
- [] Strelka2-Battenberg-PyClone-VI

## Running the pipeline

Config file template: 
Yaml file template: 


## License

Author: Name1(username1@mednet.ucla.edu), Name2(username2@mednet.ucla.edu)

[This project] is licensed under the GNU General Public License version 2. See the file LICENSE.md for the terms of the GNU GPL license.

<one line to give the project/program's name and a brief idea of what it does.>

Copyright (C) 2021 University of California Los Angeles ("Boutros Lab") All rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
