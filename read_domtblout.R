#!/usr/bin/Rscript
args = commandArgs(trailingOnly=TRUE)

if (length(args)==0){
	stop("Usage: read_domtblout.R <domtblout hmmsearch output> <output file name> \n")
}else{
	rl <- readLines(args[1])
	rl <- rl[which(!grepl("^\\#",rl))]
	rl <- gsub("[ ]+"," ",rl)
	lst <- strsplit(rl," ")
	query<-sapply(lst,function(x){x[1]})
	hit<-sapply(lst,function(x){x[4]})
	pfmID<-sapply(lst,function(x){x[5]})
	eval<-as.numeric(sapply(lst,function(x){x[13]}))
	score<-as.numeric(sapply(lst,function(x){x[14]}))
	st<-as.numeric(sapply(lst, function(x){x[18]}))
	en<-as.numeric(sapply(lst,function(x){x[19]}))
	desc<-sapply(lst,function(x){paste(x[23:length(x)],collapse = " ")})

	hmmer.table<-data.frame(Query=query,
				Hit=hit,
				PfamID=pfmID,
				Evalue=eval,
				Score=score,
				Start=st,
				End=en,
				Description=desc,
				stringsAsFactors = F)

	write.table(hmmer.table, 
		file = args[2], 
		quote = FALSE, 
		sep = "\t", 
		row.names=FALSE)

	cat(paste0("DONE! File written at ", normalizePath(args[2])))
}


