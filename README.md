# fengqq-biodata-tools
 Some scripts for data cleanup, organiztion analysis in biomedical research.
## Introduction
 I am a researcher of biomedical sciences. I am mostly working in wet lab while also use R or python for some data cleanup or data analysis work. So clearly I am not a real/well-trained developer. I publish my code here for three reasons: 
 1 These tiny functions or small scripts are useful for me. Keeping them here will push me to well-organize the code for future use.
2 Hopefully these codes may help other people as well.
3 Comments from hardcore developers will be very helpful for me.

## Table of Content
### Markergenefctable.R
With the FindAllMarkers function in Seurat package, we can get a large data frame with lots of marker genes. We may just want to check some specific marker genes with clear biological meanings in this dataset for the purpose of indentifying clusters.
This is a R function for generating a data frame with the logfc values of only the genes of interest from the output marker gene file of FindAllMarkers @Seurat package.
### BioRadPCRToTable.R
Biorad qPCR instrument generates a table with all the samples in one column. This function will generate a table of the Cq values with 96 well or 384 well plate layout, which looks clearer for further data analysis. 