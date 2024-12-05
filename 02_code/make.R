# Generate Kate Champions extension to Gerber et al 2009

# Set working directory ----
#setwd("../econ280project")

# Run regressions ----
source("02_code/extension_code.R")

# Generate outputs ----
# WAIT!!! You need to set a working directory in 02_code/extension_writeup.Rmd 
# in the print_table code chunk
# Sorry but R markdown is annoying.
rmarkdown::render("02_code/extension_writeup.Rmd", 
                  output_file = "/Users/katechampion/Documents/UCSD/ECON280/econ280project/03_results/extension_writeup.pdf",
                  envir = new.env())
