#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if (length(args)==0){
	stop("Usage: read_domtblout.R <domtblout hmmsearch output> <output file name> \n")
}else{
	rl <- readLines(args[1])
	rl <- rl[which(!grepl("^\\#",rl))]
	rl <- gsub("[ ]+"," ",rl)
	lst <- strsplit(rl," ")
	query<-sapply(lst,function(x){x[1]})
	tlen <- sapply(lst,function(x){x[3]})
	hit<-sapply(lst,function(x){x[4]})
	pfmID<-sapply(lst,function(x){x[5]})
	qlen <- sapply(lst,function(x){x[6]})
	eval<-as.numeric(sapply(lst,function(x){x[13]}))
	score<-as.numeric(sapply(lst,function(x){x[14]}))
	hst<-as.numeric(sapply(lst, function(x){x[16]}))
	hen<-as.numeric(sapply(lst, function(x){x[17]}))
	ast<-as.numeric(sapply(lst, function(x){x[18]}))
	aen<-as.numeric(sapply(lst,function(x){x[19]}))
	est<-as.numeric(sapply(lst, function(x){x[20]}))
	een<-as.numeric(sapply(lst, function(x){x[21]}))
	desc<-sapply(lst,function(x){paste(x[23:length(x)],collapse = " ")})

	hmmer.table<-data.frame(
	      Query=query,
	      Tlen = tlen,
				Hit=hit,
				PfamID=pfmID,
				Qlen = qlen,
				Evalue=eval,
				Score=score,
				HmmStart=hst,
				HmmEnd=hen,
				AliStart=ast,
				AliEnd=aen,
				EnvStart=est,
				EnvEnd=een,
				Description=desc,
				stringsAsFactors = F)

	write.table(hmmer.table, 
		file = args[2], 
		quote = FALSE, 
		sep = "\t", 
		row.names=FALSE)

	cat(paste0("DONE! File written at ", normalizePath(args[2])))
}


