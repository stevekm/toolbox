#!/usr/bin/env Rscript

## USAGE: barplot_file_linecounts.R /path/to/file1.txt /path/to/file2.txt ... 
## DESCRIPTION: This script will create a barplot based on the number of lines in each file

# ~~~~~ LOAD PACKAGES ~~~~~ #
library("optparse")


# ~~~~~ CUSTOM FUNCTIONS ~~~~~ #
line_count <- function(filepath){
    len <- length(readLines(filepath))
    return(len)
}


# ~~~~~ GET SCRIPT ARGS ~~~~~ #
# files <- commandArgs(TRUE)
option_list <- list(
    make_option(c("-o", "--output"), type = "character", default = "linecounts.pdf", dest = "output", 
                help="Output file for the plot PDF")
)
opt <- parse_args(OptionParser(option_list=option_list), positional_arguments = TRUE)

output_pdf <- opt$options$output
files <- opt$args


# ~~~~~ MAKE PLOT ~~~~~ #
pdf(file = output_pdf, width = 8, height = 8)
par(mar=c(5,12,4,2)) # increase y-axis margin; default is  5.1 4.1 4.1 2.1
barplot(sapply(X = files, FUN = line_count), 
        names.arg = basename(files), 
        main = "Line Count", 
        horiz = TRUE, 
        cex.names = 0.7, 
        las = 1)
dev.off()
