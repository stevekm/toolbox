#!/usr/bin/env Rscript

tsprintf <- function(fmt, ...){
    # print a formatted message with timestamp
    m <- sprintf(fmt, ...)
    message(sprintf('[%s] %s', format(Sys.time(), "%H:%M:%S"), m))
}

remove_empty_str <- function(x){
    # remove empty strings from character vector
    x <- x[which(! x %in% "")]
    return(x)
}

get_numlines <- function(input_file, skip = NA) {
    # count the number of lines in a file
    # skip = integer number to subtract from line count e.g. to skip header (doesn't actually prevent lines from being read)
    num_lines <- length(readLines(input_file))
    if(!is.na(skip)) num_lines <- num_lines - as.numeric(skip)
    return(num_lines)
}

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

chrom_rownames2cols <- function(df){
    # split rownames into separate columns for chromosome coordinates
    # chr10:100026989-100027328
    df_chrom <- as.data.frame(do.call(rbind, strsplit(rownames(df), ':')))
    df_chrom <- cbind(df_chrom[1], as.data.frame(do.call(rbind, strsplit(as.character(df_chrom$V2), '-'))))
    colnames(df_chrom) <- c("chrom", "start", "stop")
    df <- cbind(df_chrom, df)
    return(df)
}

sanitize_SQLite_colnames <- function(df){
    # clean the column names in a dataframe for use in SQLite
    bad_chars <- c('.', '-')
    for(bad_char in bad_chars){
        colnames(df) <- gsub(pattern = bad_char, replacement = '_', x = colnames(df), fixed = TRUE)
    }
    return(df)
}

add_uid <- function(df){
    # add a unique ID column 'uid' to a dataframe
    library("digest")
    df[["uid"]] <- apply(X = df, MARGIN = 1, digest)
    return(df)
}


sysinfo <- function(){
    # print custom information about the system

        # check if 'mycat' is loaded in case I copy/pasted this from elsewhere
    if( ! exists('mycat')) mycat <- function(text){cat(gsub(pattern = "\n", replacement = "  \n", x = text))}

    # system info for use on Linux with GNU tools installed
    # mycat(sprintf("System:\n%s\n%s", system("hostname", intern = TRUE), system("uname -srv", intern = TRUE)))
    # mycat(sprintf("System user:\n%s", system("whoami", intern = TRUE)))
    
    # dir
    # mycat(sprintf("System location:\n%s", system('pwd', intern = T, ignore.stderr = TRUE)))
    mycat(sprintf("System location:\n%s", getwd()))
    
    
    # repo info
    mycat(sprintf("Git Remote:\n%s\n", system('git remote -v', intern=T)))
    mycat(sprintf("Git branch and commit\n%s", system('printf "%s: %s" "$(git rev-parse --abbrev-ref HEAD)" "$(git rev-parse HEAD)"', 
                                                      intern = TRUE,  ignore.stderr = TRUE)))
    
    # date time
    mycat(sprintf("Time and Date of report creation:\n%s", system("date", intern = TRUE)))
    
    # R system info, packages, etc
    print(sessionInfo())
    print(Sys.info())
}

mytime <- function(){
    if( ! exists('mycat')) mycat <- function(text){cat(gsub(pattern = "\n", replacement = "  \n", x = text))}
    mycat(sprintf("Time: %s", date()))
}


concat_df <- function(df1, df2){
    # rbind two df's, check that the first one has rows
    if(nrow(df1) < 1){
        df <- df2
    } else {
        df <- rbind(df1, df2)
    }
    return(df)
}
