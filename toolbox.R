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

