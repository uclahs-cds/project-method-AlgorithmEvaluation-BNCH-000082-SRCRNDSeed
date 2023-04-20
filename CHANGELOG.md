# Changelog
All notable changes to the pipeline running and analysis of *project-AlgorithmEvaluation-BNCH-000082-SRCRNDSeed*.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
### Changed
- Changed something but it is not part of the last release.

---

## [0.0.1] - YYYY-MM-DD
### Added
- For new analysis or config files.
- Added test script for pipeline run using Mutect2.
- Added test script for pipeline run using Strelka2.
- Added test script for pipeline run using SomaticSniper.
- Added script to run Strelka2-Battenberg-Pyclone-VI pipeline single-sample mode.
- Added script to run Strelka2-Battenberg-Pyclone-VI pipeline multi-sample mode.
- Added script to run Strelka2-Battenberg-DPClust pipeline single-sample mode.
- Added script to parse patient, seed and number of subclones from Strelka2-Battenberg-PyClone-VI pipeline single-sample mode output.
- Added script to parse patient, seed and number of subclones from Strelka2-Battenberg-DPClust pipeline single-sample mode output.
- Added script to parse patient, seed and number of subclones from Strelka2-Battenberg-PyClone-VI pipeline multi-sample mode output.
- Added script for scatterplots of relative seed variability for DPClust, PyClone-VI single-sample and multi-sample mode.

### Changed
- For changes in existing config files, commands and analyses.
- Changed item 1.
- Changed README to include changed file directories and project details. 

### Deprecated
- For soon-to-be removed out-of-date configs and analyses.

### Removed
- For now removed configs and analyses.  

### Fixed
- For any bug fixes in existing config files, commands and analyses.
- Fixed item 1.

### Security
- In case of vulnerabilities.

## [Unreleased] - 2022-11-16
### Added
- new script sr_strelka2_battenberg_dpclust_submission_script.sh
- new script sr_strelka2_battenberg_pyclone-vi_submission_script.sh

### Removed
- Old script ss_strelka2_battenberg_dpclust_submission_script.sh

## [Unreleased] - 2022-11-28
### Added
- Added new script sr_somaticsniper_battenberg_pyclone-vi_submission_script.sh
- Added new script sr_somaticsniper_battenberg_dpclust_submission_script.sh
- Added new script mr_strelka2_battenberg_pyclone-vi_submission_script.sh
- Added new script sr_mutect2_battenberg_dpclust_submission_script.sh

### Removed
- Removed old script ms_strelka2_battenberg_pyclone_submission_script.sh

## [Unreleased] - 2022-12-04
### Added
- Added new script sr_mutect2_battenberg_pyclone-vi_submission_script.sh

## [Unreleased] - 2022-12-05
### Added
- Added new script mr_somaticsniper_battenberg_pyclone-vi_submission_script.sh
- Added new script mr_mutect2_battenberg_pyclone-vi_submission_script.sh

### Removed
- Removed old script sr_strelka2_battenberg_pyclone-vi_submission_script.sh

## [Unreleased] - 2022-03-07
### Added
- Added new script sr_mutect2_battenberg_phylowgs_submission_script.sh

## [Unreleased] - 2022-04-13
### Added
- Added new script sr_strelka2_battenberg_phylowgs_submission_script.sh

## [Unreleased] - 2022-04-17
### Added
- Added new plotting script subclone_relative_seed_variability.R