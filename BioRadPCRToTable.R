# Function name: BioRadPCRToTable
# Version: 1.0
# Developer: fengqq
# Description: This is a R function for generating a table of 96 or 384 layout from the orignial Cq file generated the biorad qPCR instrument
# Input: 1 csv files: Cq.csv from Biorad qPCR
# Output: one dataframe with the ct values with 96 well or 384 layout
# Use: fine this line at bottom, replace the the file name between quotation markers with your file name
  # Cqtable <- BioRadPCRToTable('Cq.csv')

BioRadPCRToTable <- function(file){
  options(stringsAsFactors = F)
  #Read file and get the information about 96 well plate or 384 well plate.
  a <- read.csv(file)
  n <- nrow(a)
  
  if (n == 96){
  #make the matrix for gatthering data.
  dataf <- matrix(1:96, c(12, 8))
  #paste the data to right locations
  for (i in 1:8) {
    dataf[, i] <- a$Cq[(12*(i-1)+1) : (12*(i-1)+12)]
  }
  return(dataf)
  } 
  else if (n == 384){
	#make the matrix for gatthering data.
    dataf <- matrix(1:384, c(24, 16))
	#paste the data to right locations
    for (i in 1:16) {
      dataf[, i] <- a$Cq[(24*(i-1)+1) : (24*(i-1)+24)]
    } 
    return(dataf)
    }
  else{
    print('Non-standard result')
  }
  }
# Sample code
Cqtable <- BioRadPCRToTable('Cq.csv')



