#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0){
  
  cat("Annotate a bunch of fna files with prokka (wrapper).\n")
  
  cat("Uses the same string for '--prefix', '--locustag' and '--outdir' for simplification.\n\n")
  
  cat('\tUsage: annot_prokka.R <cpus [int]> <fasta files [str]>\n\n')
  
  cat('Example: annot_prokka.R PROKKA 4 ./*.fna')
  
}else{
  
  cpus <- args[1]
  if( is.na(as.integer(cpus)) ){ stop('Second argument is not an integer.') }
  
  files <- args[2:length(args)]
  if ( all(is.na(files)) ){ stop('No fasta files provided.') }
  
  
  pb <- txtProgressBar(min = 0, max = 100)
  for (i in seq_along(files)){

    outdir <- sub('[.]\\w+$', '', files[i])
    
    prefix <- rev(strsplit(normalizePath(file[i]), '/')[[1]])[1]
    
    run <- paste0('prokka --quiet --outdir ',outdir, 
                  ' --prefix ',prefix,
                  ' --locustag ', prefix,
                  ' --cpus ',cpus,
                  files[i])
    
    system(run)
    
    setTxtProgressBar(pb, i)
    
  }
  
  close(pb)
  
}


