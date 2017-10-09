#!/usr/local/bin/Rscript

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0){
  
  cat("Convert the roary's gene_presence_absence.csv file to an abundance matrix\n")
  
  cat('\tUsage: roary_gpa2abu.R <gene_presence_absence.csv> <outname.tsv>\n')
  
}else{
  
  x <- read.csv(args[1], stringsAsFactors = FALSE)
  
  rn <- as.character(x$Gene)
  
  x <- x[, 15:ncol(x)]
  
  rownames(x) <- rn
  
  xx <- apply(x,2,function(i){
  
      vapply(i, function(j){ length(strsplit(j, '\t')[[1]]) }, 1L)
  
    })
  
  write.table(xx, 
              file = args[2], 
              quote = F, 
              sep = '\t', 
              row.names = TRUE, 
              col.names = TRUE)
  
}


