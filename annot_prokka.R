#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

if (Sys.which('prokka')==""){
  
  stop('prokka is not in your $PATH.')
  
}

printUsage <- function(){
  
  cat("Annotate a bunch of fna files with prokka (wrapper).\n")
  
  cat("Uses the same string for '--prefix', '--locustag' and '--outdir' for simplification.\n\n")
  
  cat('\tUsage: annot_prokka.R <cpus [int]> <fasta files [str]>\n\n')
  
  cat('Example: annot_prokka.R 4 ./*.fna\n')
  
  
}

if (length(args)==0){
  
  printUsage()
  
}else{
  
  
  cpus <- args[1]
  
  if( suppressWarnings(is.na(as.integer(cpus))) ){ 
    
    printUsage()
    
    stop('Error: First argument (cpus) is not an integer.\n')
    
  }
  
  
  files <- args[-1]
  
  if (length(files)==0 | !all(file.exists(files))){ 
    
    printUsage()
    
    stop('Error: Provide fasta files.\n')
  
  }
  
  
  pb <- txtProgressBar(min = 0, max = length(files))
  for (i in seq_along(files)){

    outdir <- sub('[.]\\w+$', '', files[i])
    
    prefix <- rev(strsplit(normalizePath(files[i]), '/')[[1]])[1]
    
    prefix <- sub('[.]\\w+$', '', prefix)
    
    run <- paste0('prokka --quiet --outdir ',outdir, 
                  ' --prefix ',prefix,
                  ' --locustag ', prefix,
                  ' --cpus ',cpus,' ',
                  files[i])
    
    system(run)
    
    setTxtProgressBar(pb, i)
    
  }
  
  close(pb)
  
}


