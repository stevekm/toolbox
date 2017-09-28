#!/usr/bin/env Rscript

library("RSQLite")

tsprintf <- function(fmt, ...){
    # print a formatted message with timestamp
    m <- sprintf(fmt, ...)
    message(sprintf('[%s] %s', format(Sys.time(), "%H:%M:%S"), m))
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

df_sqlite_names <- function(df){
    # creates character string of the column names for use in SQLite statement
    sql_names <- sprintf('"%s"', names(df))
    return(sql_names)
}

df_sqlite_param_names <- function(df){
    # creates character string of the column names for use in SQLite prepared statement
    sql_names <- sprintf('@%s', names(df))
    return(sql_names)
}


create_table_with_primary_key <- function(db_con, table_name, df, key_colname = "uid"){
    # create a table in a SQLite database and set the primary key for the table
    tsprintf("Creating table '%s' in database and adding all entries...", table_name)
    if(! table_name %in% dbListTables(db_con)){
        sql_names <- df_sqlite_names(df)
        sql <- sprintf("CREATE TABLE %s(%s, primary key(%s))",
                       table_name,
                       paste(sql_names, collapse = ", "),
                       key_colname)
        # message(sql)
        dbGetQuery(db_con, sql)
        dbWriteTable(db_con, table_name, df, append = TRUE, row.names = FALSE)
    } else {
        tsprintf("Table '%s' already exists in database, skipping...", table_name)
    }
}


insert_or_ignore <- function(db_con, table_name, df, speedup = FALSE){
    # insert entries from the df into the db if they're not already present
    tsprintf("Inserting new entries into table '%s' in database...", table_name)
    sql_names <- df_sqlite_names(df)
    param_names <- df_sqlite_param_names(df)
    
    sql <- sprintf('INSERT OR IGNORE INTO %s(%s) VALUES (%s)',
                   table_name,
                   paste(sql_names, collapse = ", "),
                   paste(param_names, collapse = ", "))
    # message(sql)
    if(speedup == TRUE){
        dbGetQuery(db_con, "PRAGMA synchronous = OFF") 
        dbGetQuery(db_con, "PRAGMA journal_mode = OFF")
    }
    
    dbGetPreparedQuery(db_con, sql, bind.data=df)
}

sqlite_count_table_rows <- function(db_con, table_name){
    sql <- sprintf('SELECT COUNT(*) FROM %s', table_name)
    row_count <- unlist(dbGetQuery(db_con, sql))[["COUNT(*)"]]
    return(row_count)
}


add_df_to_db <- function(db_con, table_name, df){
    # add dataframe to SQLite database with primary key set
    # if the table does not exist; create it
    # if the table exists; insert only new entries
    
    tsprintf("Adding '%s' to database...", table_name)
    
    # add 'uid' unique ID column and clean the column names
    df <- add_uid(df)
    df <- sanitize_SQLite_colnames(df)

    if( ! table_name %in% dbListTables(db_con)){
        # add table if its not present
        tsprintf("Table '%s' does not exist, adding table and data...", table_name)
        create_table_with_primary_key(db_con = db_con,
                                      table_name = table_name,
                                      df = df)
    } else {
        # if the table already exists, add its entries
        num_rows_start <- sqlite_count_table_rows(db_con = db_con, table_name = table_name)
        
        tsprintf("Table '%s' already exists in database with %s rows", table_name, num_rows_start)
        
        tsprintf("Starting insert operation for dataframe containing %s rows...", nrow(df))

        insert_or_ignore(db_con = db_con, table_name = table_name, df = df)
        
        num_rows_end <- sqlite_count_table_rows(db_con = db_con, table_name = table_name)
        
        tsprintf("Inserting finished for table '%s', table now contains %s rows", table_name, num_rows_end)
    }
}

