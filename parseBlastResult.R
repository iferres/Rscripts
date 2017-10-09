#!/usr/bin/env Rscript
args<-commandArgs(trailingOnly = T)

if (length(args)==0){
  stop("You must provide at least a blastp output file\n
       Usage: ./parseBlastResult.R <blastout> <qcov[0.5]> <pid[50]>\n\n")
}
if(is.na(args[2])){
  args[2]<-0.5
}
if(is.na(args[3])){
  args[3]<-50
}

read.table(args[1],header = F)->t
paste(t$V1,t$V2,sep = " ")->t$V8
sapply(unique(t$V8),function(x){grep(x,t$V8,fixed = T)})->sa
lapply(sa,function(x){t[x,]})->la

lapply(la,function(x){

  c(sum(x$V5-x$V4)/x$V6[1]>=args[2] & #qcov
    (sum(round(x$V5*x$V3))/sum(x$V5))>=args[3], #pid
    sum(x$V5-x$V4)/x$V6[1],(sum(round(x$V5*x$V3))/sum(x$V5))
  )
  
})->pass

do.call(rbind,pass)->o
colnames(o)<-c('log','qcov','pid')

if(length(which(as.logical(o[,1])))==0){
  writeLines("\nNo hits\n")
}else{
  formatC(o[which(o[,1]==1),2:3,drop=F],digits = 3)
}

