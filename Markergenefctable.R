
# Function name: markergenefctable
# Version: 1.0
# Developer: fengqq
# Description: This is a R function for generating a data frame with the logfc values of only the genes of interest from the output marker gene file of  FindAllMarkers @Seurat package.
# Input: two csv files: markergenelist.csv from FindAllMarkers & markers.csv with gene of interested
# Output: one dataframe with the fc value of gene of interest from different clusters

#User guide:
 # Input two csv files
  #File1 = markergenefc.csv
  #example:
  #p_val	avg_logFC	pct.1	pct.2	p_val_adj	cluster	gene
  #0	1.40639125	0.678	0.167	0	0	Igfbp4

  #File2 = markergenelist.csv
  #example:
  #Naive	Tcm	Tem-cd8	Tem-cd4	activation/Co-stimulatory	Cytokine and effector	Exhasusted/inhibitory	Metabolism	Th1	Treg	Th2
  #Ccr9	Ccr7	Il7r	Itgb1	Cd28	Ccl3	Entpd1	Gapdh	Ifngr1	Foxp3	Il4
  #Ccr7	Sell	Cd44	S100a4	Icos	Prf1	Havcr2		Il18r1	Ikzf2	Il5

  #fine this line at bottom, replace the the file names between quotation markers with your file name
    #markergenefc <- markergenefctable("filename1.csv", "filename2.csv")



markergenefctable <- function(markergenefc, markergenelist){
  options(stringsAsFactors = F)
  markergene <- read.csv(markergenefc, header = T)
  markergene <- markerfc <- markergene[, c('avg_logFC', 'cluster', 'gene')]
  genelist <- read.csv(markergenelist, header = T)
  
  for(i in (1:ncol(genelist))){
    assign(paste(names(genelist)[i],"list",sep="_"), genelist[,i][nchar(genelist[ ,i])>0])
    len = length(get(paste(names(genelist)[i],"list",sep="_")))
    assign(
      paste(names(genelist)[i],"data",sep="_"), 
      data.frame('ID'= (1:len),'gene' = get(paste(names(genelist)[i],"list",sep="_")))
    )
    ls <- get(paste(names(genelist)[i],"list",sep="_"))
    da <- get(paste(names(genelist)[i],"data",sep="_"))
    da$ID = names(genelist)[i]
    
    for (j in (0:23)){
      markerfc <- markergene[markergene$gene %in% ls & markergene$cluster == j, ][ , c(1, 3)]
      da <- merge(da, markerfc, by = "gene", all = T)
      names(da)[j+3] <- paste('cluster', j , sep = '')
      
      assign(
        paste(names(genelist)[i],"data",sep="_"), 
        da
      )
    }
  }
  
  
  total = get(paste(names(genelist)[1],"data",sep="_"))
  
  
  for (k in (2:ncol(genelist))) {
    df <- get(paste(names(genelist)[k],"data",sep="_"))
    total<-rbind(total,df)
  }
  
  total[is.na(total)] <- 0
  return(total)
}

markergenefc <- markergenefctable("filename1.csv", "filename2.csv")