# R-scripts for some easy analyses
Once you clone this repository, is recommended to change the permissions to make them excecutable, and if you want you can add them to the $PATH of your system.
Something like..

```bash
git clone https://github.com/iferres/Rscripts

cd Rscripts/

chmod 755 *.R

sudo cp *.R /usr/local/bin/
```

## parseBlastResult.R
This script takes a blast output file, a qcov and a pid thresholds, and returns in stout the hits which pass the filters.
I don't remember how was the format of the blast output supposed to be, update on this soon :)


## read_domtblout.R 
Read a hmmsearch domtblout output, and return to the second argument (a file) a parseable tab separated value file.
