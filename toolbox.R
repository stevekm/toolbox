#!/usr/bin/env Rscript

msprintf <- function(fmt, ...) {
    message(sprintf(fmt, ...))
}

mycat <- function(text){
    # print formatted text in Rmd
    cat(gsub(pattern = "\n", replacement = "  \n", x = text))
}

remove_ext <- function(input_file){
    # remove extension from filename
    old_ext <- file_ext(input_file)
    filename_base <- gsub(pattern = sprintf('.%s$', old_ext), replacement = '', x = basename(input_file))
    return(filename_base)
}

sort_bed_df <- function(df){
    # sort a bed df and remove duplicate entries
    df <- df[1:3]
    df <- df[ order(df[,1], df[,2]), ]
    df <- df[! duplicated(df), ]
    return(df)
}

