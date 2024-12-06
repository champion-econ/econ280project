---
contributors:
  - Kate Champion
---

# README

## Overview

This code reproduces an extension of Gerber, Huber, Washington 2009 that examines the heterogenity in their results by race. The original paper can be found [here](https://www.povertyactionlab.org/sites/default/files/research-paper/665%20Party%20Affiliation%2C%20Partisanship%2C%20and%20Political%20Beliefs%20%28Sept%202009%20Working%20Paper%29.pdf) and the original replication package [here](https://isps.yale.edu/research/data/d055#.Uv58CPldWBU).

## Data

There is only one data set for this repo. Original data source is the [anonymized experimental data](http://hdl.handle.net/10079/kkwh78w) from Gerber, Huber, Washington 2009 cleaned using the methods in their replication package to be ready for regression analysis. If you happen to stumble across this repo and you are not David Arnold don't use this data, just go to the original paper. 

## Instructions to Replicate

### Software Requirements 

The code is written in R 4.4.1. It requires the packages tidyverse, haven, estimatr, and modelsummary to run. It also use functions from the tinytable package which should be imported with modelsummary. The code takes a trival amount of memory and time to run and can be run on any standard computer with R. 

### Description of Code and Instructions

There are three code files in the `02_code` directory. `extension_code.R` which is an R file that takes the Gerber, Huber, Washington 2009 intermediate data, runs several regressions that are a variation of their original analysis and produces a results table. `extension_write.Rmd` which is a markdown file that generates the final PDF write up for this project. `make.R` that runs the first two files. 

There are two other files in `02_code`: `table_1.rds` which is the regression output table that is used by the markdown file and is regenerated everytime `extension_code.R` is run, and `extension_write.log` which is a log file of the markdown file being compiled. 

To replicate my results update the working directories in `make.R` and `extension_write.Rmd`* to point towards this repo on your local machine. Then run the `make.R` file in R or R studio. It may be possible to run `make.R` from the command line or other batch mode but I did not build it with that in mind so I make no gaurentees it will run that way. 

The results write up with the regression table will be saved as a PDF to the `03_results` file under the name `extension_writeup.pdf`

## References

Gerber, Alan S., Gregory A. Huber, Ebonya Washington (2010) Replication Materials for: ‘Party Affiliation, Partisanship, and Political Beliefs: A Field Experiment,’ [http://hdl.handle.net/10079/sxksnc8](http://hdl.handle.net/10079/sxksnc8). ISPS Data Archive.

*Look I know I could have probably figure out some way to set the working directory has a global variable so that way you don't have to set in the markdown file directly but ain't nobody got time for that. (I would make time for it if this was actually going to be public).
